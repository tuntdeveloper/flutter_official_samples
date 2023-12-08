import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_param.freezed.dart';

part 'sign_up_param.g.dart';

@freezed
class SignUpParam with _$SignUpParam {
  const factory SignUpParam({
    String? email,
    String? password,
    String? firstName,
    String? lastName,
  }) = _SignUpParam;

  factory SignUpParam.fromJson(Map<String, Object?> json) =>
      _$SignUpParamFromJson(json);
}
