import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/router/appState.dart';

class PageNotFoundScreen extends ConsumerStatefulWidget {
  const PageNotFoundScreen({super.key});

  @override
  ConsumerState<PageNotFoundScreen> createState() => _PageNotFoundScreenState();
}

class _PageNotFoundScreenState extends ConsumerState<PageNotFoundScreen> {
  @override
  Widget build(BuildContext context) {
    final isAuthenticated = ref.watch(authServiceProvider).isAuthenticated;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 20),
            const Text(
              'Page Not Found',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'The requested page does not exist.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Go to appropriate page based on auth status
                final route =
                    isAuthenticated ? AppStateData.home : AppStateData.auth;

                ref.read(appstateProvider.notifier).changeAppRoute(route);
              },
              child: Text(isAuthenticated ? 'Go to Home' : 'Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
