import 'package:flutter/material.dart';

Future<bool> confirmMarkActive(
  BuildContext context, {
  required String name,
  required bool currentlyActive,
}) async {
  final ok = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(currentlyActive ? 'Mark inactive?' : 'Mark active?'),
      content: Text(
        currentlyActive
            ? 'Mark $name as inactive? They will not be able to use the app.'
            : 'Mark $name as active? They will be able to log in again.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: Text(currentlyActive ? 'Mark inactive' : 'Mark active'),
        ),
      ],
    ),
  );
  return ok == true;
}
