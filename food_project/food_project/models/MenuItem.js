const mongoose = require('mongoose');

const MenuItemSchema = new mongoose.Schema({
  name: { type: String, required: true },
  price: { type: Number, required: true },
  imageUrl: { type: String },          // cloud URL (optional)
  imageBase64: { type: String },       // base64 data URL string (data:image/..;base64,...)
  description: { type: String },
  available: { type: Boolean, default: true },
  soldCount: { type: Number, default: 0 }
}, { timestamps: true });

module.exports = mongoose.model('MenuItem', MenuItemSchema);
