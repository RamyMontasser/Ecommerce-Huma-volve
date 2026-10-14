part of 'sign_up_cubit.dart';

@immutable
sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}
final class SignUpLoading extends SignUpState {}
final class SignUpSuccess extends SignUpState {
  final SignupResModel signupResModel;

  new({required this.signupResModel});
}
final class SignUpFailure extends SignUpState {
  final String errorMsg;

  new({required this.errorMsg});

}

