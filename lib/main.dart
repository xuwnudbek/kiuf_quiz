import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kiuf_quiz/utils/routes.dart';
import 'package:kiuf_quiz/utils/theme_data.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: PageRoutes.routes,
      initialRoute: "/splash",
      theme: ThemeData(
        fontFamily: "Montserrat",
        textTheme: CustomThemeData.textTheme,
      ),
      // home: const AuthPage(),
    );
  }
}
