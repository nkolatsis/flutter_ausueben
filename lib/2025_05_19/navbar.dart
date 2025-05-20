import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SimpleNavbar());
  }
}

class SimpleNavbar extends StatefulWidget {
  const SimpleNavbar({super.key});

  @override
  State<SimpleNavbar> createState() => _SimpleNavbarState();
}

class _SimpleNavbarState extends State<SimpleNavbar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.camera), label: 'Camera'),
          NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
        ],
      ),
      body:
          [
            Center(child: Text("Home")),
            Center(child: Text("Camera")),
            Center(child: Text("Settings")),
          ][currentPageIndex],
    );
  }
}
