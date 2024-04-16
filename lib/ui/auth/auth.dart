import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/ui/auth/auth_screen_components_transition.dart';
import 'package:store/ui/auth/bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.secondary,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider<AuthBloc>(
          create: (context) {
            final AuthBloc bloc = AuthBloc(authRepository);
            bloc.stream.forEach((state) {
              if (state is AuthSuccess) {
                Navigator.of(context).pop();
              } else if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Center(child: Text(state.exception.message))));
              }
            });
            bloc.add(AuthScreenStarted());
            return bloc;
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            buildWhen: (previous, current) {
              return current is AuthInitial || current is AuthLoading || current is AuthError;
            },
            builder: (context, state) {
              controller.forward();
              TextEditingController userNameTextEditingControler =
                  TextEditingController(text: "mmmm@gmail.com");
              TextEditingController passwordTextEditingControler =
                  TextEditingController(text: "12345678");
              return AuthScreenTransition(
                controller: controller,
                themeData: themeData,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/img/nike-white.png',
                          width: 120,
                        ),
                        Text(
                          state.isLoginMode ? 'خوش آمدید' : 'فرم ثبت نام',
                          style: themeData.textTheme.bodyLarge!.copyWith(
                              color: themeData.colorScheme.onSecondary,
                              fontWeight: FontWeight.w700,
                              fontSize: 25),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          state.isLoginMode
                              ? 'لطفا وارد حساب کاربری خود شوید'
                              : 'لطفا ایمیل و رمز عبور خود را وارد نمایید',
                          style: themeData.textTheme.bodyMedium!
                              .copyWith(color: themeData.colorScheme.onSecondary, fontSize: 15),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Theme(
                          data: themeData.copyWith(
                              colorScheme: themeData.colorScheme
                                  .copyWith(onSurface: themeData.colorScheme.onSecondary),
                              inputDecorationTheme: InputDecorationTheme(
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(9),
                                      borderSide: BorderSide(color: Colors.white)),
                                  labelStyle: themeData.textTheme.labelLarge!
                                      .copyWith(color: themeData.colorScheme.onSecondary),
                                  border:
                                      OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                          child: Column(
                            children: [
                              TextField(
                                controller: userNameTextEditingControler,
                                style: themeData.textTheme.bodyMedium!.copyWith(
                                    color: themeData.colorScheme.onSecondary,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 15),
                                decoration: InputDecoration(
                                    label: Text(
                                      'آدرس ایمیل',
                                    ),
                                    fillColor: themeData.colorScheme.onSecondary),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              _PasswordTextField(
                                passwordTextEditingControler: passwordTextEditingControler,
                                themeData: themeData,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              _SignInSignUpButton(
                                  onTap: () {
                                    setState(() {
                                      BlocProvider.of<AuthBloc>(context).add(AuthButtonIsClicked(
                                          userNameTextEditingControler.text,
                                          passwordTextEditingControler.text));
                                    });
                                  },
                                  themeData: themeData,
                                  isInLoginMode: state.isLoginMode,
                                  state: state),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    state.isLoginMode
                                        ? 'حساب کاربری ندارید؟'
                                        : 'حساب کاربری دارید؟',
                                    style: themeData.textTheme.bodyMedium!
                                        .copyWith(color: themeData.colorScheme.onSecondary),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if (controller.isCompleted) {
                                        controller.repeat();
                                        return BlocProvider.of<AuthBloc>(context)
                                            .add(AuthModeChangeClicked());
                                      }
                                    },
                                    child: Text(state.isLoginMode ? 'ثبت نام' : 'ورود',
                                        style: themeData.textTheme.bodyMedium!.copyWith(
                                            color: themeData.colorScheme.primary,
                                            decoration: TextDecoration.underline,
                                            decorationColor: themeData.colorScheme.primary)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SignInSignUpButton extends StatelessWidget {
  final bool? isInLoginMode;

  final void Function()? onTap;

  final Object state;

  const _SignInSignUpButton({
    super.key,
    required this.themeData,
    required this.isInLoginMode,
    this.onTap,
    required this.state,
  });

  final ThemeData themeData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50,
            child: Theme(
              data: themeData.copyWith(
                  elevatedButtonTheme: ElevatedButtonThemeData(
                      style: ButtonStyle(
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                          backgroundColor:
                              MaterialStateProperty.all(themeData.colorScheme.onSecondary),
                          foregroundColor:
                              MaterialStateProperty.all(themeData.colorScheme.secondary)))),
              child: ElevatedButton(
                  onPressed: onTap ?? () {},
                  child: state is AuthLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          isInLoginMode! ? 'ورود' : 'ثبت نام',
                          style:
                              themeData.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
                        )),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  final TextEditingController passwordTextEditingControler;

  const _PasswordTextField({
    super.key,
    required this.themeData,
    required this.passwordTextEditingControler,
  });

  final ThemeData themeData;

  @override
  State<_PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<_PasswordTextField> {
  IconData? visibilityIcon;
  bool? obsecureText;
  @override
  void initState() {
    super.initState();
    visibilityIcon = Icons.visibility;
    obsecureText = true;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.passwordTextEditingControler,
      obscureText: obsecureText!,
      keyboardType: TextInputType.visiblePassword,
      style: widget.themeData.textTheme.bodyMedium!.copyWith(
          color: widget.themeData.colorScheme.onSecondary,
          fontWeight: FontWeight.normal,
          fontSize: 15),
      decoration: InputDecoration(
          suffixIcon: Padding(
            padding: const EdgeInsets.only(left: 5),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    obsecureText = !obsecureText!;
                    if (obsecureText!) {
                      visibilityIcon = Icons.visibility;
                    } else {
                      visibilityIcon = Icons.visibility_off;
                    }
                  });
                },
                icon: Icon(
                  visibilityIcon,
                  color: widget.themeData.colorScheme.onSecondary,
                  size: 21,
                )),
          ),
          label: Text(
            'رمز عبور',
            style: widget.themeData.textTheme.labelLarge!
                .copyWith(color: widget.themeData.colorScheme.onSecondary),
          )),
    );
  }
}
