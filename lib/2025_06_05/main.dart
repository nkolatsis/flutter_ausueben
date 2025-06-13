import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: AdaptiveNavigation());
  }
}

class AdaptiveNavigation extends StatefulWidget {
  const AdaptiveNavigation({super.key});

  @override
  State<AdaptiveNavigation> createState() => _AdaptiveNavigationState();
}

class _AdaptiveNavigationState extends State<AdaptiveNavigation> {
  int selectedIndex = 0;

  void setSelectedIndex(var index) {
    setState(() => selectedIndex = index);
  }

  List<Map<String, dynamic>> getNavData() {
    return [
      {
        "label": "Home",
        "iconData": Icons.home_outlined,
        "destination": Center(child: Text("Home")),
      },
      {
        "label": "Camera",
        "iconData": Icons.camera,
        "destination": Center(child: Text("Camera")),
      },
      {
        "label": "Settings",
        "iconData": Icons.settings,
        "destination": Center(child: Text("Settings")),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600
        ? SimpleNavBar(selectedIndex, setSelectedIndex, getNavData())
        : Placeholder();
  }
}

class SimpleNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> setSelectedIndex;
  final List<Map<String, dynamic>> navData;

  const SimpleNavBar(
    this.selectedIndex,
    this.setSelectedIndex,
    this.navData, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          [
            for (Map<String, dynamic> navItem in navData)
              navItem['destination'],
          ][selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: setSelectedIndex,
        destinations: [
          for (Map<String, dynamic> navItem in navData)
            NavigationDestination(
              icon: Icon(navItem['iconData']),
              label: navItem['label'],
            ),
        ],
      ),
    );
  }
}
