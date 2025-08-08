import 'dart:io';

import 'package:edoc_tabcom/core/app_dio.dart';
import 'package:edoc_tabcom/models/account_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';
part 'account_service.g.dart';

final accountServiceProvider = Provider<AccountService>((ref) {
  return AccountService(ref);
});

@RestApi()
abstract class AccountService {
  factory AccountService(Ref ref) => _AccountService(ref.read(dioProvider));
  @GET('/api/app/user-profile')
  Future<UserInfor> getUserInfor();
  @PUT('/api/app/user-profile/profile')
  Future<dynamic> updateUserInfor(@Body() Map<String, dynamic> body);

  @POST('/api/Upload/ImageUpload')
  @MultiPart()
  Future<dynamic> upLoadAvatar(
    @Part(name: 'avatar') File attach,
  );
}
