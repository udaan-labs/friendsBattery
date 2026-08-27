import 'package:test/test.dart';
import 'package:friends_battery_api/friends_battery_api.dart';


/// tests for OTPApi
void main() {
  final instance = FriendsBatteryApi().getOTPApi();

  group(OTPApi, () {
    // Send OTP for current user (reusable purposes)
    //
    //Future<OtpSendResponse> apiOtpSendPost(ApiOtpSendPostRequest apiOtpSendPostRequest) async
    test('test apiOtpSendPost', () async {
      // TODO
    });

    // Verify OTP for current user
    //
    //Future<OtpVerifyResponse> apiOtpVerifyPost(ApiOtpVerifyPostRequest apiOtpVerifyPostRequest) async
    test('test apiOtpVerifyPost', () async {
      // TODO
    });

  });
}
