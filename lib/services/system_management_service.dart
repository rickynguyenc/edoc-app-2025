import 'dart:io';

import 'package:edoc_tabcom/core/app_dio.dart';
import 'package:edoc_tabcom/models/document_management_model.dart';
import 'package:edoc_tabcom/models/group_management_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';
part 'system_management_service.g.dart';

final systemManagementServiceProvider = Provider<SystemManagementService>((ref) {
  return SystemManagementService(ref);
});

@RestApi()
abstract class SystemManagementService {
  factory SystemManagementService(Ref ref) => _SystemManagementService(ref.read(dioProvider));
  @GET('/api/app/system-user')
  Future<dynamic> getSystemUser(@Queries() Map<String, dynamic> queries); // PageLink

  @GET('/api/app/app-file/list')
  Future<LstDocumentManageResponse> getLstDocumentManage(@Queries() Map<String, dynamic> queries); // PageLink
  // GET List Group
  @GET('/api/app/user-group-appservice')
  Future<LstGroupManageResponse> getLstGroupManage(@Queries() Map<String, dynamic> queries); // PageLink

  @POST('/api/Upload/ImportUpload')
  @MultiPart()
  Future<dynamic> createDocumentManage(
    @Queries() Map<String, dynamic> queries,
    @Part(name: 'file') File attach,
  ); //?fileMode=0&organizationId=0ce465cb-8cbd-43ba-8a2a-e755d846a1c1
}
