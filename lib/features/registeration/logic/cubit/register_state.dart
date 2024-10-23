part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

 class RegisterLoaded extends RegisterState {}

 class RegisterSuccess extends RegisterState {}

 class RegisterError extends RegisterState {
  final String error;
  RegisterError(this.error);
}