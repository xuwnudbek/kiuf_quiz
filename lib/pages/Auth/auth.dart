import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:kiuf_quiz/providers/auth/auth_provider.dart';
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
                              bgColor: RGB.blueLight,
                              prefixIcon: Ionicons.key_outline,
                              hintText: "id".tr,
                              formatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(provider.isStudent ? 10 : 8),
                              ],
                            ),
                            const SizedBox(height: 8.0),
                            CustomInput(
                              controller: provider.password,
                              bgColor: RGB.blueLight,
                              prefixIcon: Ionicons.lock_closed_outline,
                              hintText: "password".tr,
                              obscureText: true,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 24.0),
                            CustomButton(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  provider.isLoading
                                      ? SizedBox.square(
                                          dimension: 23,
                                          child: CircularProgressIndicator(
                                            color: RGB.white,
                                            strokeWidth: 1.5,
                                          ),
                                        )
                                      : Text(
                                          "login".tr,
                                          style: Get.textTheme.bodyMedium!.copyWith(color: RGB.white),
                                        ),
                                ],
                              ),
                              onPressed: () {
                                provider.login(context);
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
