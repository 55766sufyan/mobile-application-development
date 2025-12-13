const express = require('express');
const Order = require('../models/Order');
const MenuItem = require('../models/MenuItem');
const { auth, adminOnly } = require('../middleware/auth');

const router = express.Router();

router.get('/', auth, adminOnly, async (req, res) => {
  try {
    const totalOrders = await Order.countDocuments();
    const revenueAgg = await Order.aggregate([{ $group: { _id: null, total: { $sum: "$totalAmount" }}}]);
    const revenue = (revenueAgg[0] && revenueAgg[0].total) || 0;

    // orders per day (last 7 days)
    const sevenDays = new Date(); sevenDays.setDate(sevenDays.getDate() - 6);
    const ordersPerDay = await Order.aggregate([
      { $match: { createdAt: { $gte: sevenDays } } },
      { $group: {
        _id: { $dateToString: { format: "%Y-%m-%d", date: "$createdAt" } },
        count: { $sum: 1 }
      }},
      { $sort: { _id: 1 } }
    ]);

    // items sold count
    const itemsAgg = await Order.aggregate([
      { $unwind: "$items" },
      { $group: { _id: "$items.menuItem", sold: { $sum: "$items.quantity" } } },
      { $lookup: { from: "menuitems", localField: "_id", foreignField: "_id", as: "menu" } },
      { $unwind: { path: "$menu", preserveNullAndEmptyArrays: true } },
      { $project: { sold: 1, name: "$menu.name" } }
    ]);

    res.json({ totalOrders, revenue, ordersPerDay, itemsSold: itemsAgg });
  } catch (err) {
    res.status(500).json({ msg: 'Server error', err });
  }
});

module.exports = router;
