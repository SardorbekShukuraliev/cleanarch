import 'package:cleanarch/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:cleanarch/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:cleanarch/features/auth/domain/repositories/auth_repository.dart';
import 'package:cleanarch/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:cleanarch/features/auth/presentation/riverpod/auth_notifier.dart';
import 'package:cleanarch/features/auth/presentation/riverpod/auth_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final dioProvider = Provider<Dio>((ref) => Dio());

final authRemoteDataSourceProvider = Provider<AuthRemoteDataSource>((ref) {
  return AuthRemoteDataSourceImpl(dio: ref.watch(dioProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(ref.watch(authRemoteDataSourceProvider));
});

final signInUseCaseProvider = Provider<SignInUseCase>((ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
});

final authNotifierProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(signInUseCase: ref.watch(signInUseCaseProvider));
});
