import 'package:flutter/material.dart';
import 'package:wanderverse_app/utils/constants.dart';

class SidebarMenu extends StatefulWidget {
  final String activeRoute;
  final Function(String) onRouteSelected;
  final VoidCallback onLogout;
  const SidebarMenu(
      {super.key,
      required this.activeRoute,
      required this.onRouteSelected,
      required this.onLogout});

  @override
  State<SidebarMenu> createState() => _SidebarMenuState();
}

class _SidebarMenuState extends State<SidebarMenu> {
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
              final bool isActive = menuItem.route == widget.activeRoute;
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
          onTap: widget.onLogout,
        ),
      ],
    ));
  }
}
