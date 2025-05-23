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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 20),
            Text(
              'Page Not Found',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onBackground,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'The requested page does not exist.',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onBackground.withOpacity(0.7),
              ),
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
