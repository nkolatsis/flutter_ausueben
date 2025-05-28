import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

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
    // Possibly pass Navigation Data Dynamically since it is mostly shared
    List<Map<String, dynamic>> navData = [
      {
        'label': 'Home',
        'icon': Icons.home,
        'view': Center(child: Text("Home")),
      },
      {'label': 'Camera', 'icon': Icons.camera, 'view': CameraView()},
      {
        'label': 'Settings',
        'icon': Icons.settings,
        'view': Center(child: Text("Settings")),
      },
    ];

    return MediaQuery.sizeOf(context).width < 600
        ? SimpleNavBar(
          selectedIndex: selectedIndex,
          setSelectedIndex: setSelectedIndex,
          navData: navData,
        )
        : SimpleNavRail(
          selectedIndex: selectedIndex,
          setSelectedIndex: setSelectedIndex,
          navData: navData,
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
      body: [for (var navItem in navData) navItem['view']][selectedIndex],
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
            onDestinationSelected: setSelectedIndex,
            destinations: [
              for (Map<String, dynamic> navItem in navData)
                NavigationRailDestination(
                  icon: Icon(navItem['icon']),
                  label: Text(navItem['label']),
                ),
            ],
            selectedIndex: selectedIndex,
          ),
          Expanded(
            child:
                [
                  Center(child: Text("Home")),
                  CameraView(),
                  Center(child: Text("Settings")),
                ][selectedIndex],
          ),
        ],
      ),
    );
  }
}

// Camera Feature

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late List<CameraDescription> cameras = [];
  late CameraController _controller;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    cameras = await availableCameras();
    _controller = CameraController(
      cameras[0], // rear camera
      ResolutionPreset.medium,
    );

    await _controller.initialize();
    setState(() => _isInitialized = true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<XFile?> takePicture() async {
    if (!_controller.value.isInitialized) return null;
    if (_controller.value.isTakingPicture) return null;

    try {
      return await _controller.takePicture();
    } catch (e) {
      // ignore: avoid_print
      print('Error taking picture: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return Expanded(
      child: Stack(
        children: [
          CameraPreview(_controller),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: (Center(
              child: FloatingActionButton(
                onPressed: () async {
                  final picture = await takePicture();
                  if (picture != null) {
                    print('Picture take: ${picture.path}');
                  }
                },
                child: Icon(Icons.camera),
              ),
            )),
          ),
        ],
      ),
    );
  }
}
