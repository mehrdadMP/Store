import 'package:store/data/common/http_client.dart';
import 'package:store/data/source/auth_data_source.dart';

final authRepository = AuthRepository(AuthRemoteDataSource(httpClient));

abstract class IAuthRepository {
  Future<void> signIn(String username, String password);
}

class AuthRepository implements IAuthRepository {
  final IAuthDataSource dataSource;

  AuthRepository(this.dataSource);

  @override
  Future<void> signIn(String username, String password) async =>
      dataSource.signIn(username, password);
}
