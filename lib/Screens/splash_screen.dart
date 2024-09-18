import 'dart:async';
import 'package:covid_stat/Screens/home_page.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Animation Controllers for rotation and opacity
  late final AnimationController _controller = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..repeat();

  late final AnimationController _opacityController = AnimationController(
    duration: Duration(seconds: 3),
    vsync: this,
  )..forward();

  late final Animation<double> _opacityAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(_opacityController);

  @override
  void dispose() {
    _controller.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FadeTransition(
              opacity: _opacityAnimation, // Control opacity using animation
              child: AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: height * 0.5,
                  width: width * 0.6,
                  child: const Center(
                    child: Image(image: AssetImage('images/c19.png')),
                  ),
                ),
                builder: (BuildContext context, Widget? child) {
                  return Transform.rotate(
                    angle: _controller.value * 2.35 * math.pi,
                    child: child,
                  );
                },
              ),
            ),
            SizedBox(
              height: height * 0.05,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Text(
                    'CovidStat',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.ewert(fontSize: 25, color: Colors.red),
                  ),
                  Text(
                    'The World Wide Covid Statistics',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.sofia(fontSize: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
