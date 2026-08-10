import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_controller.dart';
import '../../shared/otp/otp_entry_field.dart';
import '../../../theme/app_theme.dart';
import '../../../shared/widgets/responsive_helper.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _userIdController = TextEditingController();
  final _passwordController = TextEditingController();
  final _otpController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  Future<void> _onLogin() async {
    final userId = _userIdController.text.trim();
    final password = _passwordController.text;
    if (userId.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter User ID and password')),
      );
      return;
    }
    await ref.read(authControllerProvider.notifier).login(userId, password);
  }

  Future<void> _onVerifyOtp() async {
    final otp = _otpController.text.trim();
    if (otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter the OTP')),
      );
      return;
    }
    await ref.read(authControllerProvider.notifier).verifyLoginOtp(otp);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final challenge = ref.watch(loginOtpChallengeProvider);
    final awaitingOtp = challenge != null;

    ref.listen(loginOtpChallengeProvider, (prev, next) {
      if (next != null && prev == null) {
        _otpController.clear();
        final masked = next.phoneMasked ?? 'your phone';
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('OTP SMS sent to $masked. Enter the code from the message.'),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });

    ref.listen<AsyncValue<void>>(authControllerProvider, (prev, next) {
      next.whenOrNull(
        error: (err, _) {
          final msg = err.toString().replaceFirst('Exception: ', '');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg.isEmpty ? 'Login failed' : msg),
              backgroundColor: AppTheme.error,
            ),
          );
        },
      );
    });

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(ResponsiveHelper.responsivePadding(context)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.battery_charging_full,
                size: ResponsiveHelper.isSmallPhone(context) ? 48 : 64,
                color: AppTheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                awaitingOtp ? 'Enter OTP' : 'Welcome Back',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: ResponsiveHelper.isSmallPhone(context) ? 24 : 32,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF191C1E),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                awaitingOtp
                    ? 'Code sent to ${challenge.phoneMasked ?? 'your phone'}'
                    : 'Sign in to manage your battery systems',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: ResponsiveHelper.isSmallPhone(context) ? 14 : 16,
                  color: const Color(0xFF545F73),
                ),
              ),
              SizedBox(height: ResponsiveHelper.isSmallPhone(context) ? 24 : 48),
              Container(
                decoration: BoxDecoration(
                  color: AppTheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0A000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(ResponsiveHelper.cardPadding(context)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (!awaitingOtp) ...[
                      TextField(
                        controller: _userIdController,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(labelText: 'User ID'),
                        enabled: !authState.isLoading,
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) {
                          if (!authState.isLoading) _onLogin();
                        },
                        decoration: InputDecoration(
                          labelText: 'Password',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        obscureText: _obscurePassword,
                        enabled: !authState.isLoading,
                      ),
                    ] else ...[
                      OtpEntryField(
                        controller: _otpController,
                        enabled: !authState.isLoading,
                        onSubmitted: (_) {
                          if (!authState.isLoading) _onVerifyOtp();
                        },
                        helperText: challenge.expiresIn != null
                            ? 'Expires in ${challenge.expiresIn}s'
                            : null,
                      ),
                    ],
                    SizedBox(
                      height: ResponsiveHelper.isSmallPhone(context) ? 20 : 32,
                    ),
                    if (authState.isLoading)
                      const Center(child: CircularProgressIndicator())
                    else if (!awaitingOtp)
                      ElevatedButton(
                        onPressed: _onLogin,
                        child: const Text(
                          'Continue',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    else ...[
                      ElevatedButton(
                        onPressed: _onVerifyOtp,
                        child: const Text(
                          'Verify & Login',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          _otpController.clear();
                          ref.read(authControllerProvider.notifier).cancelOtp();
                        },
                        child: const Text('Back'),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
