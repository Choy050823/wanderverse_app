import 'package:flutter/material.dart';

class FadeAnimation extends Page {
  final Widget child;

  const FadeAnimation({super.key, required this.child});

  @override
  Route createRoute(BuildContext context) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, _) {
      var curveTween = CurveTween(curve: Curves.easeIn);
      return FadeTransition(
        opacity: animation.drive(curveTween),
        child: child,
      );
    });
  }
}
