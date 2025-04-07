import 'package:dio/dio.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> signIn({required String username, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl({required this.dio});

  @override
  Future<UserModel> signIn({required String username, required String password}) async {
    final response = await dio.post(
      'https://dummyjson.com/auth/login',
      data: {
        'username': username,
        'password': password,
        'expiresInMins': 30,
      },
      options: Options(
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception('Failed to sign in');
    }
  }
}
