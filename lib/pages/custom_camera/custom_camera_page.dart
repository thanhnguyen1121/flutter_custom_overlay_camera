import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_camera/main.dart';
import 'package:flutter_custom_camera/pages/custom_camera/camera_custom_clipper.dart';
import 'package:flutter_custom_camera/pages/preview_image/preview_image_page.dart';
import 'package:flutter_custom_camera/widgets/card_scanner_overlay_shape.dart';
import 'dart:ui' as ui;

final imageKey = GlobalKey();

class CustomCameraPage extends StatefulWidget {
  static const routeName = 'CustomCameraPage';

  const CustomCameraPage({Key? key}) : super(key: key);

  @override
  State<CustomCameraPage> createState() => _CustomCameraPageState();
}

class _CustomCameraPageState extends State<CustomCameraPage> {
  static const tag = 'CustomCameraPage';

  late CameraController controller;
  String? path;

  @override
  void initState() {
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            // Handle access errors here.
            break;
          default:
            // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Stack(
          children: [
            _cameraPreview(path: path),
            Align(alignment: Alignment.bottomCenter, child: _button()),
          ],
        ),
      ),
    );
  }

  Widget _button() {
    return Ink(
      decoration: const ShapeDecoration(
        color: Colors.lightBlue,
        shape: CircleBorder(),
      ),
      child: IconButton(
        icon: const Icon(Icons.camera_alt),
        color: Colors.white,
        onPressed: () {
          controller.takePicture().then((value) async {
            path = value.path;
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PreviewImagePage(data: path!),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _cameraPreview({String? path}) {
    if (controller.value.isInitialized) {
      return _CroppedCameraPreview(
        path: path,
        cameraController: controller,
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Future<Uint8List?> _captureImage(GlobalKey lensKey) async {
    final area = lensKey.currentContext?.findRenderObject();

    if (area == null || (area is! RenderRepaintBoundary)) return null;

    const pixelRatio = 1.0;
    const format = ui.ImageByteFormat.png;
    final image = await area.toImage(pixelRatio: pixelRatio);
    final byteData = await image.toByteData(format: format);

    return byteData?.buffer.asUint8List();
  }
}

class _CroppedCameraPreview extends StatelessWidget {
  final CameraController cameraController;
  String? path;
  final aspectRatio = 4 / 3;

  _CroppedCameraPreview({
    this.path,
    required this.cameraController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CameraPreview(cameraController),
          Container(
            decoration: const ShapeDecoration(
              shape: CardScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 12,
                borderLength: 32,
                borderWidth: 8,
              ),
            ),
          ),

        ],
      ),
    );
  }
}
