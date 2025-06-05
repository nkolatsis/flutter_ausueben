// 1. Add the required dependencies
// 2. Get a list of the available cameras
// 3. Create and initialise the CameraController
// 4. Use a CameraPreview to display the camera's feed
// 5. Take a picture with the CameraController
// 6. Display the picture with an Image widget

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class CameraView extends StatefulWidget {
  const CameraView({super.key});

  @override
  State<CameraView> createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> {
  late List<CameraDescription> cameras = [];
  CameraController? controller;
  Future<void>? _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    initCamera();
  }

  Future<void> initCamera() async {
    cameras = await availableCameras();

    controller = CameraController(cameras[0], ResolutionPreset.medium);

    _initializeControllerFuture = controller!.initialize();

    setState(() {});
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_initializeControllerFuture == null) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (CameraDescription camera in cameras)
            Text(
              '${camera.name}: ${camera.lensDirection.name}',
              style: TextStyle(backgroundColor: Colors.redAccent),
            ),
        ],
      );
    }

    return FutureBuilder(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return CameraPreview(controller!);
        } else {
          return Text("Umm okay");
        }
      },
    );
  }
}
