import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:store/ui/auth/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required Size screenSize});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Profile Screen'),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => AuthScreen(),
                ));
              },
              child: Text('Register'))
        ],
      ),
    );
  }
}
