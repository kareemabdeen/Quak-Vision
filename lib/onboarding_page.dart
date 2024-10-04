import 'dart:async'; // For Timer

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  double _opacity = 0.0;
  double _topPosition = 0;

  @override
  void initState() {
    super.initState();

    // Trigger the animation after a short delay
    Timer(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        _opacity = 1.0; // Fully visible
        _topPosition = 350; // Move down from top
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/moon.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(seconds: 2),
            curve: Curves.easeInOut,
            top: _topPosition,
            left: 0,
            right: 0,
            child: AnimatedOpacity(
              duration: const Duration(seconds: 2),
              opacity: _opacity,
              child: const Center(
                child: Text(
                  'QUAKE',
                  style: TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 16,
            top: 10,
            child: Lottie.asset(
              'assets/nasa_logo.json',
              repeat: true,
              reverse: true,
              height: 100,
              width: 100,
            ),
          ),
        ],
      ),
    );
  }
}
