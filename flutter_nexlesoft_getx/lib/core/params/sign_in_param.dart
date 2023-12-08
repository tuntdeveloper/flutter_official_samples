import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_in_param.freezed.dart';

part 'sign_in_param.g.dart';

@freezed
class SignInParam with _$SignInParam {
  const factory SignInParam({
    String? email,
    String? password,
  }) = _SignInParam;

  factory SignInParam.fromJson(Map<String, Object?> json) =>
      _$SignInParamFromJson(json);
}
