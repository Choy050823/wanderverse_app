import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/screens/appShell.dart';
import 'package:wanderverse_app/screens/navigatorScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/createPostScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/homeScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/userProfileScreen.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AppShell(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/create-post': (context) => const CreatePostScreen(),
        '/user-profile': (context) => const UserProfileScreen(),
      },
    );
  }
}
