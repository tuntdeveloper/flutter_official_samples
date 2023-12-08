import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/category_response.dart';
import 'package:flutter_nexlesoft_getx/domain/use_case/get_categories_usecase.dart';
import 'package:flutter_nexlesoft_getx/presentation/home/controller/home_state.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final GetAllCategoriesUsecase _getAllCategoriesUsecase;

  HomeController({required GetAllCategoriesUsecase getAllCategoriesUsecase})
      : _getAllCategoriesUsecase = getAllCategoriesUsecase;

  var _state = const HomeState();

  HomeState get state => _state;

  Future<void> onGetAllCategories() async {
    _state = _state.copyWith(isLoading: true);

    final result = await _getAllCategoriesUsecase.call(params: '');

    if (result.isSuccess) {
      _state = _state.copyWith(
          categories: result.data?.map((e) => e.toModel).toList() ?? [],
          isLoading: false);
    }

    update();
  }

  void onSelectCategory(int? id) {
    _state = _state.copyWith(
        categories: _state.categories.map((e) {
      if (e.id == id) {
        return e.copyWith(isSelected: !(e.isSelected ?? false));
      }

      return e;
    }).toList());

    update();
  }
}
