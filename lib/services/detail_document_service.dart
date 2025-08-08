import 'dart:io';

import 'package:edoc_tabcom/core/app_dio.dart';
import 'package:edoc_tabcom/models/detail_document_model.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';
part 'detail_document_service.g.dart';

final detailDocumentServiceProvider = Provider((ref) => DetailDocumentService(ref));

@RestApi()
abstract class DetailDocumentService {
  factory DetailDocumentService(Ref ref) => _DetailDocumentService(ref.read(dioProvider));
  @GET('/api/app/app-file/{id}/document-detail')
  Future<DocumentDetail> getDetailDocument(@Path('id') String id);
  @GET('/api/app/comment')
  Future<List<CommentModel>> getComment(@Queries() Map<String, dynamic> data); // fileId=3a12a84e-9ea7-465a-6479-9de2a00384ef
  @GET('/api/Download/DownLoadFilePdf')
  Future<dynamic> downloadDocument(@Queries() Map<String, dynamic> data); //uuid=3a12a84e-9ea7-465a-6479-9de2a00384ef
  @POST('/api/Download/DownLoadFile')
  Future<dynamic> downloadFile(@Body() Map<String, dynamic> data); //uuid: dd
  @POST('/api/app/comment')
  Future<dynamic> postComment(@Body() Map<String, dynamic> data); // comment dto
  @POST('/api/app/app-file/like/{id}')
  Future<void> addToWishList(@Path('id') String id, @Body() Map<String, dynamic> data);
}
