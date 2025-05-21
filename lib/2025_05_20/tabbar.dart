import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: SimpleTabs());
  }
}

class SimpleTabs extends StatelessWidget {
  const SimpleTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("appbar title"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Home"),
              Tab(text: "Camera"),
              Tab(text: "Settings"),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            Center(child: Text("Home")),
            Center(child: Text("Camera")),
            Center(child: Text("Settings")),
          ],
        ),
      ),
    );
  }
}
