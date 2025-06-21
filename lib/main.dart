import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/providers/post-sharing/postService.dart';
import 'package:wanderverse_app/providers/post-sharing/userService.dart';
import 'package:wanderverse_app/router/appRouteParser.dart';
import 'package:wanderverse_app/router/appState.dart';
import 'package:wanderverse_app/router/routerDelegate.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:wanderverse_app/router/themeService.dart';
import 'package:wanderverse_app/utils/appTheme.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    // Initialize providers
    ref.watch(appstateProvider);
    ref.watch(authServiceProvider);
    ref.watch(sharingPostsProvider);
    ref.watch(discussionPostsProvider);
    ref.watch(userServiceProvider);

    final routerDelegate = ref.watch(routerDelegateProvider);
    final routeInformationParser = AppRouteParser();
    final currentThemeProvider = ref.watch(themeServiceProvider);

    return MaterialApp.router(
      title: 'Wanderverse',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: currentThemeProvider,
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
    );
  }
}
