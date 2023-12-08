import 'package:flutter_nexlesoft_getx/data/model/category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<CategoryModel> categories,
  }) = _HomeState;
}

extension HomeStateX on HomeState {
  bool get shouldShowDone {
    return categories.map((e) => e.isSelected).where((a) => a == true).toList().length >= 1;
  }
}
