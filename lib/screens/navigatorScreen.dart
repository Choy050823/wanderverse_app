import 'package:flutter/material.dart';
import 'package:wanderverse_app/screens/post-sharing/createPostScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/homeScreen.dart';
import 'package:wanderverse_app/screens/post-sharing/useProfileScreen.dart';

class NavigatorScreen extends StatefulWidget {
  final String initialRoute;
  const NavigatorScreen({super.key, required this.initialRoute});

  @override
  State<NavigatorScreen> createState() => _NavigatorScreenState();
}

class _NavigatorScreenState extends State<NavigatorScreen> {
  int _selectedIndex = 0;
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  final Map<String, int> _routeToIndex = {
    '/home': 0,
    '/create-post': 1,
    '/user-profile': 2,
  };

  @override
  void initState() {
    super.initState();
    _selectedIndex = _routeToIndex[widget.initialRoute] ?? 0;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    String route =
        _routeToIndex.entries.firstWhere((entry) => entry.value == index).key;
    _navigatorKey.currentState?.pushReplacementNamed(route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined),
            activeIcon: Icon(Icons.add_box),
            label: 'Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            activeIcon: Icon(Icons.person_2_sharp),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        elevation: 8.0,
        iconSize: 28.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        onTap: _onItemTapped,
      ),
      body: Navigator(
          key: _navigatorKey,
          initialRoute: widget.initialRoute,
          onGenerateRoute: (RouteSettings settings) {
            WidgetBuilder builder;
            switch (settings.name) {
              case '/home':
                builder = (context) => const HomeScreen();
                break;
              case '/create-post':
                builder = (context) => const CreatePostScreen();
                break;
              case '/user-profile':
                builder = (context) => const UserProfileScreen();
                break;
              default:
                builder = (context) => const HomeScreen();
                break;
            }

            if (_routeToIndex.containsKey(settings.name)) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  setState(() {
                    _selectedIndex = _routeToIndex[settings.name] ?? 0;
                  });
                }
              });
            }

            return MaterialPageRoute(builder: builder, settings: settings);
          }),
    );
  }
}
