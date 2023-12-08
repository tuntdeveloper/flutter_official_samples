import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_response.freezed.dart';

part 'sign_up_response.g.dart';

@freezed
class SignUpResponse with _$SignUpResponse {
  const factory SignUpResponse({
    int? id,
    String? email,
    String? password,
    String? firstName,
    String? lastName,
    String? role,
  }) = _SignUpResponse;

  factory SignUpResponse.fromJson(Map<String, Object?> json) =>
      _$SignUpResponseFromJson(json);
}
