import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:kiuf_quiz/pages/404/not_found.dart';

import 'package:kiuf_quiz/controllers/language/language.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/routes.dart';
import 'package:kiuf_quiz/utils/theme_data.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "KIUF ${'quiz'.tr}",
      debugShowCheckedModeBanner: false,
      routes: PageRoutes.routes,
      initialRoute: "/auth",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      // ignore: prefer_const_literals_to_create_immutables
      supportedLocales: <Locale>[
        const Locale('uz', 'UZ'),
        const Locale('en'),
      ],
      locale: const Locale('uz', 'UZ'),
      translations: Language(),
      theme: ThemeData(
        fontFamily: "Montserrat",
        textTheme: CustomThemeData.textTheme,
        appBarTheme: CustomThemeData.appBarTheme,
        scaffoldBackgroundColor: RGB.white,
      ),
      transitionDuration: const Duration(milliseconds: 700),
      defaultTransition: Transition.upToDown,
      onUnknownRoute: (settings) {
        return GetPageRoute(
          transition: Transition.upToDown,
          transitionDuration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          page: () => const NotFound(),
        );
      },
      // home: const AuthPage(),
    );
  }
}
