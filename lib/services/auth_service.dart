import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';

import '../core/app_dio.dart';
import '../models/auth_model.dart';
part 'auth_service.g.dart';

final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService(ref);
});

@RestApi()
abstract class AuthService {
  factory AuthService(Ref ref) => _AuthService(ref.read(dioProvider));
  @FormUrlEncoded()
  @POST('/connect/token')
  Future<LoginResponse> login(@Body() Map<String, dynamic> param);
  @POST('/api/app/user-registration/registration-public')
  Future<dynamic> register(@Body() Map<String, dynamic> data);
  // @GET('/api/res_users/{id}')
  // Future<UserInforResponse> getUserInfor(@Path('id') int id);
  @POST('/api/app/global-lookup-table/send-password-reset-code')
  Future<dynamic> forgotPassword(@Body() Map<String, dynamic> data);
  @POST('/api/app/global-lookup-table/check-email-exits')
  Future<dynamic> checkMailExist(@Queries() Map<String, dynamic> data);
  @POST('/api/account/reset-password')
  Future<dynamic> resetPassword(@Body() Map<String, dynamic> data);
  @POST('/api/app/user-profile/change-password')
  Future<dynamic> changePassword(@Body() Map<String, dynamic> data);
  @POST('/api/app/user-registration/authenticate-google-user')
  Future<GoogleRegisterResponse> registerUserWithGoogle(@Body() Map<String, dynamic> data);
  // refresh token
  @POST('/api/account/verify-password-reset-token')
  Future<LoginResponse> refreshToken(@Body() Map<String, dynamic> param);
  // Delete account
  @DELETE('/api/app/user-profile/account')
  Future<dynamic> deleteAccount();
}
