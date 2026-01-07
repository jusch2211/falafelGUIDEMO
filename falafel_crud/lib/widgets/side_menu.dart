import 'package:flutter/material.dart';

class SideMenu extends StatelessWidget {
  final bool isAdmin;
  final Function(String) onSelect;

  const SideMenu({required this.isAdmin, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('Falafel App')),
          ListTile(
            title: Text('Falafel anzeigen'),
            onTap: () => onSelect('view'),
          ),
          if (isAdmin)
            ListTile(
              title: Text('Falafel verwalten'),
              onTap: () => onSelect('manage'),
            ),
        ],
      ),
    );
  }
}
