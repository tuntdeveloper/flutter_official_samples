import 'package:flutter_nexlesoft_getx/data/model/user_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_response.freezed.dart';

part 'sign_in_response.g.dart';

@freezed
class SignInResponse with _$SignInResponse {
  const factory SignInResponse({
    UserModel? user,
    String? accessToken,
    String? refreshToken,
  }) = _SignInResponse;

  factory SignInResponse.fromJson(Map<String, Object?> json) =>
      _$SignInResponseFromJson(json);
}
