import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store/ui/home/home.dart';

const int homeIndex = 0;
const int cartIndex = 1;
const int profileIndex = 2;

class RootScreen extends StatefulWidget {
  final Size screenSize;

  const RootScreen({super.key, required this.screenSize});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int selectedScreenIndex = homeIndex;
  final List<int> _history = [];
  GlobalKey<NavigatorState> _homeKey = GlobalKey();
  GlobalKey<NavigatorState> _cartKey = GlobalKey();
  GlobalKey<NavigatorState> _profileKey = GlobalKey();

  late final map = {
    homeIndex: _homeKey,
    cartIndex: _cartKey,
    profileIndex: _profileKey,
  };
  Future<bool> _onPopInvoked() async {
    final NavigatorState currentSelectedTabNavigatorState = _homeKey.currentState!;
    if (currentSelectedTabNavigatorState.canPop()) {
      currentSelectedTabNavigatorState.pop();
      return false;
    } else if (_history.isNotEmpty) {
      setState(() {
        selectedScreenIndex = _history.last;
        _history.removeLast();
      });
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        final NavigatorState currentSelectedTabNavigatorState =
            map[selectedScreenIndex]!.currentState!;
        if (currentSelectedTabNavigatorState.canPop()) {
          currentSelectedTabNavigatorState.pop();
        } else if (_history.isNotEmpty) {
          setState(() {
            selectedScreenIndex = _history.last;
            _history.removeLast();
          });
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: selectedScreenIndex,
          children: [
            _navigator(
              _homeKey,
              homeIndex,
              HomeScreen(screenSize: widget.screenSize),
            ),
            _navigator(
                _cartKey,
                cartIndex,
                Center(
                  child: Text(
                    'Cart Screen${widget.screenSize}',
                  ),
                )),
            _navigator(
                _profileKey,
                profileIndex,
                Center(
                  child: Text('Profile Screen'),
                ))
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedScreenIndex,
          onTap: (selectedTabIndex) {
            setState(() {
              _history.remove(selectedScreenIndex);
              _history.add(selectedScreenIndex);
              selectedScreenIndex = selectedTabIndex;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: 'خانه'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.cart), label: 'سبد خرید'),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.person_fill), label: 'پروفایل'),
          ],
        ),
      ),
    );
  }

  Widget _navigator(GlobalKey key, int index, Widget child) {
    return key.currentState == null && selectedScreenIndex != index
        ? Container()
        : Navigator(
            key: key,
            onGenerateRoute: (settings) => MaterialPageRoute(
                builder: (context) =>
                    Offstage(offstage: selectedScreenIndex != index, child: child)));
  }
}
