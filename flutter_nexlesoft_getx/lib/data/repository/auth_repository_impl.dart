import 'package:dio/dio.dart';
import 'package:flutter_nexlesoft_getx/core/params/sign_in_param.dart';
import 'package:flutter_nexlesoft_getx/core/params/sign_up_param.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/auth_api_service.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/sign_in_response.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/sign_up_response.dart';
import 'package:flutter_nexlesoft_getx/domain/repository/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthApiService _authApiService;

  AuthRepositoryImpl({required AuthApiService authApiService})
      : _authApiService = authApiService;

  @override
  Future<DataState<SignInResponse>> signIn(SignInParam param) async {
    final result = await _authApiService.signIn(param);

    if (result.response.statusCode == 200) {
      return DataSuccess(result.data);
    }

    return DataError(DioException(
      error: result.response.statusMessage,
      response: result.response,
      requestOptions: result.response.requestOptions,
    ));
  }

  @override
  Future<DataState<SignUpResponse>> signUp(SignUpParam param) async {
    final result = await _authApiService.signUp(param);

    if (result.response.statusCode == 201 ||
        result.response.statusCode == 200) {
      return DataSuccess(result.data);
    }

    return DataError(DioException(
      error: result.response.statusMessage,
      response: result.response,
      requestOptions: result.response.requestOptions,
    ));
  }
}
