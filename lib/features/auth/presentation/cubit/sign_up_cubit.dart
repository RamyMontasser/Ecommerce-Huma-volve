import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_req_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/signup_res_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepo authRepo;
  SignUpCubit({required this.authRepo}) : super(SignUpInitial());

  Future<void> signUp({required SignupReqModel signupReqModel}) async {
    emit(SignUpLoading());
    final response = await authRepo.signUp(signupReqModel: signupReqModel );
    response.fold(
      (failure) => emit(SignUpFailure(errorMsg: failure.errorMsg)),
      (signUpModel) => emit(SignUpSuccess( signupResModel: signUpModel)),
    );
  }
}
