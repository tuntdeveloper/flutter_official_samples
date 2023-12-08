import 'package:flutter_nexlesoft_getx/core/params/sign_in_param.dart';
import 'package:flutter_nexlesoft_getx/core/params/sign_up_param.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/sign_in_response.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/sign_up_response.dart';

abstract class AuthRepository {
  Future<DataState<SignUpResponse>> signUp(SignUpParam param);

  Future<DataState<SignInResponse>> signIn(SignInParam param);
}
