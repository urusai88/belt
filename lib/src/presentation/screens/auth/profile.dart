import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain.dart';
import '../../../presentation.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  late final Future<String?> _accessTokenFuture;

  @override
  void initState() {
    super.initState();
    _accessTokenFuture = Future(
      () async => ref.read(authProvider.notifier).accessTokenKey.get(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authProvider).requireValue;
    if (state is! AuthUserState) {
      return const Scaffold();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(child: Text(state.user.name)),
                CircleAvatar(
                  child: FutureBuilder(
                    future: _accessTokenFuture,
                    builder: (context, snapshot) {
                      if (snapshot.data case final data?) {
                        return Image(
                          image: NetworkImage(state.user.avatar),
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            ),
            Text('Почта: ${state.user.email}'),
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                if (context.mounted) {
                  context.go('/login');
                }
                await ref.read(authProvider.notifier).logout();
              },
              child: const Text('Выйти'),
            ),
          ],
        ),
      ),
    );
  }
}
