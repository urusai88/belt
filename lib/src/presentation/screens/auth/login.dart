import 'dart:async';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain.dart';
import '../../../presentation.dart';
import '../../../services.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _loading = false;

  Future<void> _submit() async {
    if (!_loading) {
      setState(() => _loading = true);
      try {
        final response = await ref.read(authApiProvider).login(
              email: _emailController.text.trim(),
              password: _passwordController.text,
            );
        response.when(
          success: (tokens) async {
            final result = await ref
                .read(authProvider.notifier)
                .authWithTokens(tokens: tokens);
            if (!mounted) {
              return;
            }
            if (result) {
              context.go('/products');
            } else {
              unawaited(
                showError(context: context, error: 'Неизвестная ошибка'),
              );
            }
          },
          failure: (error) =>
              unawaited(showError(context: context, error: error)),
        );
      } catch (error) {
        if (mounted) {
          unawaited(showError(context: context, error: error));
        }
      } finally {
        setState(() => _loading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _emailController,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Почта',
          ),
        ),
        const Gap(8),
        TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Пароль',
          ),
          onSubmitted: (_) => unawaited(_submit()),
        ),
        const Gap(8),
        IndexedStack(
          sizing: StackFit.passthrough,
          alignment: Alignment.center,
          index: _loading ? 0 : 1,
          children: [
            const Center(child: CircularProgressIndicator()),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Войти'),
            ),
          ],
        ),
        const Gap(8),
        TextButton(
          onPressed: () => context.go('/register'),
          child: const Text('Регистрация'),
        ),
      ],
    );

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: body,
      ),
    );
  }
}
