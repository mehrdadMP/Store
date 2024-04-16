import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:store/data/auth_data.dart';
import 'package:store/data/common/constants.dart';
import 'package:store/data/common/response_validator.dart';

abstract class IAuthDataSource {
  Future<AuthData> signIn(String username, String password);
  Future<AuthData> signUp(String username, String password);
  Future<AuthData> refreshToken(String refreshToken);
}

class AuthRemoteDataSource with httpResponseValidator implements IAuthDataSource {
  final Dio httpClient;

  AuthRemoteDataSource(this.httpClient);
  @override
  Future<AuthData> refreshToken(String refreshToken) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "refresh_token",
      "refresh_token": refreshToken,
      "client_id": 2,
      "client_secret": Constants.clientSecret,
    });

    validateResponse(response);
    return AuthData(response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthData> signIn(String username, String password) async {
    final response = await httpClient.post("auth/token", data: {
      "grant_type": "password",
      "client_id": 2,
      "client_secret": Constants.clientSecret,
      "username": username,
      "password": password
    });

    validateResponse(response);
    return AuthData(response.data["access_token"], response.data["refresh_token"]);
  }

  @override
  Future<AuthData> signUp(String username, String password) async {
    final response =
        await httpClient.post("user/register", data: {"email": username, "password": password});
    validateResponse(response);
    return signIn(username, password);
  }
}
