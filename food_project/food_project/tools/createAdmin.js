require('dotenv').config();
const mongoose = require('mongoose');
const bcrypt = require('bcryptjs');
const User = require('../models/User');

async function createAdmin() {
  await mongoose.connect(process.env.MONGO_URI);
  const email = process.argv[2] || 'admin@example.com';
  const password = process.argv[3] || 'Admin123!';
  let user = await User.findOne({ email });
  if (user) {
    console.log('Admin already exists:', user.email);
    process.exit(0);
  }
  const salt = await bcrypt.genSalt(10);
  const passwordHash = await bcrypt.hash(password, salt);
  user = new User({ name: 'Admin', email, passwordHash, isAdmin: true });
  await user.save();
  console.log('Admin created:', email, 'password:', password);
  process.exit(0);
}

createAdmin();
