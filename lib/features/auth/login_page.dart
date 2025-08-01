import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:mrpostsboard/features/auth/store/auth_store.dart';
import 'package:mrpostsboard/shared_widgets/progress_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthStore authStore = Modular.get<AuthStore>();

  late final ReactionDisposer reaction;

  @override
  void dispose() {
    reaction();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    reaction = when(
      (_) => authStore.user != null && authStore.errorMessage == null,
      () => Modular.to.navigate('/board'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You are currently signed out.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'When signed in, you will be redirected to the messages board.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),

            Observer(
              builder: (_) {
                final errorMsg = authStore.errorMessage;

                if (errorMsg == null) {
                  return const SizedBox();
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    errorMsg,
                    style: TextStyle(color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                );
              },
            ),
            ProgressButton(
              label: 'Anonymous Login',
              onPressed: loginAnonymously,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginAnonymously() async {
    await authStore.loginAnonymously();
  }
}
