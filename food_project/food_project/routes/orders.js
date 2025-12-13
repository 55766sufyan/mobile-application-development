const express = require('express');
const Order = require('../models/Order');
const MenuItem = require('../models/MenuItem');
const { auth, adminOnly } = require('../middleware/auth');
const generateOrderId = require('../utils/generateOrderId');

const router = express.Router();

// Place order (user)
router.post('/', auth, async (req,res)=> {
  const { items } = req.body; // items: [{menuItemId, quantity}]
  if (!items || !Array.isArray(items) || items.length === 0) return res.status(400).json({ msg: 'No items' });
  let total = 0;
  const orderItems = [];
  for (let it of items) {
    const menu = await MenuItem.findById(it.menuItemId);
    if (!menu) return res.status(400).json({ msg: 'Menu item missing' });
    if (!menu.available) return res.status(400).json({ msg: `${menu.name} not available` });
    orderItems.push({
      menuItem: menu._id,
      name: menu.name,
      price: menu.price,
      quantity: it.quantity
    });
    total += menu.price * it.quantity;
    menu.soldCount = (menu.soldCount || 0) + it.quantity;
    await menu.save();
  }
  const orderId = generateOrderId();
  const order = new Order({ orderId, user: req.user.id, items: orderItems, totalAmount: total });
  await order.save();
  res.json(order);
});

// Get user orders or all for admin
router.get('/', auth, async (req,res)=> {
  if (req.user.isAdmin) {
    const all = await Order.find().populate('user','name email').sort({createdAt:-1});
    return res.json(all);
  }
  const orders = await Order.find({ user: req.user.id }).sort({createdAt:-1});
  res.json(orders);
});

// Get single order
router.get('/:id', auth, async (req,res)=> {
  const order = await Order.findById(req.params.id).populate('items.menuItem');
  if (!order) return res.status(404).json({ msg: 'Order not found' });
  if (!req.user.isAdmin && order.user.toString() !== req.user.id) return res.status(403).json({ msg: 'Access denied' });
  res.json(order);
});

// Admin change status
router.put('/:id/status', auth, adminOnly, async (req,res)=> {
  const { status } = req.body;
  const order = await Order.findByIdAndUpdate(req.params.id, { status }, { new: true });
  res.json(order);
});

module.exports = router;
