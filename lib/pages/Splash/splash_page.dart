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
  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  Future<void> checkAuth() async {
    try {
      await Future.delayed(const Duration(seconds: 2)); // 2-second delay
      if (Storage.user.isNotEmpty && Storage.token.isNotEmpty) {
        Get.offAllNamed("/teacher");
      } else {
        Get.offAllNamed("/auth");
      }
    } catch (error) {
      // Handle errors here (e.g., navigate to a login screen)
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox.square(
              dimension: 75.0,
              child: CircularProgressIndicator(
                color: RGB.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
