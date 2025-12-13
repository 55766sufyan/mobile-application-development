const shortid = require('shortid');

function generateOrderId() {
  const date = new Date();
  const y = date.getFullYear().toString().slice(-2);
  const m = ('0'+(date.getMonth()+1)).slice(-2);
  const d = ('0'+date.getDate()).slice(-2);
  // shortid generates lowercase - uppercasing makes it consistent
  return `ORD${y}${m}${d}${shortid.generate().toUpperCase()}`;
}

module.exports = generateOrderId;
