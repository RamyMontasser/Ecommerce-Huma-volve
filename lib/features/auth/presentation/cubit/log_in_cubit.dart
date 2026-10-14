import 'package:bloc/bloc.dart';
import 'package:ecommerce_app_huma_volve/features/auth/data/models/login_model.dart';
import 'package:ecommerce_app_huma_volve/features/auth/domain/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthRepo authRepo;
  LogInCubit({required this.authRepo}) : super(LogInInitial());

  Future<void> logIn ({required String email, required String password}) async {
    emit(LogInLoading());
    final response = await authRepo.login(email: email, password: password);
    response.fold(
      (failure)=> emit(LogInFailure(errorMsg: failure.errorMsg)),
      (loginModel)=> emit(LogInSuccess(loginModel: loginModel)) );
  }
  
}
