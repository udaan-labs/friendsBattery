import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

void showLogoutConfirmationDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        backgroundColor: const Color(0xFFFFFFFF),
        title: const Text(
          'Logout',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF191C1E)),
        ),
        content: const Text(
          'Are you sure you want to log out?',
          style: TextStyle(color: Color(0xFF3E4A3D)),
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(authProvider.notifier).logout();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9999)),
            ),
            child: const Text('Logout'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Color(0xFF006B2C))),
          ),
        ],
      );
    },
  );
}
