import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_theme.dart';
import '../../../shared/providers/auth_provider.dart';
import '../../../shared/widgets/responsive_helper.dart';

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
    
    // Check session
    await authNotifier.initSession();
    
    // Optional delay to show splash logo nicely
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      final authState = ref.read(authProvider);
      if (!authState.isAuthenticated) {
        context.go('/login');
      }
      // If authenticated, GoRouter will handle the redirect to dashboard automatically
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
