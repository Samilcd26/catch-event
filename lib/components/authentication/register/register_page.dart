// ignore_for_file: use_build_context_synchronously

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threego/Data/Models/user_model.dart';
import 'package:threego/Data/State/account_cubit.dart';
import 'package:threego/core/SubWidgets/text_field.dart';

@RoutePage()
class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final firstNameController = TextEditingController();
    final lastNameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final checkpasswordController = TextEditingController();

    ////////////////////////////////
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const Text("Startup threego"),
                    const Text("This is free"),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Expanded(
                            child:
                                //?First Name
                                TextFormField(
                                    controller: firstNameController,
                                    decoration: ITextFieldStyle("First Name"),
                                    validator: (value) {
                                      if (value!.trim().isEmpty && value.length < 3) {
                                        return 'En az 3 harf girin';
                                      }
                                      return null;
                                    })),
                        const SizedBox(width: 20),
                        Expanded(
                            child:
                                //?Last Name
                                TextFormField(
                                    controller: lastNameController,
                                    decoration: ITextFieldStyle("Last Name"),
                                    validator: (value) {
                                      if (value!.trim().isEmpty && value.length < 3) {
                                        return 'En az 3 harf girin';
                                      }
                                      return null;
                                    }))
                      ],
                    ),
                    const SizedBox(height: 20),
                    //?email
                    TextFormField(
                        controller: emailController,
                        decoration: ITextFieldStyle("Email"),
                        validator: (value) {
                          if (value!.trim().isEmpty || !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                            return 'Email Formatında olmalı';
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    //?password Name
                    TextFormField(
                        controller: passwordController,
                        decoration: ITextFieldStyle("Password"),
                        validator: (value) {
                          if (value!.trim().isEmpty || !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$').hasMatch(value)) {
                            return 'Şifreniz en az bir küçük harf,büüyk harf, sayı ve uzunluğu 8den fazla olmalı';
                          }
                          return null;
                        }),
                    const SizedBox(height: 20),
                    //?checkpassword
                    TextFormField(
                        controller: checkpasswordController,
                        validator: (value) {
                          if (value!.trim().isEmpty || !value.trim().contains(passwordController.text.trim())) {
                            return 'Şifreniz uyuşmuyor';
                          }
                          return null;
                        },
                        decoration: ITextFieldStyle("Password Again")),
                    const SizedBox(height: 10),
                    Row(
                      children: [Text("Aggre"), TextButton(onPressed: () {}, child: Text("with Terms & condition"))],
                    ),
                    Row(
                      children: [
                        Text("Eğer hasabınız varsa"),
                        TextButton(
                            onPressed: () {
                              AutoRouter.of(context).back();
                            },
                            child: Text("girşi Yapın"))
                      ],
                    ),
                    const SizedBox(height: 10),
                    TextButton(
                        onPressed: () async {
                          //AutoRouter.of(context).push(RegisterDetailRoute());
                          if (formKey.currentState!.validate()) {
                            RegisterModel newUser = RegisterModel(
                                firstname: firstNameController.text.trim(),
                                lastname: lastNameController.text.trim(),
                                email: emailController.text.trim(),
                                password: passwordController.text.trim());

                            bool respons = await context.read<AccountCubit>().registerNewUser(newUser);

                            if (respons) {
                              if (!context.mounted) return;
                              AnimatedSnackBar.rectangle(
                                'Kayıt',
                                'Kayıt Başarılı',
                                type: AnimatedSnackBarType.success,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                            } else {
                              if (!context.mounted) return;
                              AnimatedSnackBar.rectangle(
                                'Hata',
                                'Kayıt Başarısız',
                                type: AnimatedSnackBarType.error,
                                brightness: Brightness.light,
                              ).show(
                                context,
                              );
                            }
                          }
                        },
                        child: Text("Register"),
                        style: TextButton.styleFrom(backgroundColor: Colors.grey.shade100))
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
