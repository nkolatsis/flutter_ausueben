import 'package:flutter/material.dart';

import 'settings_view.dart';

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
  void setSelectedIndex(int index) {
    setState(() => selectedIndex = index);
  }

  List<Map<String, dynamic>> getNavData() {
    return [
      {
        'label': 'Home',
        'iconData': Icons.home_outlined,
        'destination': Center(child: Text('Home')),
      },
      {
        'label': 'Camera',
        'iconData': Icons.camera,
        'destination': Center(child: Text('Camera')),
      },
      {
        'label': 'Settings',
        'iconData': Icons.settings,
        'destination': SettingsView(),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600
        ? SimpleNavBar(
          selectedIndex: selectedIndex,
          setSelectedIndex: setSelectedIndex,
          navData: getNavData(),
        )
        : SimpleNavRail(
          selectedIndex: selectedIndex,
          setSelectedIndex: setSelectedIndex,
          navData: getNavData(),
        );
  }
}

class SimpleNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> setSelectedIndex;
  final List<Map<String, dynamic>> navData;

  const SimpleNavBar({
    super.key,
    required this.selectedIndex,
    required this.setSelectedIndex,
    required this.navData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        destinations: [
          for (Map<String, dynamic> navItem in navData)
            NavigationDestination(
              icon: Icon(navItem['iconData']),
              label: navItem['label'],
            ),
        ],
        selectedIndex: selectedIndex,
        onDestinationSelected: setSelectedIndex,
      ),
      body:
          [
            for (Map<String, dynamic> navItem in navData)
              navItem['destination'],
          ][selectedIndex],
    );
  }
}

class SimpleNavRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> setSelectedIndex;
  final List<Map<String, dynamic>> navData;

  const SimpleNavRail({
    super.key,
    required this.selectedIndex,
    required this.setSelectedIndex,
    required this.navData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            destinations: [
              for (Map<String, dynamic> navItem in navData)
                NavigationRailDestination(
                  icon: Icon(navItem['iconData']),
                  label: Text(navItem['label']),
                ),
            ],
            selectedIndex: selectedIndex,
            onDestinationSelected: setSelectedIndex,
          ),
          [
            for (Map<String, dynamic> navItem in navData)
              navItem['destination'],
          ][selectedIndex],
        ],
      ),
    );
  }
}


