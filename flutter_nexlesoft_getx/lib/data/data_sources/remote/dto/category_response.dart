import 'package:flutter_nexlesoft_getx/data/model/category_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category_response.freezed.dart';

part 'category_response.g.dart';

@freezed
class CategoryResponse with _$CategoryResponse {
  const factory CategoryResponse({
    int? id,
    String? name,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, Object?> json) =>
      _$CategoryResponseFromJson(json);
}

extension CategoryResponseX on CategoryResponse {
  CategoryModel get toModel {
    return CategoryModel(
      id: id,
      name: name,
    );
  }
}
