import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

// tests for LoginOtpChallengeData
void main() {
  final instance = LoginOtpChallengeDataBuilder();
  // TODO add properties to the builder and call build()

  group(LoginOtpChallengeData, () {
    // bool requiresOtp
    test('to test the property `requiresOtp`', () async {
      // TODO
    });

    // String challengeId
    test('to test the property `challengeId`', () async {
      // TODO
    });

    // Seconds until OTP expires
    // int expiresIn
    test('to test the property `expiresIn`', () async {
      // TODO
    });

    // String phoneMasked
    test('to test the property `phoneMasked`', () async {
      // TODO
    });

    // Dev only — present when OTP_ECHO / non-production
    // String otp
    test('to test the property `otp`', () async {
      // TODO
    });

  });
}
