import 'package:flutter/material.dart';
import '../widgets/side_menu.dart';
import 'falafel_screen.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final String role;

  const HomeScreen({required this.username, required this.role, Key? key})
      : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String selectedPage = 'view'; // default Seite

  void selectPage(String page) {
    setState(() {
      selectedPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Prüfen, ob Adminrechte vorliegen
    bool isAdmin = widget.role.toLowerCase() == 'admin';

    return Scaffold(
      appBar: AppBar(
        title: Text('Falafel App - Willkommen ${widget.username}'),
      ),
      drawer: SideMenu(
        isAdmin: isAdmin,
        onSelect: (page) {
          Navigator.pop(context); // Drawer schließen
          selectPage(page);
        },
      ),
      body: Row(
        children: [
          // Optional: feste Sidebar für Web
          if (MediaQuery.of(context).size.width > 800)
            SizedBox(
              width: 200,
              child: SideMenu(
                isAdmin: isAdmin,
                onSelect: selectPage,
              ),
            ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: getPage(selectedPage, isAdmin),
            ),
          ),
        ],
      ),
    );
  }

  // Entscheidet, welche Seite angezeigt wird
  Widget getPage(String page, bool isAdmin) {
    switch (page) {
      case 'manage':
      case 'view':
        return FalafelScreen(isAdmin: isAdmin);
      default:
        return const Center(child: Text('Seite nicht gefunden'));
    }
  }
}
