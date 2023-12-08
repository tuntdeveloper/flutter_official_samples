import 'package:flutter/material.dart';
import 'package:flutter_nexlesoft_getx/data/model/category_model.dart';
import 'package:flutter_nexlesoft_getx/presentation/home/controller/home_controller.dart';
import 'package:flutter_nexlesoft_getx/presentation/home/controller/home_state.dart';
import 'package:flutter_nexlesoft_getx/theme/components/custom_background.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static Future<dynamic> push(BuildContext context) async {
    return Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => const HomeScreen()));
  }

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
                  const Icon(Icons.arrow_back_ios, color: Colors.white),
                  GetBuilder<HomeController>(builder: (controller) {
                    return InkWell(
                        onTap: () {
                          if (!controller.state.shouldShowDone) return;
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

class HomeCategoryItemWidget extends StatelessWidget {
  const HomeCategoryItemWidget({
    super.key,
    required this.data,
    required this.onTap,
  });

  final CategoryModel data;
  final void Function(int?) onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap.call(data.id),
      child: Container(
        alignment: Alignment.center,
        decoration: data.isSelected ?? false
            ? BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment(0.49, 0.87),
                  end: Alignment(-0.49, -0.87),
                  colors: [Color(0xFF8A31A8), Color(0xFF8A00FF)],
                ),
              )
            : ShapeDecoration(
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 1,
                    color: Colors.white.withOpacity(0.11999999731779099),
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
        child: Text(
          data.name ?? '',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                height: 0.12,
                fontSize: 14.sp,
                color: Colors.white.withOpacity(0.8199999928474426),
              ),
        ),
      ),
    );
  }
}
