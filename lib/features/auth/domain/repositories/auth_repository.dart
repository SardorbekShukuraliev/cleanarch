import '../entities/user.dart';

abstract class AuthRepository {
  Future<User> signIn({required String username, required String password});
}
