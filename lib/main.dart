import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/data/product.dart';
import 'package:store/data/repo/banner_repository.dart';
import 'package:store/data/repo/product_repository.dart';
import 'package:store/gen/assets.gen.dart';
import 'package:store/mobile_screen.dart';
import 'package:store/theme.dart';
import 'package:store/ui/home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    productRepository.getAll(ProductSort.priceHighToLow).then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    bannerRepository.getAll().then((value) {
      debugPrint(value.toString());
    }).catchError((e) {
      debugPrint(e.toString());
    });

    final TextStyle defaultTextStyle = TextStyle(
        fontFamily: 'IranYekan', color: LightThemeColor.primaryTextColor);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: TextTheme(
            bodyMedium: defaultTextStyle.copyWith(
                fontWeight: FontWeight.w500, fontSize: 13),
            bodySmall: defaultTextStyle.copyWith(
                color: LightThemeColor.secondaryTextColor, fontSize: 12),
            titleMedium: defaultTextStyle.copyWith(
                fontWeight: FontWeight.normal,
                fontSize: 16,
                color: LightThemeColor.secondaryColor),
            titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.w700),
            labelLarge: defaultTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: LightThemeColor.primaryColor)),
        colorScheme: ColorScheme.light(
          primary: LightThemeColor.primaryColor,
          secondary: LightThemeColor.secondaryColor,
        ),
        useMaterial3: true,
      ),
      home: XiaomiNote9S(
        debugShowCheckedModeBanner: false,
        home: Directionality(
            textDirection: TextDirection.rtl,
            child: HomeScreen(
                screenSize: MobileScreenSize.setXiaomiNote9sScreenSize(
                    enableStatusBar: true))),
        enableStatusBar: true,
      ),
    );
  }
}
