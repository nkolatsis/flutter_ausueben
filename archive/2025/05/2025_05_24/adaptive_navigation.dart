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

class AdaptiveNavigation extends StatelessWidget {
  const AdaptiveNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width > 600
        ? SimpleNavRail()
        : SimpleNavBar();
  }
}

class SimpleNavBar extends StatefulWidget {
  const SimpleNavBar({super.key});

  @override
  State<SimpleNavBar> createState() => SimpleNavBarState();
}

class SimpleNavBarState extends State<SimpleNavBar> {
  int currentlySelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          [
            Center(child: Text("Budget")),
            Center(child: Text("Accounts")),
            Center(child: Text("More")),
          ][currentlySelectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentlySelectedIndex = index;
          });
        },
        selectedIndex: currentlySelectedIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.home), label: "Budget"),
          NavigationDestination(icon: Icon(Icons.wallet), label: "Accounts"),
          NavigationDestination(icon: Icon(Icons.unfold_more), label: "More"),
        ],
      ),
    );
  }
}

class SimpleNavRail extends StatefulWidget {
  const SimpleNavRail({super.key});

  @override
  State<SimpleNavRail> createState() => _SimpleNavRailState();
}

class _SimpleNavRailState extends State<SimpleNavRail> {
  int currentlySelectedIndex = 0;
  bool extended = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            onDestinationSelected: (int index) {
              setState(() {
                currentlySelectedIndex = index;
              });
            },
            selectedIndex: currentlySelectedIndex,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text("Budget"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.wallet),
                label: Text("Accounts"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.more_horiz),
                label: Text("More"),
              ),
            ],
            minExtendedWidth: 200,
            extended: extended,
            leading: Column(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() => extended = !extended);
                  },
                  icon: Icon(Icons.read_more_outlined),
                ),
              ],
            ),
          ),
          [
            Expanded(child: Placeholder()),
            Expanded(child: Placeholder()),
            Expanded(child: Placeholder()),
          ][currentlySelectedIndex],
        ],
      ),
    );
  }
}
