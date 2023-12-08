import 'package:dio/dio.dart';
import 'package:get/get.dart';

class ApiUtils {
  Future<void> post({
    required String path,
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) async =>
      Get.find<Dio>().post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
}
