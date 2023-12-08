import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/category_response.dart';

abstract class CategoryRepository {
  Future<DataState<List<CategoryResponse>>> getAllCategories();
}
