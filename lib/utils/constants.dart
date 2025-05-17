import 'package:flutter/material.dart';

class MenuItem {
  final String pageName;
  final String route;
  final IconData inactiveIcon;
  final IconData activeIcon;

  const MenuItem(
      {required this.pageName,
      required this.route,
      required this.inactiveIcon,
      required this.activeIcon});
}

class DroppedFile {
  final String url;
  final String name;
  final String mime;
  final int bytes;

  const DroppedFile(
      {required this.url,
      required this.name,
      required this.mime,
      required this.bytes});

  String get size {
    final kb = bytes / 1024;
    final mb = kb / 1024;

    return mb > 1
        ? '${mb.toStringAsFixed(2)} MB'
        : '${kb.toStringAsFixed(2)} KB';
  }
}

const List<MenuItem> menuItems = [
  MenuItem(
    pageName: 'Home',
    route: '/home',
    inactiveIcon: Icons.home_outlined,
    activeIcon: Icons.home,
  ),
  MenuItem(
    pageName: 'Create Post',
    route: '/create-post',
    inactiveIcon: Icons.add_box_outlined,
    activeIcon: Icons.add_box,
  ),
  MenuItem(
    pageName: 'Game',
    route: '/game',
    inactiveIcon: Icons.gamepad_outlined,
    activeIcon: Icons.gamepad,
  ),
  MenuItem(
    pageName: 'Discussion',
    route: '/discussion',
    inactiveIcon: Icons.chat_outlined,
    activeIcon: Icons.chat,
  ),
  MenuItem(
    pageName: 'Destinations',
    route: '/world-map',
    inactiveIcon: Icons.location_on_outlined,
    activeIcon: Icons.location_on,
  ),
  MenuItem(
    pageName: 'Notifications',
    route: '/notifications',
    inactiveIcon: Icons.notifications_outlined,
    activeIcon: Icons.notifications,
  ),
  MenuItem(
      pageName: 'User Profile',
      route: '/user-profile',
      inactiveIcon: Icons.person_2_outlined,
      activeIcon: Icons.person_2)
];
