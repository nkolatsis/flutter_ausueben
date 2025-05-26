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

  void setSelectedIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600
        ? SimpleNavBar(
          selectedIndex: selectedIndex,
          setSelectedIndex: setSelectedIndex,
        )
        : SimpleNavRail(
          selectedIndex: selectedIndex,
          setSelectedIndex: setSelectedIndex,
        );
  }
}

class SimpleNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> setSelectedIndex;

  const SimpleNavBar({
    super.key,
    required this.selectedIndex,
    required this.setSelectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: setSelectedIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.camera), label: "Camera"),
          NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
        ],
      ),
      body:
          [
            Center(child: Text("Home")),
            Center(child: Text("Camera")),
            Center(child: Text("Settings")),
          ][selectedIndex],
    );
  }
}

class SimpleNavRail extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> setSelectedIndex;

  const SimpleNavRail({
    super.key,
    required this.selectedIndex,
    required this.setSelectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: setSelectedIndex,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text("Home"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.camera),
                label: Text("Camera"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text("Settings"),
              ),
            ],
            selectedIndex: selectedIndex,
          ),
          Expanded(
            child:
                [
                  Center(child: Text("Home")),
                  Center(child: Text("Camera")),
                  Center(child: Text("Settings")),
                ][selectedIndex],
          ),
        ],
      ),
    );
  }
}
