import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/ui/auth/auth_screen_components_transition.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  late AnimationController controller;
  bool? isInLoginMode;
  @override
  void initState() {
    isInLoginMode = true;
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      backgroundColor: themeData.colorScheme.secondary,
      body: AuthScreenTransition(
        controller: controller,
        isInLoginMode: isInLoginMode,
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
                  isInLoginMode! ? 'خوش آمدید' : 'فرم ثبت نام',
                  style: themeData.textTheme.bodyLarge!.copyWith(
                      color: themeData.colorScheme.onSecondary,
                      fontWeight: FontWeight.w700,
                      fontSize: 25),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  isInLoginMode!
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
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
                  child: Column(
                    children: [
                      TextField(
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
                        themeData: themeData,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      _SignInSignUpButton(
                        onTap: () {
                          authRepository.signIn("test@gmail.com", "123456");
                        },
                        themeData: themeData,
                        isInLoginMode: isInLoginMode!,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isInLoginMode! ? 'حساب کاربری ندارید؟' : 'حساب کاربری دارید؟',
                            style: themeData.textTheme.bodyMedium!
                                .copyWith(color: themeData.colorScheme.onSecondary),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              if (controller.isCompleted) {
                                return setState(() {
                                  isInLoginMode = !isInLoginMode!;
                                  controller.repeat();
                                });
                              }
                            },
                            child: Text(isInLoginMode! ? 'ثبت نام' : 'ورود',
                                style: themeData.textTheme.bodyMedium!.copyWith(
                                    color: themeData.colorScheme.onPrimary,
                                    decoration: TextDecoration.underline,
                                    decorationColor: themeData.colorScheme.onPrimary)),
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
      ),
    );
  }
}

class _SignInSignUpButton extends StatelessWidget {
  final bool? isInLoginMode;

  final void Function()? onTap;

  const _SignInSignUpButton({
    super.key,
    required this.themeData,
    required this.isInLoginMode,
    this.onTap,
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
                  child: Text(
                    isInLoginMode! ? 'ورود' : 'ثبت نام',
                    style: themeData.textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w600),
                  )),
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordTextField extends StatefulWidget {
  const _PasswordTextField({
    super.key,
    required this.themeData,
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
