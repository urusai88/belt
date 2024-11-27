import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../presentation.dart';
import '../../../services.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var _loading = false;

  @override
  Widget build(BuildContext context) {
    final body = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          controller: _nameController,
          textInputAction: TextInputAction.next,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(
            hintText: 'Имя пользователя',
          ),
        ),
        const Gap(8),
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
        const Gap(8),
        IndexedStack(
          sizing: StackFit.passthrough,
          alignment: Alignment.center,
          index: _loading ? 0 : 1,
          children: [
            const Center(child: CircularProgressIndicator()),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Зарегистрироваться'),
            ),
          ],
        ),
        const Gap(8),
        TextButton(
          onPressed: () => context.go('/login'),
          child: const Text('Войти'),
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

  Future<void> _submit() async {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!_loading) {
      setState(() => _loading = true);
      try {
        final response = await ref.read(usersApiProvider).create(
              name: _nameController.text.trim(),
              email: _emailController.text.trim(),
              password: _passwordController.text,
              avatarUrl:
                  'https://fastly.picsum.photos/id/971/800/800.jpg?hmac=Mu9b0yoZMM9SzBBpV-Ze2JXUwh9U-6kN8n6jArvRuFQ',
            );
        response.when(
          success: (user) async {
            await showMessage(
              context: context,
              message: 'Пользователь успешно зарегистрирован',
            );
            if (mounted) {
              context.go('/login');
            }
          },
          failure: (error) =>
              unawaited(showError(context: context, error: error)),
        );
      } catch (e) {
        if (mounted) {
          unawaited(showError(context: context, error: 'Неизвестная ошибка'));
        }
      } finally {
        if (mounted) {
          setState(() => _loading = false);
        }
      }
    }
  }
}
