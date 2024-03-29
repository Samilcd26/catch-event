import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threego/app/app_router.dart';
import 'package:threego/core/SubWidgets/dividers.dart';
import 'package:threego/core/SubWidgets/loading_animation.dart';

import '../../../Data/State/account_cubit.dart';

@RoutePage()
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isUserLoaded = false;
  // late bool isIOS;
  @override
  void initState() {
    //! user login kontrolü
    WidgetsBinding.instance.addPostFrameCallback((_) {
      initS();
    });
    super.initState();
    //isIOS = Theme.of(context).platform == TargetPlatform.iOS;
  }

  Future initS() async {
    await context.read<AccountCubit>().checkLoginUser();
    isUserLoaded = context.read<AccountCubit>().isUserLogin;
    if (isUserLoaded) {
      await context.read<AccountCubit>().initializ();
      AutoRouter.of(context).push(RootRoute());
    } else {
      setState(() {
        isUserLoaded = context.read<AccountCubit>().isUserLogin;
      });
    }
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return isUserLoaded != false
        ? SafeArea(
            child: Scaffold(
            //! overflow remov
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  //! Columan add scroll
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 150, child: Image.asset('assets/logo.png')),
                        const SizedBox(height: 70),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'email is required';
                            }
                            return null;
                          },
                          decoration: LoginInputDecoration("Email"),
                        ),
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: passwordController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          validator: (value) {
                            if (value!.trim().isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.visiblePassword,
                          decoration: LoginInputDecoration("Password"),
                        ),
                        const SizedBox(height: 50),
                        TextButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                isUserLoaded = await context.read<AccountCubit>().loginUser(emailController.text, passwordController.text);
                                if (isUserLoaded) {
                                  if (context.mounted) return;
                                  AnimatedSnackBar.rectangle(
                                    'Success',
                                    'Giriş Başarılı',
                                    type: AnimatedSnackBarType.success,
                                    brightness: Brightness.light,
                                  ).show(
                                    context,
                                  );
                                  context.read<AccountCubit>().initializ();
                                  Future.delayed(const Duration(milliseconds: 200), () {
                                    context.read<AccountCubit>().currentUser;
                                    AutoRouter.of(context).push(RootRoute());
                                  });
                                } else {
                                  if (context.mounted) return;
                                  AnimatedSnackBar.rectangle(
                                    'Success',
                                    'Giriş Başarısız',
                                    type: AnimatedSnackBarType.error,
                                    brightness: Brightness.light,
                                  ).show(
                                    context,
                                  );
                                }
                              }
                            },
                            style: TextButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: Colors.grey.shade100),
                            child: const Text("Login")),
                        DividerWithText(text: "OR", hight: 20),
                        TextButton(
                            onPressed: () {
                              AutoRouter.of(context).push(const RegisterRoute());
                            },
                            style: TextButton.styleFrom(minimumSize: const Size.fromHeight(50), backgroundColor: Colors.grey.shade100),
                            child: const Text("Register")),
                        const SizedBox(height: 50),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            _BoxIconButton(icon: Icons.g_mobiledata),
                            _BoxIconButton(icon: Icons.facebook),
                            _BoxIconButton(icon: Icons.login),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ))
        : const LoadingBar();
  }

  InputDecoration LoginInputDecoration(String hitText) => InputDecoration(border: const OutlineInputBorder(), hintText: hitText);
}

class _BoxIconButton extends StatelessWidget {
  const _BoxIconButton({super.key, required this.icon});
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      decoration: BoxDecoration(border: Border.all(color: Colors.white), borderRadius: const BorderRadius.all(Radius.circular(15))),
      child: IconButton(
          onPressed: () {},
          icon: SizedBox.fromSize(
            size: const Size.fromRadius(200),
            child: FittedBox(
              child: Icon(icon),
            ),
          )),
    );
  }
}
