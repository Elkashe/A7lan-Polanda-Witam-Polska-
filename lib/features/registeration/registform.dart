import 'package:a7lanpopo/core/sharedpref/shared.dart';
import 'package:a7lanpopo/features/google_logo/logo.dart';
import 'package:a7lanpopo/features/registeration/logic/cubit/register_cubit.dart';
import 'package:a7lanpopo/features/routes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// ignore: must_be_immutable
class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Registered'),
              backgroundColor: Colors.green,
            ));

            Navigator.pushReplacementNamed(context, Routes.login);
          }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
                child: BlocBuilder<RegisterCubit, RegisterState>(
                  builder: (context, state) {
                    final cubit = context.read<RegisterCubit>();
                    if (state is RegisterLoaded) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return Form(
                      key: cubit.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Register',
                            style: GoogleFonts.abhayaLibre(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 30),
                          TextFormField(
                            controller: cubit.userController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'your name';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Type Your Name',
                              hintStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              labelText: 'UserName',
                              labelStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              prefixIcon: const Icon(Icons.person),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: cubit.sureController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'your SureName';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Type Your SureName',
                              hintStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              labelText: 'SureName',
                              labelStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              prefixIcon: const Icon(Icons.person),
                            ),
                            textCapitalization: TextCapitalization.sentences,
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: cubit.emailController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.endsWith('.com')) {
                                return 'Please Inter Valid Email';
                              }
                              return null;
                            },
                            textCapitalization: TextCapitalization.sentences,
                            decoration: InputDecoration(
                              hintText: 'Type your Email',
                              hintStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              labelText: 'Email',
                              labelStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              prefixIcon: const Icon(Icons.email),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: cubit.passController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 8) {
                                return 'Please Enter Correct Password';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Type your password',
                              hintStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              labelText: 'Password',
                              labelStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: cubit.repassController,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value !=
                                      cubit
                                          .passController
                                          .text) {
                                return 'Passwords Are Not Matched';
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Retype Your Password',
                              hintStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              labelText: 'Retype Your Password',
                              labelStyle:
                                  GoogleFonts.abhayaLibre(color: Colors.black),
                              prefixIcon: const Icon(Icons.lock),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                // Forgot password action
                              },
                              child: Text(
                                'Forgot password?',
                                style: GoogleFonts.abhayaLibre(
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: [Colors.purple, Colors.pink],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: ElevatedButton(
                              onPressed: () async {
                                if (cubit.formKey.currentState != null && cubit.formKey.currentState!.validate()) {
                                  await cubit.register();
                                  String email = cubit.emailController.text;
                                  String password = cubit.passController.text;


                                  if (email.isNotEmpty && password.isNotEmpty) {
                                    await CacheHelper.putString(
                                        key: 'email',
                                        value: cubit.emailController.text);
                                    await CacheHelper.putString(
                                        key: 'password',
                                        value: cubit.passController.text);
                                    await CacheHelper.putBool(
                                        key: 'isLog', value: true);
                                  }
                                }

                                // ignore: use_build_context_synchronously
                                Navigator.pushReplacementNamed(

                                    // ignore: use_build_context_synchronously
                                    context,
                                    Routes.login);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text('LOGIN',
                                    style: GoogleFonts.abhayaLibre(
                                        fontSize: 20, color: Colors.black)),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Or Sign Up Using',
                            style: GoogleFonts.abhayaLibre(),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: () {
                                  // Facebook login action
                                },
                                icon: const Icon(Icons.facebook),
                                color: Colors.blue,
                              ),
                              const GoogleLogo(),
                              IconButton(
                                onPressed: () {
                                  // Google login action
                                },
                                icon: const Icon(Icons.mail_outline),
                                color: Colors.red,
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}






// I Have finished With the registration just we need to connect with the firebase,,,,,,