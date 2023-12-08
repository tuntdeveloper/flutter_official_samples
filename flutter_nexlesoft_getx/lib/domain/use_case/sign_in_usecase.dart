import 'package:flutter_nexlesoft_getx/core/params/sign_in_param.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_usecase.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/sign_in_response.dart';
import 'package:flutter_nexlesoft_getx/domain/repository/auth_repository.dart';

class SignInUsecase extends UseCase<DataState<SignInResponse>, SignInParam> {
  final AuthRepository _authRepository;

  SignInUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<DataState<SignInResponse>> call({required SignInParam params}) {
    return _authRepository.signIn(params);
  }
}
