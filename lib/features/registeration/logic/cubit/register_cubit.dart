import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  PageController pageController = PageController();
  TextEditingController userController = TextEditingController();
  TextEditingController sureController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController repassController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future register() async {
    if (!formKey.currentState!.validate()) {
      emit(RegisterError('please you have to fill all input places'));
      return;
    }
    emit(RegisterLoaded());
    try {
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError('error $e'));
    }
  }
}
