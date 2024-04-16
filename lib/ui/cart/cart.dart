import 'package:flutter/material.dart';
import 'package:store/data/repo/auth_repository.dart';
import 'package:store/ui/auth/auth.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("سبد خرید"),
      ),
      body: ValueListenableBuilder(
        valueListenable: AuthRepository.authChangeNotifier,
        builder: (BuildContext context, authState, Widget? child) {
          bool isAuthenticated = authState != null && authState.accessToken.isNotEmpty;
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isAuthenticated ? 'خوش آمدید' : 'لطفا وارد حساب کاربری خود شوید'),
                isAuthenticated
                    ? ElevatedButton(
                        onPressed: () {
                          authRepository.signOut();
                        },
                        child: Text('خروج از حساب'))
                    : Container(),
                if (!isAuthenticated)
                  ElevatedButton(
                      onPressed: () {
                        Navigator.of(context, rootNavigator: true).push(MaterialPageRoute(
                          builder: (context) {
                            return AuthScreen();
                          },
                        ));
                      },
                      child: Text('ورود'))
              ],
            ),
          );
        },
        child: Container(),
      ),
    );
  }
}
