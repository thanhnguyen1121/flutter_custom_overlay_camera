import 'package:flutter/material.dart';
import 'package:flutter_custom_camera/pages/custom_camera/custom_camera_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = 'HomePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const tag = 'HomePage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home page"),
      ),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CustomCameraPage(),
                ),
              );
            },
            child: const Text("Go to camera custom page"),
          ),
        ),
      ),
    );
  }
}
