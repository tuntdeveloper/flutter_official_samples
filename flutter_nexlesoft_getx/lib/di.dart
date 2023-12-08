import 'package:dio/dio.dart';
import 'package:flutter_nexlesoft_getx/config/constant/api_constant.dart';
import 'package:flutter_nexlesoft_getx/config/constant/pref_constant.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/auth_api_service.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/category_api_service.dart';
import 'package:flutter_nexlesoft_getx/data/repository/auth_repository_impl.dart';
import 'package:flutter_nexlesoft_getx/data/repository/category_repository_implt.dart';
import 'package:flutter_nexlesoft_getx/domain/repository/auth_repository.dart';
import 'package:flutter_nexlesoft_getx/domain/repository/category_repository.dart';
import 'package:flutter_nexlesoft_getx/domain/use_case/get_categories_usecase.dart';
import 'package:flutter_nexlesoft_getx/domain/use_case/sign_in_usecase.dart';
import 'package:flutter_nexlesoft_getx/domain/use_case/sign_up_usecase.dart';
import 'package:flutter_nexlesoft_getx/presentation/auth/controller/auth_controller.dart';
import 'package:flutter_nexlesoft_getx/presentation/home/controller/home_controller.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  final dioOption = BaseOptions(
    baseUrl: ApiConstant.baseUrl,
    headers: {
      'content-type': 'application/json',
      'authorization': 'Bearer ${prefs.get(PrefConstant.PREF_TOKEN_KEY)}'
    },
  );

  final dioInstance = Dio(dioOption)
    ..interceptors.add(
      PrettyDioLogger(
          requestHeader: true, requestBody: true, responseHeader: true),
    );

  Get.put<Dio>(dioInstance);

  Get.lazyPut<SharedPreferences>(() => prefs);

  Get.put<AuthApiService>(
    AuthApiService(Get.find()),
  );
  Get.put<CategoryApiService>(
    CategoryApiService(Get.find()),
  );

  Get.lazyPut<AuthRepository>(
      () => AuthRepositoryImpl(authApiService: Get.find()));
  Get.lazyPut<CategoryRepository>(
      () => CategoryRepositoryImpl(categoryApiService: Get.find()));

  Get.lazyPut<SignUpUsecase>(() => SignUpUsecase(authRepository: Get.find()));
  Get.lazyPut<SignInUsecase>(() => SignInUsecase(authRepository: Get.find()));
  Get.lazyPut<GetAllCategoriesUsecase>(
      () => GetAllCategoriesUsecase(categoryRepository: Get.find()));

  Get.lazyPut<AuthController>(() => AuthController(
      signInUsecase: Get.find(), signUpUsecase: Get.find(), pref: Get.find()));

  Get.lazyPut<HomeController>(
      () => HomeController(getAllCategoriesUsecase: Get.find()));
}

Future<void> reset() async {
  Get.deleteAll(force: true);
}
