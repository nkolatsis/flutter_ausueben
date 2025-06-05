import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'camera_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final cameras = await availableCameras();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AdaptiveNavigation());
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

  List<Map<String, dynamic>> getNavData() => [
    {
      "label": "Home",
      "iconData": Icons.home_outlined,
      "destination": HomeView(),
    },
    {"label": "Camera", "iconData": Icons.camera, "destination": CameraView()},
    {
      "label": "Settings",
      "iconData": Icons.settings,
      "destination": SettingsView(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600
        ? SimpleNavBar(
          selectedIndex: selectedIndex,
          setSelectedIndex: setSelectedIndex,
          navData: getNavData(),
        )
        : Placeholder();
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
      body:
          [for (var navItem in navData) navItem['destination']][selectedIndex],
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Home"));
  }
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Settings"));
  }
}
