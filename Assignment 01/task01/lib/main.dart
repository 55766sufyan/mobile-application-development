import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MaximumBid()));
}

class MaximumBid extends StatefulWidget {
  @override
  _MaximumBidState createState() => _MaximumBidState();
}

class _MaximumBidState extends State<MaximumBid> {
  int bid = 0;
  void _increaseBid() {
    setState(() {
      bid += 50;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Biding Page")),
      body: Center(
        child: Column(
          children: [
            Text(
              "Current bid: $bid",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _increaseBid,
              child: Text("Increase Bid"),
            ),
          ],
        ),
      ),
    );
  }
}
