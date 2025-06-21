import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/post-sharing/createPostOverlayService.dart';
import 'package:wanderverse_app/screens/post-sharing/createPostScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/homeScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/userProfileScreen.dart';
import 'package:wanderverse_app/router/appState.dart';
import 'package:wanderverse_app/router/routerDelegate.dart';
import 'package:wanderverse_app/router/sideBar.dart';
import 'package:wanderverse_app/utils/widgets/themeToggleButton.dart';

class AppShell extends ConsumerStatefulWidget {
  const AppShell({super.key});

  @override
  ConsumerState<AppShell> createState() => _AppShellState();
}

class _AppShellState extends ConsumerState<AppShell> {
  // bool _showOverlay = false;

  void handleRouteSelected(String route) {
    // Special case for create post: no need route to new screen
    if (route == '/create-post') {
      // setState(() {
      //   _showOverlay = true;
      // });
      ref.read(createPostOverlayServiceProvider.notifier).show();
    } else {
      print('change route');
      ref.read(appstateProvider.notifier).changeAppRoute(route);
    }
  }

  void _closeOverlay() {
    // setState(() {
    //   _showOverlay = false;
    // });
    ref.read(createPostOverlayServiceProvider.notifier).hide();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    final showOverlay = ref.watch(createPostOverlayServiceProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: colorScheme.surface,
        shadowColor: Colors.amber,
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.explore_outlined,
                color: colorScheme.primary, // Use primary color for icon
              ),
            ),
            Text(
              'Wanderverse',
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.primary, // Use primary color for title text
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
        actions: const [
          ThemeToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      body: Stack(
        children: [
          Row(
            children: [
              SidebarMenu(
                activeRoute: ref.watch(appstateProvider).route,
                onRouteSelected: handleRouteSelected,
              ),
              Expanded(
                child: Router(
                  routerDelegate: ref.watch(innerRouterDelegateProvider),
                  backButtonDispatcher: RootBackButtonDispatcher(),
                ),
              ),
            ],
          ),

          // Create post overlay
          if (showOverlay)
            Stack(
              children: [
                Positioned.fill(
                  child: GestureDetector(
                    onTap: _closeOverlay,
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      color: Colors.black54,
                    ),
                  ),
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CreatePostScreen(
                        onClose: _closeOverlay,
                      ),
                    ),
                  ),
                ),
              ],
            )
        ],
      ),
    );
  }
}

class InnerRouterDelegate extends RouterDelegate<AppStateData>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<AppStateData> {
  final WidgetRef ref;
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
    final route = ref.watch(appstateProvider).route;
    final List<Page<dynamic>> pages = [];

    // Route to the correct screen based on current route
    switch (route) {
      case AppStateData.home:
        pages.add(
          const MaterialPage(
            key: ValueKey('Home'),
            name: AppStateData.home,
            child: HomeScreen(),
          ),
        );
        break;

      case AppStateData.profile:
        pages.add(
          const MaterialPage(
            key: ValueKey('Profile'),
            name: AppStateData.profile,
            child: UserProfileScreen(),
          ),
        );
        break;

      default:
        pages.add(
          const MaterialPage(
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
