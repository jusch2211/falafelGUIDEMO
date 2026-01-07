import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const FalafelApp());
}

class FalafelApp extends StatelessWidget {
  const FalafelApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Falafel App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
    );
  }
}
