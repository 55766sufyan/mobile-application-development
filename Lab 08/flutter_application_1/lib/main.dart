import 'package:flutter/material.dart';

void main() {
  runApp(AnimationsAssignmentApp());
}

class AnimationsAssignmentApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animations Assignment',
      home: AnimationsHomePage(),
    );
  }
}

class AnimationsHomePage extends StatefulWidget {
  @override
  State<AnimationsHomePage> createState() => _AnimationsHomePageState();
}

class _AnimationsHomePageState extends State<AnimationsHomePage>
    with TickerProviderStateMixin {
  
  bool showFirst = true;

  // --- For AnimatedOpacity ---
  double opacityLevel = 1.0;

  // --- For Custom Animation ---
  late AnimationController _sizeController;
  late Animation<double> _sizeAnimation;

  // --- For Staggered Animation ---
  late AnimationController _staggerController;
  late Animation<double> _firstBoxAnim;
  late Animation<double> _secondBoxAnim;

  @override
  void initState() {
    super.initState();

    // AnimationController for custom animation
    _sizeController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _sizeAnimation =
        Tween<double>(begin: 80, end: 180).animate(_sizeController);

    // AnimationController for staggered animation
    _staggerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    _firstBoxAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _secondBoxAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _staggerController,
        curve: Interval(0.5, 1.0, curve: Curves.easeOut),
      ),
    );
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Animations Assignment'),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 🔹 AnimatedCrossFade
            Text(
              '1. AnimatedCrossFade',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Cross-fade between two widgets with animation'),
            SizedBox(height: 10),
            AnimatedCrossFade(
              duration: Duration(seconds: 1),
              firstChild: Container(
                height: 100,
                width: 100,
                color: Colors.blue,
                child: Center(
                  child: Text('First', style: TextStyle(color: Colors.white)),
                ),
              ),
              secondChild: Container(
                height: 100,
                width: 100,
                color: Colors.orange,
                child: Center(
                  child: Text('Second', style: TextStyle(color: Colors.white)),
                ),
              ),
              crossFadeState: showFirst
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  showFirst = !showFirst;
                });
              },
              child: Text('Toggle CrossFade'),
            ),
            Divider(thickness: 1.2),

            // 🔹 AnimatedOpacity
            Text(
              '2. AnimatedOpacity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Fade in and fade out a widget smoothly'),
            SizedBox(height: 10),
            AnimatedOpacity(
              opacity: opacityLevel,
              duration: Duration(seconds: 1),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  opacityLevel = opacityLevel == 1 ? 0 : 1;
                });
              },
              child: Text('Fade In / Out'),
            ),
            Divider(thickness: 1.2),

            // 🔹 Custom AnimationController
            Text(
              '3. Custom AnimationController',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Box grows and shrinks using custom AnimationController'),
            SizedBox(height: 10),
            AnimatedBuilder(
              animation: _sizeAnimation,
              builder: (context, child) {
                return Container(
                  height: _sizeAnimation.value,
                  width: _sizeAnimation.value,
                  color: Colors.purple,
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _sizeController.forward(),
                  child: Text('Grow'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _sizeController.reverse(),
                  child: Text('Shrink'),
                ),
              ],
            ),
            Divider(thickness: 1.2),

            // 🔹 Staggered Animation
            Text(
              '4. Staggered Animation',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Two boxes animate one after another (staggered)'),
            SizedBox(height: 10),
            AnimatedBuilder(
              animation: _staggerController,
              builder: (context, child) {
                return Column(
                  children: [
                    Opacity(
                      opacity: _firstBoxAnim.value,
                      child: Container(
                        height: 80,
                        width: 80,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 10),
                    Opacity(
                      opacity: _secondBoxAnim.value,
                      child: Container(
                        height: 80,
                        width: 80,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => _staggerController.forward(from: 0),
              child: Text('Play Staggered Animation'),
            ),
          ],
        ),
      ),
    );
  }
}
