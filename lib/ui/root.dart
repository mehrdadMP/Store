import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:store/ui/cart/cart.dart';
import 'package:store/ui/home/home.dart';

const int cartIndex = 0;
const int homeIndex = 1;
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
    final ThemeData themeData = Theme.of(context);
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
        body: Stack(
          children: [
            IndexedStack(
              index: selectedScreenIndex,
              children: [
                _navigator(_cartKey, cartIndex, Center(child: CartScreen())),
                _navigator(
                  _homeKey,
                  homeIndex,
                  HomeScreen(screenSize: widget.screenSize),
                ),
                _navigator(
                    _profileKey,
                    profileIndex,
                    Center(
                      child: Text('Profile Screen'),
                    ))
              ],
            ),
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: themeData.colorScheme.secondary),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),

                  ///This [MediaQuery] widget lets add some padding at the bottom of
                  ///[BottomNavigationBar], set padding under it's [BottomNavigationBarItem]'s
                  ///[label]. If you set padding on [BottomNavigationBarItem]'s [Icon], it
                  ///will not set padding under it's label, just set padding on the top of Icon.
                  child: MediaQuery(
                    data: MediaQueryData(viewPadding: EdgeInsets.all(3)),
                    child: BottomNavigationBar(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      unselectedItemColor: themeData.colorScheme.onSecondary,
                      selectedItemColor: themeData.colorScheme.primary,
                      currentIndex: selectedScreenIndex,
                      onTap: (selectedTabIndex) {
                        setState(() {
                          _history.remove(selectedScreenIndex);
                          _history.add(selectedScreenIndex);
                          selectedScreenIndex = selectedTabIndex;
                        });
                      },
                      items: const <BottomNavigationBarItem>[
                        BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Icon(
                                CupertinoIcons.cart,
                              ),
                            ),
                            label: 'سبد خرید'),
                        BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Icon(CupertinoIcons.home),
                            ),
                            label: 'خانه'),
                        BottomNavigationBarItem(
                            icon: Padding(
                              padding: EdgeInsets.only(top: 3),
                              child: Icon(CupertinoIcons.person_fill),
                            ),
                            label: 'پروفایل'),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
