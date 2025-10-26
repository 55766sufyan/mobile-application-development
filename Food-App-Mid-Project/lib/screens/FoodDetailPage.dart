import 'package:flutter/material.dart';
import './homepage/list.dart';

class FoodDetailPage extends StatelessWidget {
  final int index;

  const FoodDetailPage({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Food Detail")),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: 350,
                child: Image.asset(
                  popularFoods[index]['image'],
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Left side: name + price
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              popularFoods[index]['name'],
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "\$${popularFoods[index]['price']}",
                              style: const TextStyle(
                                color: Colors.amber,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        // Right side: plus/minus buttons
                        Column(
                          children: const [
                            Icon(Icons.plus_one),
                            Icon(Icons.exposure_minus_1),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // 👇 Flexible allows wrapping without overflow
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        popularFoods[index]['detailedDescription'],
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Center(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 40),
                            SizedBox(width: 20),
                            Icon(Icons.star, color: Colors.amber, size: 40),
                            SizedBox(width: 20),
                            Icon(Icons.star, color: Colors.amber, size: 40),
                            SizedBox(width: 20),
                            Icon(Icons.star, color: Colors.amber, size: 40),
                            SizedBox(width: 20),
                            Icon(
                              Icons.star_border_outlined,
                              color: Colors.amber,
                              size: 40,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                color: Color(0xFF2A2A2A),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Total: \$50",
                      style: const TextStyle(
                        color: Colors.amber,
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.amber,
                      ),
                      onPressed: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(Icons.add, color: Colors.white, size: 30),
                            Text(
                              "Add to Cart",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
