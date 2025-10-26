import 'package:flutter/material.dart';
import 'package:food_app/screens/FoodDetailPage.dart';
import 'package:food_app/screens/homepage/categorySection.dart';
import 'package:food_app/screens/homepage/newestSection.dart';
import 'package:food_app/screens/homepage/popularSection.dart';

class homeScreen extends StatelessWidget {
  const homeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Products();
  }
}

class Products extends StatefulWidget {
  const Products({super.key});

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: 'Enter a search Items',
                prefixIconColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            // Category Section
            Categorysection(),
            SizedBox(height: 20),

            // Popular Section
            PopularSection(),
            SizedBox(height: 20),

            // Newest Section
            NewestSection(),
          ],
        ),
      ),
    ),

    FoodDetailPage(index: 1),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        title: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Text("Food App"),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(child: Icon(Icons.person)),
          ),
        ],
      ),

      body: pages[selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF1E1E1E),
        selectedItemColor: Colors.amber,
        unselectedItemColor: Colors.white70,
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
            icon: Icon(Icons.details),
            label: "Food Detail",
          ),
        ],
      ),
    );
  }
}
