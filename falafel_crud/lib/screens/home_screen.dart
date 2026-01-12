import 'package:flutter/material.dart';
import '../config/app_config.dart';
import 'falafel_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String role; // "admin" oder "user"

  const HomeScreen({
    super.key,
    required this.username,
    required this.role,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = widget.role == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Falafel Verwaltung'),
        actions: [
          Row(
            children: [
              const Text('Backend'),
              Switch(
                value: AppConfig.useBackend,
                onChanged: (value) {
                  setState(() {
                    AppConfig.useBackend = value;
                  });
                },
              ),
              const SizedBox(width: 16),
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(widget.username),
              accountEmail: Text(
                isAdmin ? 'Admin' : 'Nutzer',
              ),
            ),
            ListTile(
              leading: const Icon(Icons.fastfood),
              title: const Text('Falafel anzeigen'),
              onTap: () {
                setState(() {
                  _selectedIndex = 0;
                });
                Navigator.pop(context);
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: _buildContent(isAdmin),
    );
  }

  Widget _buildContent(bool isAdmin) {
    switch (_selectedIndex) {
      case 0:
        return FalafelScreen(isAdmin: isAdmin);
      default:
        return const Center(child: Text('Unbekannter Menüpunkt'));
    }
  }
}
