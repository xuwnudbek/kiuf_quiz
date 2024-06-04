import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/controllers/storage_service.dart';
import 'package:kiuf_quiz/utils/rgb.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  double _opacity = 0;

  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        setState(() {
          _opacity = 1;
        });
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(seconds: 2),
          onEnd: () {
            if (Storage.user.isNotEmpty && Storage.token.isNotEmpty) {
              if (Storage.user['loginId'].toString().length == 8 || Storage.user['course'] == null) {
                Get.offAllNamed("/teacher");
              } else {
                Get.offAllNamed("/student");
              }
            } else {
              Get.offAllNamed("/auth");
            }
          },
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: RGB.blueLight,
              borderRadius: BorderRadius.circular(100),
              image: const DecorationImage(
                image: AssetImage("assets/images/kiuf_logo.jpg"),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
