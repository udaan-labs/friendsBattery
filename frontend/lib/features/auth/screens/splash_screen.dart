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
  bool _started = false;

  @override
  void initState() {
    super.initState();
    // CRITICAL: do not touch Riverpod/GoRouter state during mount.
    // AppGate.check() used to set isLoading synchronously from initState,
    // which refreshed GoRouter mid-mount → remount splash → stack overflow.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_started && mounted) {
        _started = true;
        _boot();
      }
    });
  }

  Future<void> _boot() async {
    final authNotifier = ref.read(authProvider.notifier);
    final appGateNotifier = ref.read(appGateProvider.notifier);
    final started = DateTime.now();

    try {
      await Future.wait([
        authNotifier.initSession(),
        appGateNotifier.check(),
      ]).timeout(const Duration(seconds: 8));
    } catch (_) {
      ref.read(appGateProvider.notifier).markFailOpen();
    }

    // Brief brand moment only if boot was fast.
    const minSplash = Duration(milliseconds: 300);
    final elapsed = DateTime.now().difference(started);
    if (elapsed < minSplash) {
      await Future.delayed(minSplash - elapsed);
    }

    if (!mounted) return;

    if (!ref.read(appGateProvider).checked) {
      ref.read(appGateProvider.notifier).markFailOpen();
    }

    final gate = ref.read(appGateProvider);
    if (gate.isBlocked) {
      context.go('/app-gate');
      return;
    }

    final auth = ref.read(authProvider);
    if (auth.isAuthenticated && auth.role != UserRole.guest) {
      context.go(homePathForRole(auth.role));
    } else {
      context.go('/login');
    }
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
