import 'package:flutter/material.dart';

class FadeAnimation extends Page {
  final Widget child;
  final Duration duration;
  final String? name;

  const FadeAnimation({
    required LocalKey key,
    required this.child,
    this.name,
    Object? arguments,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key, name: name, arguments: arguments);

  @override
  Route createRoute(BuildContext context) {
    print(name);
    return PageRouteBuilder(
      settings: this,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var curveTween = CurveTween(curve: Curves.easeIn);
        return FadeTransition(
          opacity: animation.drive(curveTween),
          child: child,
        );
      },
      transitionDuration: duration,
      reverseTransitionDuration: duration,
    );
  }
}
