import 'package:dio/dio.dart';
import 'package:flutter_nexlesoft_getx/config/constant/api_constant.dart';
import 'package:flutter_nexlesoft_getx/config/constant/pref_constant.dart';
import 'package:flutter_nexlesoft_getx/core/params/sign_in_param.dart';
import 'package:flutter_nexlesoft_getx/core/params/sign_up_param.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/category_api_service.dart';
import 'package:flutter_nexlesoft_getx/domain/use_case/sign_in_usecase.dart';
import 'package:flutter_nexlesoft_getx/domain/use_case/sign_up_usecase.dart';
import 'package:flutter_nexlesoft_getx/presentation/auth/controller/auth_state.dart';
import 'package:flutter_nexlesoft_getx/theme/components/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_nexlesoft_getx/di.dart' as di;

class AuthController extends GetxController {
  final SignUpUsecase _signUpUsecase;
  final SignInUsecase _signInUsecase;
  final SharedPreferences _pref;

  AuthController(
      {required SignUpUsecase signUpUsecase,
      required SignInUsecase signInUsecase,
      required SharedPreferences pref})
      : _signUpUsecase = signUpUsecase,
        _signInUsecase = signInUsecase,
        _pref = pref;

  var _state = const AuthState();

  AuthState get state => _state;

  Future<void> onSignUp() async {
    if (_state.email?.isEmpty == true || _state.password?.isEmpty == true)
      return;

    _state = _state.copyWith(isLoading: true);

    final signUpResult = await _signUpUsecase(
        params: SignUpParam(
      email: _state.email,
      password: _state.password,
      firstName: 'TUNT',
      lastName: '123',
    ));

    if (!signUpResult.isSuccess) return;

    final signInResult = await _signInUsecase(
        params: SignInParam(
      email: _state.email,
      password: _state.password,
    ));

    if (signInResult.isSuccess) {
      final token = signInResult.data?.accessToken;

      await _pref.setString(PrefConstant.PREF_TOKEN_KEY, token ?? '');

      await di.init();

      _state = _state.copyWith(
        isLoading: false,
        action: AuthStateActionSignInSuccess(),
      );
    }

    update();
  }

  void onChangeData({String? email, String? password}) {
    _state = _state.copyWith(
      email: email ?? _state.email,
      password: password ?? _state.password,
    );

    final validPassword = _state.password ?? '';
    var status = CustomPasswordTextFieldStatus.weak;

    if (validPassword.isEmpty) {
      status = CustomPasswordTextFieldStatus.shouldNotCheck;
      return updateStatus(status);
    }

    if (validPassword.length < 6 || validPassword.length > 18) {
      status = CustomPasswordTextFieldStatus.tooShort;
      return updateStatus(status);
    }

    if (!RegExp('(?=.*[a-z])(?=.*[A-Z])').hasMatch(validPassword)) {
      status = CustomPasswordTextFieldStatus.weak;
      return updateStatus(status);
    }

    if (!RegExp('\\d').hasMatch(validPassword)) {
      status = CustomPasswordTextFieldStatus.fair;
      return updateStatus(status);
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(validPassword)) {
      status = CustomPasswordTextFieldStatus.good;
      return updateStatus(status);
    }

    status = CustomPasswordTextFieldStatus.strong;

    updateStatus(status);
  }

  void updateStatus(CustomPasswordTextFieldStatus status) {
    _state = _state.copyWith(
      passwordStatus: status,
    );

    update();
  }
}
