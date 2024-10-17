import 'package:a7lanpopo/core/sharedpref/shared.dart';
import 'package:a7lanpopo/features/constant.dart';
import 'package:a7lanpopo/features/google_logo/logo.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class Registration extends StatelessWidget {
  const Registration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Form(
            key: formKey,
            child: Center(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: SingleChildScrollView(
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
                      controller: userController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'your name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Type Your Name',
                        hintStyle: GoogleFonts.abhayaLibre(color: Colors.black),
                        labelText: 'UserName',
                        labelStyle:
                            GoogleFonts.abhayaLibre(color: Colors.black),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: sureController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'your SureName';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        hintText: 'Type Your SureName',
                        hintStyle: GoogleFonts.abhayaLibre(color: Colors.black),
                        labelText: 'SureName',
                        labelStyle:
                            GoogleFonts.abhayaLibre(color: Colors.black),
                        prefixIcon: const Icon(Icons.person),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: emailController,
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
                        hintStyle: GoogleFonts.abhayaLibre(color: Colors.black),
                        labelText: 'Email',
                        labelStyle:
                            GoogleFonts.abhayaLibre(color: Colors.black),
                        prefixIcon: const Icon(Icons.email),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(

                      controller: passController,
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
                        hintStyle: GoogleFonts.abhayaLibre(color: Colors.black),
                        labelText: 'Password',
                        labelStyle:
                            GoogleFonts.abhayaLibre(color: Colors.black),
                        prefixIcon: const Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: repassController,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            value != passController.text) {
                          return 'Passwords Are Not Matched';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Retype Your Password',
                        hintStyle: GoogleFonts.abhayaLibre(color: Colors.black),
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
                          style: GoogleFonts.abhayaLibre(color: Colors.black),
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
                          if (formKey.currentState?.validate() ?? false) {
                            String email = emailController.text;
                            String password = passController.text;

                            if (email.isNotEmpty && password.isNotEmpty) {
                              await CacheHelper.putString(
                                  key: 'email', value: emailController.text);
                              await CacheHelper.putString(
                                  key: 'password', value: passController.text);
                              await CacheHelper.putBool(
                                  key: 'isLog', value: true);
                            }
                          }

                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacementNamed(
                              
                              // ignore: use_build_context_synchronously
                              context, Constant.login);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
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
              ),
            ))));
  }
}
// I Have finished With the registration just we need to connect with the firebase,,,,,,