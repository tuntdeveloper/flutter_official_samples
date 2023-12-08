import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? role,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}
