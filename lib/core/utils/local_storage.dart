// ignore_for_file: import_of_legacy_library_into_null_safe, unnecessary_null_comparison

import 'dart:convert';
import 'package:edoc_tabcom/models/account_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefConstant {
  SharedPrefConstant._();
  static const String token = 'token';
  static const String notifyToken = 'notifyToken';
  static const String refreshToken = 'refreshToken';
  static const String userInfo = 'userInfo';
  static const String expirydate = 'expirydate';
  static const String datelogin = 'datelogin';
  static const String rememberLogin = 'rememberLogin';
  static const String badge = 'badge';
  static const String lanLogin = 'lanLogin';
  static const String userId = 'userId';
}

class UserPreferences {
  static UserPreferences? _instance;

  static UserPreferences get instance => _instance!;

  late SharedPreferences _sharedPreferences;

  UserPreferences._();

  static initialize() async {
    _instance ??= UserPreferences._();
    _instance!._sharedPreferences = await SharedPreferences.getInstance();
  }

  Set<String> getKeys() {
    return _sharedPreferences.getKeys();
  }

  bool iSLogin() => getToken() != null;

  Future<bool> saveToken(String token) {
    return _sharedPreferences.setString(SharedPrefConstant.token, token);
  }

  String getToken() {
    return _sharedPreferences.getString(SharedPrefConstant.token) ?? '';
  }

  Future<bool> saveLanLogin(int token) {
    return _sharedPreferences.setInt(SharedPrefConstant.lanLogin, token);
  }

  int getLanLogin() {
    return _sharedPreferences.getInt(SharedPrefConstant.lanLogin) ?? 0;
  }

  Future<bool> saveRefreshToken(String token) {
    return _sharedPreferences.setString(SharedPrefConstant.refreshToken, token);
  }

  String? getRefreshToken() {
    return _sharedPreferences.getString(SharedPrefConstant.refreshToken);
  }

  Future<bool> saveExpirydate(int expiry) {
    return _sharedPreferences.setInt(SharedPrefConstant.expirydate, expiry);
  }

  int? getExpirydate() {
    return _sharedPreferences.getInt(SharedPrefConstant.expirydate);
  }

  Future<bool> saveDateLogin(int dateLogin) {
    return _sharedPreferences.setInt(SharedPrefConstant.datelogin, dateLogin);
  }

  int? getDateLogin() {
    return _sharedPreferences.getInt(SharedPrefConstant.datelogin);
  }

  Future<bool> saveRememberLogin(bool remember) {
    return _sharedPreferences.setBool(SharedPrefConstant.rememberLogin, remember);
  }

  bool? getRememberLogin() {
    return _sharedPreferences.getBool(SharedPrefConstant.rememberLogin);
  }

  Future<bool> saveUserId(String userId) {
    return _sharedPreferences.setString(SharedPrefConstant.userId, userId);
  }

  String? getUserId() {
    return _sharedPreferences.getString(SharedPrefConstant.userId);
  }

  saveUserInfo(UserInfor? userInfo) {
    _sharedPreferences.setString(SharedPrefConstant.userInfo, jsonEncode(userInfo?.toJson()));
  }

  UserInfor? getUserInfo() {
    final string = _sharedPreferences.getString(SharedPrefConstant.userInfo);
    return string == null ? null : UserInfor.fromJson(jsonDecode(string));
  }

  // Lưu token notify
  Future<bool> saveNotifyToken(String token) {
    return _sharedPreferences.setString(SharedPrefConstant.notifyToken, token);
  }

  String? getNotifyToken() {
    return _sharedPreferences.getString(SharedPrefConstant.notifyToken);
  }

  Future<bool> saveBadge(int badge) {
    return _sharedPreferences.setInt(SharedPrefConstant.badge, badge);
  }

  increaseBadge() {
    int badge = getBadge();
    badge++;
    return _sharedPreferences.setInt(SharedPrefConstant.badge, badge);
  }

  int getBadge() {
    return _sharedPreferences.getInt(SharedPrefConstant.badge) ?? 0;
  }

  clearAuth() async {
    await _sharedPreferences.remove(SharedPrefConstant.token);
    await _sharedPreferences.remove(SharedPrefConstant.refreshToken);
    await _sharedPreferences.remove(SharedPrefConstant.userInfo);
    await _sharedPreferences.remove(SharedPrefConstant.expirydate);
    await _sharedPreferences.remove(SharedPrefConstant.datelogin);
    await _sharedPreferences.remove(SharedPrefConstant.rememberLogin);
  }
}
