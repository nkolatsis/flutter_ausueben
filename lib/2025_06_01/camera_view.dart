/*

1. Add the required dependencies
2. Get a list of the available cameras.
3. Create and initialize the CameraController.
4. Use a CameraPreview to display the camera's feed.
5. Take a picture with the CameraController.
6. Display the picture with an Image widget.

*/

import "package:flutter/material.dart";

import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class CameraView extends StatelessWidget {
    const CameraView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Camera"));
  }
}
