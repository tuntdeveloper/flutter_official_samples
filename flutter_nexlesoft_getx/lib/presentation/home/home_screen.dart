import 'package:flutter/material.dart';
import 'package:flutter_nexlesoft_getx/presentation/auth/sign_up_screen.dart';
import 'package:flutter_nexlesoft_getx/presentation/home/controller/home_controller.dart';
import 'package:flutter_nexlesoft_getx/presentation/home/controller/home_state.dart';
import 'package:flutter_nexlesoft_getx/presentation/home/home_category_item_widget.dart';
import 'package:flutter_nexlesoft_getx/route/app_route.dart';
import 'package:flutter_nexlesoft_getx/theme/components/custom_background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<HomeController>().onGetAllCategories();
  }

  @override
  Widget build(BuildContext context) {
    return AuthBackground(
      path: 'assets/images/im_home_background.png',
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 44.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () async {
                        await Get.find<SharedPreferences>().clear();
                        Get.offAndToNamed(AppRoute.signUp.getPath);
                      },
                      child: const Icon(Icons.arrow_back_ios,
                          color: Colors.white)),
                  GetBuilder<HomeController>(builder: (controller) {
                    return InkWell(
                        onTap: () {
                          if (!controller.state.shouldShowDone) return;

                          //TODO Navigate inside app
                        },
                        child: Text('Done',
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: controller.state.shouldShowDone
                                        ? Colors.white
                                        : Colors.white54)));
                  })
                ],
              ),
              SizedBox(height: 200.h),
              Text('Welcome to Flutter Test',
                  style: Theme.of(context).textTheme.bodyLarge),
              Text(
                  'Please select categories what you would like to\nsee on your feed. You can set this later on Filter.',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 14.sp, color: Colors.white.withOpacity(0.82))),
              GetBuilder<HomeController>(builder: (controller) {
                if (controller.state.isLoading)
                  return Center(child: const CircularProgressIndicator());

                return GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1.5,
                      mainAxisSpacing: 8.w,
                      crossAxisSpacing: 8.w,
                    ),
                    itemCount: controller.state.categories.length,
                    itemBuilder: (context, index) {
                      return HomeCategoryItemWidget(
                        data: controller.state.categories[index],
                        onTap: controller.onSelectCategory,
                      );
                    });
              }),
            ],
          ),
        ),
      ),
    );
  }
}
