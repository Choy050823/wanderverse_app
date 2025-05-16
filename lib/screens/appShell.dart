import 'package:flutter/material.dart';
import 'package:wanderverse_app/screens/post-sharing/createPostScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/homeScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/userProfileScreen.dart';
import 'package:wanderverse_app/screens/sideBar.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late String activeRoute;
  Widget? oldScreen;

  void _navigateTo(String route) {
    setState(() {
      oldScreen = _getScreenForRoute(activeRoute);
      activeRoute = route;
    });
    _navigatorKey.currentState?.pushReplacementNamed(activeRoute);
  }

  Widget _getScreenForRoute(String route) {
    switch (route) {
      case '/create-post':
        return const CreatePostScreen();
      case '/user-profile':
        return const UserProfileScreen();
      case '/home':
      default:
        return const HomeScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      activeRoute = '/home';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        shadowColor: Colors.amber,
        title: Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.language),
            ),
            const Text('Wanderverse'),
          ],
        ),
      ),
      body: Row(
        children: [
          SizedBox(
              width: 200,
              child: SidebarMenu(
                  activeRoute: activeRoute, onRouteSelected: _navigateTo)),
          Expanded(
            child: Navigator(
              key: _navigatorKey,
              onGenerateRoute: (RouteSettings settings) {
                final newScreen = _getScreenForRoute(settings.name ?? '/home');
                return PageRouteBuilder(
                    pageBuilder: (_, __, ____) => Stack(
                          children: [
                            // Old screen slides out to the left
                            if (oldScreen != null)
                              SlideTransition(
                                position: Tween<Offset>(
                                  begin: Offset.zero,
                                  end: const Offset(-1.0, 0.0),
                                ).animate(CurvedAnimation(
                                  parent: __,
                                  curve: Curves.easeInOut,
                                )),
                                child: oldScreen,
                              ),
                            // New screen slides in from the right
                            SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(1.0, 0.0),
                                end: Offset.zero,
                              ).animate(CurvedAnimation(
                                parent: __,
                                curve: Curves.easeInOut,
                              )),
                              child: newScreen,
                            ),
                          ],
                        ),
                    transitionDuration: const Duration(seconds: 1));
              },
            ),
          ),
        ],
      ),
    );
  }
}
