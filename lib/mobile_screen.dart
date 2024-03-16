import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class XiaomiNote9S extends StatelessWidget {
  final Widget home;
  final bool debugShowCheckedModeBanner;
  final bool enableStatusBar;

  XiaomiNote9S({
    super.key,
    required this.home,
    this.debugShowCheckedModeBanner = true,
    required this.enableStatusBar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 392.72727272727275,
          height: 872.7272727272727,
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 35,
                  spreadRadius: 5,
                )
              ],
              borderRadius: BorderRadius.circular(30)),
          child: Column(children: [
            enableStatusBar
                ? const Stack(
                    alignment: Alignment.center,
                    children: [
                      _StatusBar(),
                      _PhoneFrontCamera(),
                      _StatusBarShadow(),
                    ],
                  )
                : Container(),
            _Home(
              home: home,
              enableStatusBar: enableStatusBar,
              debugShowCheckedModeBanner: debugShowCheckedModeBanner,
            ),
          ]),
        ),
      ),
    );
  }
}

class _Home extends StatelessWidget {
  final bool enableStatusBar;

  final bool debugShowCheckedModeBanner;
  const _Home({
    required this.home,
    required this.enableStatusBar,
    required this.debugShowCheckedModeBanner,
  });

  final Widget home;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: enableStatusBar
                ? const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))
                : BorderRadius.circular(30)),
        child: ClipRRect(
          borderRadius: enableStatusBar
              ? const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30))
              : BorderRadius.circular(30),
          child: MaterialApp(
              theme: Theme.of(context),
              scrollBehavior: AppScrollBehavior(),
              debugShowCheckedModeBanner: debugShowCheckedModeBanner,
              home: Scaffold(body: home)),
        ),
      ),
    );
  }
}

class _StatusBarShadow extends StatelessWidget {
  const _StatusBarShadow();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        left: 0,
        right: 0,
        top: 0,
        child: Container(
          height: 35,
          decoration: const BoxDecoration(
              color: Color.fromARGB(52, 0, 0, 0),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),
        ));
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _TimeAndNetworkBitRate(),
          Row(
            children: [
              Icon(
                CupertinoIcons.wifi,
                size: 21,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                CupertinoIcons.chart_bar_fill,
                color: Color.fromARGB(155, 24, 20, 20),
                size: 17,
              ),
              SizedBox(
                width: 5,
              ),
              Icon(CupertinoIcons.battery_25_percent),
              SizedBox(
                width: 5,
              ),
              Text('67%',
                  style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }
}

class _TimeAndNetworkBitRate extends StatefulWidget {
  const _TimeAndNetworkBitRate({
    super.key,
  });

  @override
  State<_TimeAndNetworkBitRate> createState() => _TimeAndNetworkBitRateState();
}

class _TimeAndNetworkBitRateState extends State<_TimeAndNetworkBitRate> {
  DateTime now = DateTime.now();
  Random _networkSpeed = Random();
  int second = 0;
  double downloadRate = 0;
  @override
  void initState() {
    //Set a random networkSpeed just for better UI Experience.
    Timer.periodic(const Duration(seconds: 5), (timer) {
      setState(() {
        downloadRate = _networkSpeed.nextDouble() * 50;
      });
    });

    //Here we compute the time.First we set [second] by realTime second using
    //[now.second] then Every 1 sec, [second] will add one by one until reach
    //60, then it will call [setState] to rebuild widget and set [now] new
    //on UI.
    second = now.second;
    Timer.periodic(const Duration(seconds: 1), (timer) {
      second++;
      if (second == 60) {
        setState(() {
          second = 0;
          now = DateTime.now();
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      '''${now.hour >= 0 && now.hour <= 9 ? '0${now.hour}' : '${now.hour - 12}'}'''
      ''':${now.minute >= 0 && now.minute <= 9 ? '0${now.minute}' : now.minute}'''
      ''' ${now.hour >= 0 && now.hour <= 12 ? 'AM' : 'PM'} | '''
      '''${downloadRate == 0 || downloadRate == 0.00 ? '0.0' : downloadRate.toStringAsFixed(2)}KB/s''',
      style: const TextStyle(fontSize: 14.4, fontWeight: FontWeight.w600),
    );
  }
}

class _PhoneFrontCamera extends StatelessWidget {
  const _PhoneFrontCamera();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 12.5,
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
            boxShadow: const [BoxShadow(blurRadius: 5)],
            border: Border.all(
                width: 6.5, color: const Color.fromARGB(134, 0, 0, 0)),
            color: const Color.fromARGB(183, 133, 122, 122),
            borderRadius: BorderRadius.circular(50)),
      ),
    );
  }
}

class MobileScreenSize {
  static Size _xiaomiNote9S = Size.zero;

  static Size setXiaomiNote9sScreenSize({bool enableStatusBar = false}) {
    _xiaomiNote9S = Size(392.72727272727275,
        enableStatusBar ? (872.7272727272727 - 35) : 872.7272727272727);
    return _xiaomiNote9S;
  }
}

class AppScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
        PointerDeviceKind.trackpad,
      };
}
