import 'package:flutter/material.dart';

import 'camera_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(home: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveNavigation();
  }
}

class AdaptiveNavigation extends StatefulWidget {
  const AdaptiveNavigation({super.key});

  @override
  State<AdaptiveNavigation> createState() => _AdaptiveNavigationState();
}

class _AdaptiveNavigationState extends State<AdaptiveNavigation> {
  int selectedIndex = 1;

  void setSelectedIndex(int index) {
    setState(() => selectedIndex = index);
  }

  List<Map<String, dynamic>> getNavData() => [
    {
      'label': 'Home',
      'iconData': Icons.home_outlined,
      'destination': Center(child: Text('Home')),
    },
    {'label': 'Camera', 'iconData': Icons.camera, 'destination': CameraView()},

    {
      'label': 'Settings',
      'iconData': Icons.settings,
      'destination': Center(child: Text('Settings')),
    },
  ];

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
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: setSelectedIndex,
        destinations: [
          for (var navItem in navData)
            NavigationDestination(
              icon: Icon(navItem['iconData']),
              label: navItem['label'],
            ),
        ],
      ),
      body:
          [
            for (Map<String, dynamic> navItem in navData)
              navItem['destination'],
          ][selectedIndex],
    );
  }
}
