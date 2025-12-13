const express = require('express');
const MenuItem = require('../models/MenuItem');
const { auth, adminOnly } = require('../middleware/auth');

const router = express.Router();

// Get all
router.get('/', async (req,res)=> {
  const items = await MenuItem.find().sort({createdAt:-1});
  res.json(items);
});

// Admin add
router.post('/', auth, adminOnly, async (req,res)=> {
  const { name, price, imageUrl, imageBase64, description, available } = req.body;
  const item = new MenuItem({ name, price, imageUrl, imageBase64, description, available });
  await item.save();
  res.json(item);
});

// Edit
router.put('/:id', auth, adminOnly, async (req,res)=> {
  const item = await MenuItem.findByIdAndUpdate(req.params.id, req.body, { new: true });
  res.json(item);
});

// Delete
router.delete('/:id', auth, adminOnly, async (req,res)=> {
  await MenuItem.findByIdAndDelete(req.params.id);
  res.json({ msg: 'Deleted' });
});

module.exports = router;
