import 'package:flutter/material.dart';
import 'list.dart';

class Categorysection extends StatelessWidget {
  const Categorysection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Categories",
          textAlign: TextAlign.start,
          style: TextStyle(fontSize: 20),
        ),
        SizedBox(
          height: 100, 
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: Categories.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Container(
                  width: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFF2A2A2A),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Categories[index]['icon'],
                        style: TextStyle(fontSize: 28),
                      ),
                      SizedBox(height: 8),
                      Text(
                        Categories[index]['title'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
