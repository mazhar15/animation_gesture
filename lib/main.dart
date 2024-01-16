import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class DancingBallApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DancingBallPage(),
    );
  }
}

class DancingBallPage extends StatefulWidget {
  @override
  _DancingBallPageState createState() => _DancingBallPageState();
}

class _DancingBallPageState extends State<DancingBallPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _xAnimation;
  late Animation<double> _yAnimation;

  @override
  void initState() {
    super.initState();

    // Set up AnimationController
    _controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    // Set up Tweens for X and Y coordinates
    _xAnimation = Tween<double>(begin: 0, end: 300).animate(_controller);
    _yAnimation = Tween<double>(begin: 0, end: 300).animate(_controller);

    // Add a listener to update the UI on animation changes
    _xAnimation.addListener(() {
      setState(() {});
    });

    // Add a status listener to repeat the animation when it completes
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    // Start the animation
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dancing Ball Animation'),
      ),
      body: GestureDetector(
        onTap: () {
          // Reverse the animation direction when the ball is tapped
          if (_controller.isAnimating) {
            _controller.stop();
          }
          _controller.reverse();
        },
        child: Center(
          child: Container(
            margin: EdgeInsets.only(left: _xAnimation.value, top: _yAnimation.value),
            child: Icon(
              Icons.sports_soccer,
              size: 50,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DancingBallApp();
  }
}
