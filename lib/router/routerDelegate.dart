import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/router/appState.dart';
import 'package:wanderverse_app/screens/authentication/authScreen.dart';
import 'package:wanderverse_app/router/appShell.dart';
import 'package:wanderverse_app/screens/authentication/pageNotFoundScreen.dart';
import 'package:wanderverse_app/screens/discussion/DiscussionScreen.dart';
import 'package:wanderverse_app/screens/minigame/MinigameScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/homeScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/userProfileScreen.dart';
import 'package:wanderverse_app/utils/widgets/FadeAnimation.dart';

final routerDelegateProvider = Provider<AppRouterDelegate>((ref) {
  return AppRouterDelegate(ref);
});

final innerRouterDelegateProvider = Provider<InnerRouterDelegate>((ref) {
  return InnerRouterDelegate(ref);
});

class AppRouterDelegate extends RouterDelegate<AppStateData>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppStateData> {
  final ProviderRef<AppRouterDelegate> ref;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  AppRouterDelegate(this.ref) {
    ref.listen(appstateProvider, (previous, next) {
      notifyListeners();
    });
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  AppStateData get currentConfiguration {
    return ref.read(appstateProvider);
  }

  @override
  Future<void> setNewRoutePath(AppStateData configuration) async {
    print('Setting new route path: ${configuration.route}');
    ref.read(appstateProvider.notifier).changeAppRoute(configuration.route);
    print('Route changed to: ${ref.read(appstateProvider).route}');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final appState = ref.watch(appstateProvider);
        final authState = ref.watch(authServiceProvider);
        final List<Page<dynamic>> pages = [];

        print('Current route in RouterDelegate: ${appState.route}');
        print('Auth state: ${authState.isAuthenticated}');

        // Check if we're still initializing
        if (authState.isLoading) {
          pages.add(const FadeAnimation(
            key: ValueKey('Loading'),
            child: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          ));
          return Navigator(
            key: navigatorKey,
            pages: pages,
            onPopPage: (_, __) => false,
          );
        }

        // First check if this is the unknown route - THIS MUST COME FIRST
        if (appState.route == AppStateData.unknown) {
          print('Showing Page Not Found screen');
          pages.add(const FadeAnimation(
            key: ValueKey('PageNotFound'),
            name: AppStateData.unknown,
            child: PageNotFoundScreen(),
          ));
        } else if (!authState.isAuthenticated) {
          // Not authenticated - show auth screen
          print('Showing Auth screen');
          pages.add(const FadeAnimation(
            key: ValueKey('Auth'),
            name: '/auth',
            child: AuthScreen(),
          ));
        } else {
          // Authenticated - show app shell
          print('Showing AppShell');
          pages.add(
            FadeAnimation(
              key: const ValueKey('AppShell'),
              name: appState.route,
              child: const AppShell(),
            ),
          );
        }

        return Navigator(
          key: navigatorKey,
          pages: pages,
          onPopPage: (route, result) {
            if (!route.didPop(result)) {
              return false;
            }
            return true;
          },
          observers: [HeroController()],
        );
      },
    );
  }
}

class InnerRouterDelegate extends RouterDelegate<AppStateData>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppStateData> {
  final ProviderRef<InnerRouterDelegate> ref;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  InnerRouterDelegate(this.ref) {
    ref.listen(appstateProvider.select((value) => value.route), (_, __) {
      notifyListeners();
    });
  }

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Widget build(BuildContext context) {
    final appState = ref.watch(appstateProvider);

    // Don't try to handle unknown route in inner delegate
    if (appState.route == AppStateData.unknown) {
      return Container(); // Empty, since outer router will show 404 page
    }

    final List<Page<dynamic>> pages = [];

    // Route to the correct screen based on current route
    switch (appState.route) {
      case AppStateData.home:
        pages.add(
          const FadeAnimation(
            key: ValueKey('Home'),
            name: AppStateData.home,
            child: HomeScreen(),
          ),
        );
        break;

      case AppStateData.game:
        pages.add(
          const FadeAnimation(
            key: ValueKey('Game'),
            name: AppStateData.game,
            child: MinigameScreen(),
          ),
        );
        break;

      case AppStateData.discussion:
        pages.add(
          const FadeAnimation(
            key: ValueKey('Discussion'),
            name: AppStateData.discussion,
            child: DiscussionScreen(),
          ),
        );
        break;

      case AppStateData.profile:
        pages.add(
          const FadeAnimation(
            key: ValueKey('Profile'),
            name: AppStateData.profile,
            child: UserProfileScreen(),
          ),
        );
        break;

      default:
        pages.add(
          const FadeAnimation(
            key: ValueKey('Home'),
            name: AppStateData.home,
            child: HomeScreen(),
          ),
        );
    }

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
      // Add a separate HeroController for this Navigator
      observers: [HeroController()],
    );
  }

  @override
  Future<void> setNewRoutePath(AppStateData configuration) async {
    // This is handled by the outer router
  }
}
