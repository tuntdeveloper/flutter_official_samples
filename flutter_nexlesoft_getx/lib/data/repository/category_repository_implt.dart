import 'package:dio/dio.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/category_api_service.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/category_response.dart';
import 'package:flutter_nexlesoft_getx/domain/repository/category_repository.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryApiService _categoryApiService;

  CategoryRepositoryImpl({required CategoryApiService categoryApiService})
      : _categoryApiService = categoryApiService;

  @override
  Future<DataState<List<CategoryResponse>>> getAllCategories() async {
    final result = await _categoryApiService.getAllCategories();

    if (result.response.statusCode == 200) {
      return DataSuccess(result.data);
    }

    return DataError(DioException(
      error: result.response.statusMessage,
      response: result.response,
      requestOptions: result.response.requestOptions,
    ));
  }
}
