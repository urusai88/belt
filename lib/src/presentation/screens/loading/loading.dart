import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../domain.dart';

class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(authProvider, (prev, next) {
      next.whenData((state) {
        if (!context.mounted) {
          return;
        }
        if (state is AuthGuestState) {
          context.go('/login');
        } else if (state is AuthUserState) {
          context.go('/products');
        }
      });
    });

    return const Scaffold(body: Center(child: CircularProgressIndicator()));
  }
}
