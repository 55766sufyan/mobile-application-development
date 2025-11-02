import 'package:flutter/material.dart';

void main() {
  runApp(MyPrettyApp());
}

class MyPrettyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrolling Lists & Effects',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PrettyHomePage(),
    );
  }
}

class PrettyHomePage extends StatelessWidget {
  final List<String> listItems =
      List.generate(6, (index) => 'Beautiful Item ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // --- SliverAppBar with image background ---
          SliverAppBar(
            pinned: true,
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Flutter Scrolling Demo'),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    'https://picsum.photos/600/400?random=1',
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withOpacity(0.3)),
                ],
              ),
            ),
          ),

          // --- List Section ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Scrollable List',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        'https://picsum.photos/50?random=$index',
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(listItems[index]),
                    subtitle: Text('This is a ListView item'),
                  ),
                );
              },
              childCount: listItems.length,
            ),
          ),

          // --- Grid Section ---
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                'Scrollable Grid',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          SliverGrid(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        'https://picsum.photos/200?random=$index',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      color: Colors.black54,
                      child: Text(
                        'Image ${index + 1}',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
              childCount: 6,
            ),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
          ),
        ],
      ),
    );
  }
}
