import 'package:flutter/material.dart';
import 'package:wanderverse_app/screens/authentication/loginScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/createPostScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/homeScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/userProfileScreen.dart';
import 'package:wanderverse_app/screens/sideBar.dart';

class AppShell extends StatefulWidget {
  final VoidCallback onLogout;

  const AppShell({super.key, required this.onLogout});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late String activeRoute;
  bool _showOverlay = false;

  void _navigateTo(String route) {
    if (route == '/create-post') {
      setState(() {
        _showOverlay = true;
      });
    } else {
      setState(() {
        activeRoute = route;
      });
      _navigatorKey.currentState?.pushReplacementNamed(activeRoute);
    }
  }

  void _closeOverlay() {
    setState(() {
      _showOverlay = false;
    });
  }

  Widget _getScreenForRoute(String route) {
    switch (route) {
      case '/':
        return const HomeScreen();
      case '/create-post':
        return const CreatePostScreen();
      case '/user-profile':
        return const UserProfileScreen();
      default:
        return const HomeScreen();
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      activeRoute = '/';
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
      body: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                  width: 200,
                  child: SidebarMenu(
                    activeRoute: activeRoute,
                    onRouteSelected: _navigateTo,
                    onLogout: widget.onLogout,
                  )),
              Expanded(
                child: Navigator(
                  key: _navigatorKey,
                  onGenerateRoute: (RouteSettings settings) {
                    final newScreen = _getScreenForRoute(settings.name ?? '/');
                    return PageRouteBuilder(
                        pageBuilder: (context, animation, _) {
                      var curveTween = CurveTween(curve: Curves.easeIn);
                      return FadeTransition(
                        opacity: animation.drive(curveTween),
                        child: newScreen,
                      );
                    });
                  },
                ),
              ),
            ],
          ),
          if (_showOverlay)
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
