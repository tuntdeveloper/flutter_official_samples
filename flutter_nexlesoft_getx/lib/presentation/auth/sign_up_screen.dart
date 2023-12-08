import 'package:flutter/material.dart';
import 'package:flutter_nexlesoft_getx/theme/components/custom_background.dart';
import 'package:flutter_nexlesoft_getx/presentation/auth/controller/auth_controller.dart';
import 'package:flutter_nexlesoft_getx/presentation/auth/controller/auth_state.dart';
import 'package:flutter_nexlesoft_getx/presentation/home/home_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../theme/components/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  void initState() {
    super.initState();

    final controller = Get.find<AuthController>();
    controller.addListener(() {
      if (controller.state.action is AuthStateActionSignInSuccess) {
        HomeScreen.push(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      path: 'assets/images/im_background.png',
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 44.h),
            const Icon(Icons.arrow_back_ios, color: Colors.white),
            const Spacer(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Let\'s get you started!',
                    style: Theme.of(context).textTheme.bodyMedium),
                GetBuilder<AuthController>(builder: (controller) {
                  return CustomTextField.normal(
                    onChange: (email) {
                      controller.onChangeData(email: email);
                    },
                    hintText: 'Your email',
                  );
                }),
                SizedBox(height: 26.h),
                GetBuilder<AuthController>(builder: (controller) {
                  return CustomTextField.password(
                    status: controller.state.passwordStatus,
                    onChange: (password) {
                      controller.onChangeData(password: password);
                    },
                  );
                }),
                SizedBox(height: 52.h),
                Row(
                  children: [
                    Image.asset('assets/icons/ic_check_box.png',
                        height: 23.h, width: 23.h),
                    SizedBox(width: 12.w),
                    Text('I am over 16 years of age',
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
                SizedBox(height: 24.h),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text:
                              'By clicking Sign Up, you are indicating that you have read and agree to the ',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white.withOpacity(0.5),
                                  )),
                      TextSpan(
                          text: 'Terms of Service',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: const Color(0xFF647FFF),
                                  )),
                      TextSpan(
                          text: ' and ',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: Colors.white.withOpacity(0.5),
                                  )),
                      TextSpan(
                          text: 'Privacy Policy',
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: const Color(0xFF647FFF),
                                  )),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
                GetBuilder<AuthController>(builder: (controller) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Sign Up',
                          style: Theme.of(context).textTheme.bodyMedium),
                      InkWell(
                        onTap: () => controller.onSignUp(),
                        child: Container(
                          width: 54.w,
                          height: 54.w,
                          decoration: const ShapeDecoration(
                            shape: OvalBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFF647FFF)),
                            ),
                          ),
                          child: controller.state.isLoading
                              ? const CircularProgressIndicator()
                              : const Icon(Icons.arrow_forward,
                                  color: Colors.white),
                        ),
                      ),
                    ],
                  );
                }),
                SizedBox(height: 50.h),
              ],
            )
          ],
        ),
      ),
    );
  }
}
