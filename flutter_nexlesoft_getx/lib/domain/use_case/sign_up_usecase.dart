import 'package:flutter_nexlesoft_getx/core/params/sign_up_param.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_state.dart';
import 'package:flutter_nexlesoft_getx/core/resources/data_usecase.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/sign_up_response.dart';
import 'package:flutter_nexlesoft_getx/domain/repository/auth_repository.dart';

class SignUpUsecase extends UseCase<DataState<SignUpResponse>, SignUpParam> {
  final AuthRepository _authRepository;

  SignUpUsecase({required AuthRepository authRepository})
      : _authRepository = authRepository;

  @override
  Future<DataState<SignUpResponse>> call({required SignUpParam params}) {
    return _authRepository.signUp(params);
  }
}
