import 'package:flutter/material.dart';

class AuthScreenTransition extends StatelessWidget {
  final Animation<double> controller;

  final ThemeData themeData;
  final Widget child;

  const AuthScreenTransition(
      {super.key, required this.controller, required this.themeData, required this.child});

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset(0, -0.095), end: Offset(0, 0)).animate(controller),
      child: ScaleTransition(
        scale: Tween(begin: 0.92, end: 1.0).animate(controller),
        child: FadeTransition(
          opacity: Tween(begin: 0.0, end: 1.0).animate(controller),
          child: child,
        ),
      ),
    );
  }
}
