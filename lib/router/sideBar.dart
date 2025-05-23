import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wanderverse_app/providers/authentication/authService.dart';
import 'package:wanderverse_app/utils/constants.dart';

class SidebarMenu extends ConsumerStatefulWidget {
  final String activeRoute;
  final Function(String route) onRouteSelected;
  const SidebarMenu({
    super.key,
    required this.activeRoute,
    required this.onRouteSelected,
  });

  @override
  ConsumerState<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends ConsumerState<SidebarMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: menuItems.length,
            itemBuilder: (context, index) {
              final MenuItem menuItem = menuItems[index];
              bool isActive = menuItem.route == widget.activeRoute;
              return ListTile(
                leading: Icon(
                    isActive ? menuItem.activeIcon : menuItem.inactiveIcon),
                title: Text(menuItem.pageName),
                onTap: () {
                  widget.onRouteSelected(menuItem.route);
                },
              );
            },
          ),
        ),

        const Divider(thickness: 1),

        // Logout option at bottom
        ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () => ref.read(authServiceProvider.notifier).logout()),
      ],
    ));
  }
}
