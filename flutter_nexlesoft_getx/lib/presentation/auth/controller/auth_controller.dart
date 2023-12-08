import 'package:flutter_nexlesoft_getx/config/constant/pref_constant.dart';
import 'package:flutter_nexlesoft_getx/core/params/sign_in_param.dart';
import 'package:flutter_nexlesoft_getx/core/params/sign_up_param.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/domain/use_case/sign_in_usecase.dart';
import 'package:flutter_nexlesoft_getx/domain/use_case/sign_up_usecase.dart';
import 'package:flutter_nexlesoft_getx/presentation/auth/controller/auth_state.dart';
import 'package:flutter_nexlesoft_getx/theme/components/custom_text_field.dart';
import 'package:get/get.dart';
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
    final canNotSignUp = _state.email?.isEmpty == true ||
        _state.password?.isEmpty == true ||
        _state.passwordStatus != CustomPasswordTextFieldStatus.strong;

    if (canNotSignUp) return;

    _state = _state.copyWith(isLoading: true);

    final signUpResult = await _signUpUsecase(
        params: SignUpParam(
      email: _state.email,
      password: _state.password,
      firstName: 'first name of user',
      lastName: 'last name of user',
    ));

    if (!signUpResult.isSuccess) return;

    final signInResult = await _signInUsecase(
        params: SignInParam(
      email: _state.email,
      password: _state.password,
    ));

    if (!signInResult.isSuccess) return;

    final token = signInResult.data?.accessToken;

    final result =
        await _pref.setString(PrefConstant.PREF_TOKEN_KEY, token ?? '');

    if (!result) return;

    await di.reset().then((_) => di.init());

    _state = _state.copyWith(
      isLoading: false,
      action: AuthStateActionSignInSuccess(),
    );

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
