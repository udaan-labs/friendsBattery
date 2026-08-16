import 'package:dio/dio.dart';
import 'package:friends_battery_api/friends_battery_api.dart';

class AccountsRepository {
  AccountsRepository(this._api);

  final FriendsBatteryApi _api;

  UsersApi get _users => _api.getUsersApi();

  Never _fromDio(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] != null) {
      throw Exception(data['message'].toString());
    }
    throw e;
  }

  Future<List<AccountUser>> list({required String role}) async {
    try {
      final response = await _users.apiUsersGet(role: role);
      final data = response.data?.data;
      if (data == null) {
        throw Exception(response.data?.message ?? 'Failed to load accounts');
      }
      return data.toList();
    } on DioException catch (e) {
      _fromDio(e);
    }
  }

  Future<void> setActive({required int id, required bool isActive}) async {
    try {
      await _users.apiUsersIdActivePatch(
        id: id,
        setAccountActiveRequest: SetAccountActiveRequest((b) => b.isActive = isActive),
      );
    } on DioException catch (e) {
      _fromDio(e);
    }
  }
}
