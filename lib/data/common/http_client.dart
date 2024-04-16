import 'package:dio/dio.dart';
import 'package:store/data/repo/auth_repository.dart';

final httpClient = Dio(BaseOptions(baseUrl: 'http://expertdevelopers.ir/api/v1/'))
  ..interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) {
      final authData = AuthRepository.authChangeNotifier.value;
      if (authData != null && authData.accessToken.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer ${authData.accessToken}';
      }
      handler.next(options);
    },
  ));
