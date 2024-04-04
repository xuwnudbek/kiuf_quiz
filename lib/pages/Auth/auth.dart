import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/providers/auth_provider.dart';
import 'package:kiuf_quiz/utils/rgb.dart';
import 'package:kiuf_quiz/utils/widgets/custom_input.dart';
import 'package:kiuf_quiz/utils/widgets/cutom_button.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AuthProvider>(
      create: (ctx) => AuthProvider(),
      builder: (context, snapshot) {
        return Consumer<AuthProvider>(builder: (context, provider, _) {
          return Scaffold(
            body: Center(
              child: Container(
                width: Get.width * 0.4,
                height: Get.height * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 3,
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Flexible(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'LOGIN',
                                  style: Get.textTheme.titleLarge!.copyWith(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16.0),
                            CustomInput(
                              controller: provider.userId,
                              prefixIcon: Ionicons.key_outline,
                              hintText: "User ID",
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(10),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            CustomInput(
                              controller: provider.password,
                              prefixIcon: Ionicons.lock_closed_outline,
                              hintText: "Password",
                              obscureText: true,
                            ),
                            const SizedBox(height: 24.0),
                            CustomButton(
                              title: provider.isLoading
                                  ? SizedBox.square(
                                      dimension: 20,
                                      child: CircularProgressIndicator(
                                        color: RGB.white,
                                        strokeWidth: 1.5,
                                      ),
                                    )
                                  : Text(
                                      "Kirish",
                                      style: Get.textTheme.bodyMedium!.copyWith(color: RGB.white),
                                    ),
                              onPressed: () {
                                provider.login();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        decoration: const BoxDecoration(
                          // color: RGB.middle,
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                          image: DecorationImage(
                            image: AssetImage('assets/images/kiuf.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
