import 'dart:io';

import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:edoc_tabcom/models/account_model.dart';
import 'package:edoc_tabcom/services/account_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../core/utils/local_storage.dart';

final accountProvider = StateNotifierProvider<AccountNotifier, UserInfor>((ref) {
  return AccountNotifier(ref);
});

class AccountNotifier extends StateNotifier<UserInfor> {
  final Ref ref;
  late final AccountService _accountService = ref.read(accountServiceProvider);
  AccountNotifier(this.ref) : super(UserInfor());
  Future<void> getUserInfor() async {
    try {
      final response = await _accountService.getUserInfor();
      state = response;
    } catch (e) {
      state = UserInfor();
    }
  }

  Future<bool> updateUserInfor(UserInforDTO userInfor) async {
    try {
      await _accountService.updateUserInfor(userInfor.toJson());
      getUserInfor();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> upLoadIamge(File file) async {
    // var req = http.MultipartRequest('POST', Uri.parse(Environment.apiUrl + 'api/Upload/ImageUpload'));
    // final String token = UserPreferences.instance.getToken();
    // // get file length
    // Map<String, String> headers = {"Accept": "application/json", "Authorization": "Bearer $token"};
    // req.headers.addAll(headers);
    // req.files.add(http.MultipartFile.fromBytes(
    //   'avatar', file.readAsBytesSync(),
    //   // ignore: unnecessary_new
    // ));
    // return req.send();
    try {
      final result = await _accountService.upLoadAvatar(file);
      return result;
    } catch (e) {
      return null;
    }
  }
}
