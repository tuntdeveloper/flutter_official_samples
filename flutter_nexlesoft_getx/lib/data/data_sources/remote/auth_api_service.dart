import 'package:dio/dio.dart';
import 'package:flutter_nexlesoft_getx/config/constant/api_constant.dart';
import 'package:flutter_nexlesoft_getx/core/params/sign_in_param.dart';
import 'package:flutter_nexlesoft_getx/core/params/sign_up_param.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/sign_in_response.dart';
import 'package:flutter_nexlesoft_getx/data/data_sources/remote/dto/sign_up_response.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiConstant.baseUrl)
abstract class AuthApiService {
  factory AuthApiService(Dio dio) = _AuthApiService;

  @POST('/auth/signup')
  Future<HttpResponse<SignUpResponse>> signUp(@Body() SignUpParam param);

  @POST('/auth/signin')
  Future<HttpResponse<SignInResponse>> signIn(@Body() SignInParam param);
}
