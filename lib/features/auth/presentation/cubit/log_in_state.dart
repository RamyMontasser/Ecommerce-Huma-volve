part of 'log_in_cubit.dart';

@immutable
sealed class LogInState {}

final class LogInInitial extends LogInState {}
final class LogInLoading extends LogInState {}
final class LogInSuccess extends LogInState {
  final LoginModel loginModel;

  new({required this.loginModel});
}
final class LogInFailure extends LogInState {
  final String errorMsg;

  new({required this.errorMsg});
}
