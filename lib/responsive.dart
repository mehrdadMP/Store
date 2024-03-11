import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;

  ///This widget gets its parent's [BoxConstraints], then
  ///compare it with 3 size.
  ///
  ///If it was less than 650, it will return [mobile] screen.
  ///<br />If it was between 650 and 1100, it will return [tablet] screen.
  ///<br />If it was greater than 1100, it will return [desktop] screen.
  const Responsive(
      {super.key,
      required this.mobile,
      required this.tablet,
      required this.desktop});

  /// mobile < 650
  static bool isMobile(BoxConstraints constraints) =>
      constraints.maxWidth < 650;

  /// 650 =< tablet < 1100
  static bool isTablet(BoxConstraints constraints) =>
      constraints.maxWidth >= 650 && constraints.maxWidth < 1100;

  /// 1100 =< desktop
  static bool isDesktop(BoxConstraints constraints) =>
      constraints.maxWidth >= 1100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (isMobile(constraints)) {
          return mobile;
        } else if (isTablet(constraints)) {
          return tablet;
        } else if (isDesktop(constraints)) {
          return desktop;
        } else {
          throw Exception(
              "The parent size is not between any of mobile or tablet or desktop!");
        }
      }),
    );
  }
}
