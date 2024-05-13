import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kiuf_quiz/pages/404/not_found.dart';

import 'package:kiuf_quiz/controllers/language/language.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/routes.dart';
import 'package:kiuf_quiz/utils/theme_data.dart';

import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GetStorage.init("kiuf_quiz");

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
      initialRoute: "/splash",
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const <Locale>[
        Locale('uz', 'UZ'),
        Locale('en'),
      ],
      locale: const Locale('uz', 'UZ'),
      translations: Language(),
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: GoogleFonts.montserrat().fontFamily,
        appBarTheme: CustomThemeData.appBarTheme,
        textTheme: GoogleFonts.montserratTextTheme(),
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
    );
  }
}
