import 'package:cleanarch/features/auth/presentation/riverpod/auth_provider.dart';
import 'package:cleanarch/features/auth/presentation/riverpod/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../product/presentation/pages/product_page.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({super.key});

  @override
  ConsumerState createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void login() {
    final username = usernameController.text.trim();
    final password = passwordController.text.trim();
    if (username.isNotEmpty && password.isNotEmpty) {
      ref.read(authNotifierProvider.notifier).signIn(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AuthState>(authNotifierProvider, (previous, next) {
      if (next is AuthSuccess) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProductPage()),
        );
      } else if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.my_message)),
        );
      }
    });
    final authState = ref.watch(authNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Sign In"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: "Username"),
            ),
            const SizedBox(
              height: 30,
            ),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: const Text(
                "Sign in",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            authState is AuthLoading
                ? const CircularProgressIndicator()
                : const SizedBox.shrink(),
            authState is AuthError
                ? Text(
                    authState.my_message,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
