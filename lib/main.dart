import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/router/appRouteParser.dart';
import 'package:wanderverse_app/router/appState.dart';
import 'package:wanderverse_app/router/routerDelegate.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

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

    final routerDelegate = ref.watch(routerDelegateProvider);
    final routeInformationParser = AppRouteParser();

    return MaterialApp.router(
      title: 'Wanderverse',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      routerDelegate: routerDelegate,
      routeInformationParser: routeInformationParser,
      // routeInformationProvider: PlatformRouteInformationProvider(
      //     initialRouteInformation: const RouteInformation(location: '/auth')),
    );
  }
}
