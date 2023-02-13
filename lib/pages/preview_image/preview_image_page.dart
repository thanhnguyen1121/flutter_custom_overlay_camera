import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_custom_camera/pages/custom_camera/camera_custom_clipper.dart';

class PreviewImagePage extends StatefulWidget {
  static const routeName = 'PreviewImagePage';

  // final String imagePath;

  final String data;

  const PreviewImagePage({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<PreviewImagePage> createState() => _PreviewImagePageState();
}

class _PreviewImagePageState extends State<PreviewImagePage> {
  static const tag = 'PreviewImagePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview Image"),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: Container(
            alignment: Alignment.center,
            child: ClipPath(
              clipper: CameraCustomClipper(borderRadius: 48),
              child: Container(
                width: 320,
                height: 200,
                color: Colors.transparent,
                child: Image.file(
                  File(widget.data),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
