import 'package:flutter/material.dart';
import 'package:food_app/screens/FoodDetailPage.dart';
import 'list.dart';

class PopularSection extends StatelessWidget {
  const PopularSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Populars",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),

        SizedBox(
          height: 290,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: popularFoods.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FoodDetailPage(index: index),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF2A2A2A),
                        borderRadius: BorderRadius.circular(10),
                      ),

                      width: 150,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                bottomLeft: Radius.circular(12),
                              ),
                            ),
                            child: Image.asset(
                              popularFoods[index]['image'],
                              fit: BoxFit.cover,
                              height: 150,
                            ),
                          ),
                          Text(
                            popularFoods[index]['name'],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            popularFoods[index]['description'],
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                          Text(
                            "\$${popularFoods[index]['price']}",
                            style: TextStyle(
                              color: Colors.amber,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
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
