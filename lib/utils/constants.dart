import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:wanderverse_app/providers/models.dart';

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
  final Uint8List fileData;
  final String name;
  final String mime;
  final int bytes;

  const DroppedFile(
      {required this.fileData,
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
    route: '/',
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
    pageName: 'Itinerary',
    route: '/itinerary',
    inactiveIcon: Icons.location_on_outlined,
    activeIcon: Icons.location_on,
  ),
  // MenuItem(
  //   pageName: 'Notifications',
  //   route: '/notifications',
  //   inactiveIcon: Icons.notifications_outlined,
  //   activeIcon: Icons.notifications,
  // ),
  MenuItem(
      pageName: 'User Profile',
      route: '/user-profile',
      inactiveIcon: Icons.person_2_outlined,
      activeIcon: Icons.person_2),
];

String getTimeAgo(DateTime dateTime) {
  final difference = DateTime.now().difference(dateTime);
  if (difference.inDays > 0) {
    return '${difference.inDays} days ago';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} hours ago';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} minutes ago';
  } else {
    return 'Just now';
  }
}

const defaultProfilePic =
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCHU5JIkqfD2z1KMc4c1nW4zdArnxBM3cCcQ&s";

final generalDestination = Destination(
    id: "0",
    name: "General",
    description: "Welcome to the General Page",
    imageUrl: "https://wanderverse-cloud-bucket.s3.ap-southeast-1.amazonaws.com/general.png",
    createdAt: DateTime.now(),
    updatedAt: DateTime.now()
);
