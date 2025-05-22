import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: TabbedAppBar());
  }
}

class TabbedAppBar extends StatelessWidget {
  const TabbedAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final tabPages = [
      Center(child: Text("Home")),
      Center(child: Text("Camera")),
      Center(child: Text("Settings")),
    ];
    final tabs = [
      Tab(icon: Icon(Icons.home_outlined), text: "Home"),
      Tab(icon: Icon(Icons.camera), text: "Camera"),
      Tab(icon: Icon(Icons.settings), text: "Settings"),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(bottom: TabBar(tabs: [...tabs])),
        body: TabBarView(children: tabPages),
        //bottomNavigationBar: TabBar(tabs: [...tabs]),
      ),
    );
  }
}
