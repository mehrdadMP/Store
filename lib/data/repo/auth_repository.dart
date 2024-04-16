import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:store/data/auth_data.dart';
import 'package:store/data/common/http_client.dart';
import 'package:store/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> signIn(String username, String password);
  Future<void> signOut();
  Future<void> signUp(String username, String password);
  Future<void> refreshToken();
}

class AuthRepository implements IAuthRepository {
  static final ValueNotifier<AuthData?> authChangeNotifier = ValueNotifier(null);

  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);

  @override
  Future<void> signIn(String username, String password) async {
    final AuthData authData = await dataSource.signIn(username, password);
    _persistAuthTokens(authData);
    loadAuthInfo();
  }

  @override
  Future<void> signUp(String username, String password) async {
    final AuthData authData = await dataSource.signUp(username, password);
    _persistAuthTokens(authData);
    loadAuthInfo();
  }

  @override
  Future<void> refreshToken() async {
    final AuthData authData = await dataSource.refreshToken(
        "def50200934cc653cb2d8dd58da9968c8aba5979f0508e35bc2f086ab175102b877d482307523b9472a0b5259e0c074decbed4d143e7d03b67e2e3d48ec0bab9722a12e57f5fe4c44171e8263dcd0d3e709f4f5d1a0d77a35c29607f3748ddf406c39c0030ccf1a57ae8133e7d01b543735d0b66d9606ea9460bb8be8d53d0d1262cc81f1550477cde6f698e8a08302c7e1536a4d51be68143b425e68359fe6a96f15dd01a9c4d09b5958e804e83ee469f2449a6cd6e9cafc36546585c0fdb9e67f36a42ec939f8d1c58336862e7bdff5718c38e35d872923685fdec2486c8410a0b60efb2d58f1ea36854675fdb032821c9ec02ab981da1a3ac221f292be634ccf7939016775ea6c36107e175ac4e7e2736442a18023b2b9d438341baccb6634f02b73f2118d80fa56007a39f74886e1742bd9cbba5a3e4c7e00b62dd220912cf590cad5c29a1c84e5ff78fb84a039237bc085bf25213bc6748735b5eba5982922e");
    _persistAuthTokens(authData);
  }

  Future<void> _persistAuthTokens(AuthData authData) async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("access_token", authData.accessToken);
    sharedPreferences.setString("refresh_token", authData.refreshToken);
  }

  Future<void> loadAuthInfo() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final String accessToken = sharedPreferences.getString("access_token") ?? '';
    final String refreshToken = sharedPreferences.getString("refresh_token") ?? '';
    //debugPrint(accessToken);
    if (accessToken.isNotEmpty && refreshToken.isNotEmpty) {
      authChangeNotifier.value = AuthData(accessToken, refreshToken);
    }
  }

  @override
  Future<void> signOut() async {
    final SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    authChangeNotifier.value = null;
  }
}
