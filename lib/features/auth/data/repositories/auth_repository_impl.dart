import 'package:cleanarch/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:cleanarch/features/auth/domain/entities/user.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';


class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<User> signIn({required String username, required String password}) {
    return remoteDataSource.signIn(username: username, password: password);
  }
}
