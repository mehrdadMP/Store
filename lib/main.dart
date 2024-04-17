import 'package:flutter/material.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/mobile_screen.dart';
import 'package:store/theme.dart';
import 'package:store/ui/auth/auth.dart';
import 'package:store/ui/root.dart';

void main() {
  authRepository.loadAuthInfo();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Size> whenNotZero(Stream<Size> source) async {
    await for (Size value in source) {
      if (value.width > 0 && value.height > 0) {
        return value;
      }
    }
    return Size(0, 0);
  }

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultTextStyle =
        TextStyle(fontFamily: 'IranYekan', color: LightThemeColor.primaryTextColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            bodyMedium: defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 13),
            bodyLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.w500, fontSize: 20),
            bodySmall:
                defaultTextStyle.copyWith(color: LightThemeColor.secondaryTextColor, fontSize: 12),
            titleMedium: defaultTextStyle.copyWith(
                fontWeight: FontWeight.normal, fontSize: 16, color: LightThemeColor.secondaryColor),
            titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.w700),
            labelLarge: defaultTextStyle.copyWith(
                fontWeight: FontWeight.w500, fontSize: 14, color: LightThemeColor.primaryColor),
            labelMedium: defaultTextStyle.copyWith(
                fontWeight: FontWeight.w500, fontSize: 12, color: LightThemeColor.primaryColor)),
        colorScheme: ColorScheme.light(
          secondaryContainer: LightThemeColor.secondaryContainer,
          primary: LightThemeColor.primaryColor,
          onPrimary: LightThemeColor.onPrimaryColor,
          secondary: LightThemeColor.secondaryColor,
          onSecondary: Colors.white,
        ),
        useMaterial3: true,
      ),
      home: FutureBuilder(
        future: whenNotZero(
          Stream<Size>.periodic(Duration(milliseconds: 50), (x) => MediaQuery.of(context).size),
        ),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            if (snapshot.data!.width > 0 && snapshot.data!.height > 0) {
              final Size mainScreenSize = snapshot.data!;
              return XiaomiNote9S(
                enableStatusBar: true,
                home: Directionality(
                      textDirection: TextDirection.rtl,
                      child: RootScreen(screenSize: mainScreenSize)), textDirextion: TextDirection.rtl,
              );
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
