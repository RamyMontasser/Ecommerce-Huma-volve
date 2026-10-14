import 'package:dartz/dartz.dart';
import 'package:ecommerce_app_huma_volve/core/errors/failure.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_res_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, SignupResModel>> signUp({
    required SignupReqModel signupReqModel,
  });
  Future<Either<Failure, LoginModel>> login({
    required String email,
    required String password,
  });
}
