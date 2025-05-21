import 'package:flutter/material.dart';
import 'package:wanderverse_app/screens/appShell.dart';
import 'package:wanderverse_app/screens/authentication/loginScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This would be managed by your auth service in a real app
  bool _isLoggedIn = false;

  void login() {
    setState(() {
      _isLoggedIn = true;
    });
  }

  void logout() {
    setState(() {
      _isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wanderverse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _isLoggedIn
          ? AppShell(onLogout: logout)
          : LoginScreen(onLogin: login),
    );
  }
}
