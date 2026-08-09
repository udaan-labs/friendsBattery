import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/responsive_helper.dart';
import '../../shared/app_gate/providers/app_gate_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _initAuth();
  }

  Future<void> _initAuth() async {
    final authNotifier = ref.read(authProvider.notifier);
    final appGateNotifier = ref.read(appGateProvider.notifier);
    final started = DateTime.now();

    // Session restore + app gate (version / maintenance) in parallel.
    await Future.wait([
      authNotifier.initSession(),
      appGateNotifier.check(),
    ]);

    // Keep splash visible only briefly for branding (was a hard-coded 2s delay).
    const minSplash = Duration(milliseconds: 400);
    final elapsed = DateTime.now().difference(started);
    if (elapsed < minSplash) {
      await Future.delayed(minSplash - elapsed);
    }

    if (!mounted) return;

    final gate = ref.read(appGateProvider);
    if (gate.isBlocked) {
      context.go('/app-gate');
      return;
    }

    final authState = ref.read(authProvider);
    if (!authState.isAuthenticated) {
      context.go('/login');
    }
    // If authenticated, GoRouter will handle the redirect to dashboard automatically
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = ResponsiveHelper.isSmallPhone(context);
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.battery_charging_full,
              size: ResponsiveHelper.iconSize(context, 80),
              color: Colors.white,
            ),
            SizedBox(height: isSmall ? 16 : 24),
            Text(
              'Friends Battery',
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: ResponsiveHelper.fontSize(context, 32),
                fontWeight: FontWeight.w700,
                color: Colors.white,
                letterSpacing: -0.02,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
