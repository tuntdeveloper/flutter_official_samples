import 'package:flutter_nexlesoft_getx/theme/components/custom_text_field.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_state.freezed.dart';

@freezed
class AuthState with _$AuthState {
  const factory AuthState({
    @Default(false) bool isLoading,
    String? email,
    String? password,
    @Default(CustomPasswordTextFieldStatus.weak)
    CustomPasswordTextFieldStatus passwordStatus,
    AuthStateAction? action,
  }) = _AuthState;
}

@freezed
class AuthStateAction with _$AuthStateAction {
  factory AuthStateAction.onSignUpSuccess() = AuthStateActionSignUpSuccess;

  factory AuthStateAction.onSignInSuccess() = AuthStateActionSignInSuccess;
}
