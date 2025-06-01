import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
//import 'package:camera/camera.dart';

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
  int selectedIndex = 1;

  void setSelectedIndex(int index) {
    setState(() => selectedIndex = index);
  }

  List<Map<String, dynamic>> getNavData() {
    return [
      {
        'label': 'Home',
        'icon': Icons.home,
        'page': Center(child: Text('Home')),
      },
      {'label': 'Camera', 'icon': Icons.camera, 'page': CameraView()},
      {
        'label': 'Settings',
        'icon': Icons.settings,
        'page': Center(child: Text('Settings')),
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.sizeOf(context).width < 600
        ? NavBarView(
          selectedIndex: selectedIndex,
          setSelectedIndex: setSelectedIndex,
          navData: getNavData(),
        )
        : NavRailView(
          selectedIndex: selectedIndex,
          setSelectedIndex: setSelectedIndex,
          navData: getNavData(),
        );
  }
}

class NavBarView extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> setSelectedIndex;
  final List<Map<String, dynamic>> navData;

  const NavBarView({
    super.key,
    required this.selectedIndex,
    required this.setSelectedIndex,
    required this.navData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: setSelectedIndex,
        selectedIndex: selectedIndex,
        destinations: [
          for (var navItem in navData)
            NavigationDestination(
              icon: Icon(navItem['icon']),
              label: navItem['label'],
            ),
        ],
      ),
      body: [for (var navItem in navData) navItem['page']][selectedIndex],
    );
  }
}

class NavRailView extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> setSelectedIndex;
  final List<Map<String, dynamic>> navData;

  const NavRailView({
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
            onDestinationSelected: setSelectedIndex,
            destinations: [
              for (var navItem in navData)
                NavigationRailDestination(
                  icon: Icon(navItem['icon']),
                  label: Text(navItem['label']),
                ),
            ],
            selectedIndex: selectedIndex,
          ),
          Expanded(
            child:
                [for (var navItem in navData) navItem['page']][selectedIndex],
          ),
        ],
      ),
    );
  }
}

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  List<CameraDescription> cameras = [];
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  void initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(cameras[0], ResolutionPreset.max);
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Placeholder();
    //return FutureBuilder<void>(future: future, builder: builder);
  }
}
