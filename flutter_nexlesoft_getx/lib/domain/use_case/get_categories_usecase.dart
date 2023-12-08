import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_usecase.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/category_response.dart';
import 'package:flutter_nexlesoft_getx/domain/repository/category_repository.dart';

class GetAllCategoriesUsecase
    extends UseCase<DataState<List<CategoryResponse>>, String> {
  final CategoryRepository _categoryRepository;

  GetAllCategoriesUsecase({required CategoryRepository categoryRepository})
      : _categoryRepository = categoryRepository;

  @override
  Future<DataState<List<CategoryResponse>>> call({required String params}) {
    return _categoryRepository.getAllCategories();
  }
}
