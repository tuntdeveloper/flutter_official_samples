import 'package:dio/dio.dart';
import 'package:flutter_nexlesoft_getx/config/constant/api_constant.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/category_response.dart';
import 'package:retrofit/retrofit.dart';

part 'category_api_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class CategoryApiService {
  factory CategoryApiService(Dio dio) = _CategoryApiService;

  @GET('/categories')
  Future<HttpResponse<List<CategoryResponse>>> getAllCategories();
}
