import 'package:cleanarch/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:cleanarch/features/auth/presentation/riverpod/auth_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final SignInUseCase signInUseCase;

  AuthNotifier({required this.signInUseCase}) : super(AuthInitial());

  Future<void> signIn(String username, String password) async {
    try {
      state = AuthLoading();
      final user = await signInUseCase(username: username, password: password);
      state = AuthSuccess(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}
