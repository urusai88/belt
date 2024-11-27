import 'package:flutter/material.dart';

Future<void> showError({
  required BuildContext context,
  required dynamic error,
}) async {
  if (context.mounted) {
    await showDialog<void>(
      context: context,
      builder: (context) =>
          AlertDialog(title: const Text('Ошибка'), content: Text('$error')),
    );
  }
}

Future<void> showMessage({
  required BuildContext context,
  required dynamic message,
}) async {
  if (context.mounted) {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(content: Text('$message')),
    );
  }
}
