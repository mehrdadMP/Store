import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/data/product.dart';
import 'package:store/data/repo/product_repository.dart';
import 'package:store/gen/assets.gen.dart';
import 'package:store/mobile_screen.dart';
import 'package:store/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    productRepository.getAll(ProductSort.priceHighToLow).then((value) {
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
          bodyMedium: defaultTextStyle.copyWith(fontWeight: FontWeight.w700),
          bodySmall: defaultTextStyle.copyWith(
              color: LightThemeColor.secondaryTextColor),
          titleLarge: defaultTextStyle.copyWith(fontWeight: FontWeight.w700),
        ),
        colorScheme: ColorScheme.light(
          primary: LightThemeColor.primaryColor,
          secondary: LightThemeColor.secondaryColor,
        ),
        useMaterial3: true,
      ),
      home: XiaomiNote9S(
        home:
            Directionality(textDirection: TextDirection.rtl, child: HomePage()),
        enableStatusBar: true,
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        shadowColor: Colors.black,
        elevation: 5,
        title: Text(
          'فروشگاه',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'سلام فلاتر',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            FloatingActionButton(
              onPressed: () {},
              child: Icon(CupertinoIcons.add),
            )
          ],
        ),
      ),
    );
  }
}
