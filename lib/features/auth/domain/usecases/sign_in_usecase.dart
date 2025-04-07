import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';

import '../entities/user.dart';

class SignInUseCase {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  Future<User> call({required String username, required String password}) {
    return repository.signIn(username: username, password: password);
  }
}
