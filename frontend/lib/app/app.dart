import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'router/app_router.dart';
import '../theme/app_theme.dart';
import '../core/storage/session_guard.dart';
import '../shared/providers/auth_provider.dart';

class BatteryApp extends ConsumerWidget {
  const BatteryApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Wire once: Dio 401 → local logout (router redirect handles /login)
    SessionGuard.handleUnauthorized ??= () async {
      await ref.read(authProvider.notifier).logout();
    };

    final goRouter = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'Battery Inventory',
      theme: AppTheme.themeData,
      routerConfig: goRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
