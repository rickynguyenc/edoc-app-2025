import 'dart:io';

import 'package:edoc_tabcom/core/app_dio.dart';
import 'package:edoc_tabcom/models/detail_document_model.dart';
import 'package:edoc_tabcom/services/detail_document_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cross_file/cross_file.dart';

final detailDocumentProvider = StateNotifierProvider<DetailDocumentNotifier, DocumentDetail>((ref) {
  return DetailDocumentNotifier(ref);
});
final commentProvider = StateNotifierProvider<CommentNotifier, List<CommentModel>>((ref) {
  return CommentNotifier(ref);
});

class DetailDocumentNotifier extends StateNotifier<DocumentDetail> {
  final Ref ref;
  DetailDocumentNotifier(this.ref) : super(DocumentDetail());
  late final _detailDocService = ref.read(detailDocumentServiceProvider);
  Future<DocumentDetail> getDetailDocument(String id) async {
    try {
      final result = await _detailDocService.getDetailDocument(id);
      state = result;
      return state;
    } catch (e) {
      return DocumentDetail();
    }
  }

  Future<void> addToWishList(String id) async {
    try {
      await _detailDocService.addToWishList(id, {});
      state = state.copyWith(isLike: !state.isLike!);
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> downloadDocument(String uuid) async {
    try {
      // final response = await _detailDocService.downloadDocument({'uuid': uuid});
      // return response;

      final _dio = ref.read(dioProvider);
      const _extra = <String, dynamic>{};
      final queryParameters = <String, dynamic>{};
      queryParameters.addAll({'uuid': uuid});
      final _headers = <String, dynamic>{};
      final Map<String, dynamic>? _data = null;
      final _result = await _dio.fetch(Options(method: 'GET', headers: _headers, extra: _extra, responseType: ResponseType.bytes)
          .compose(
            _dio.options,
            '/api/Download/DownLoadFilePdf',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _dio.options.baseUrl));
      return _result.data;
    } catch (e) {
      print(e);
      return null;
    }
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic && !(requestOptions.responseType == ResponseType.bytes || requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  // Future<File> _storeFile(String url, List<int> bytes) async {
  //   final filename = basename(url);
  //   final dir = await getApplicationDocumentsDirectory();

  //   final file = File('${dir.path}/$filename');
  //   await file.writeAsBytes(bytes, flush: true);
  //   return file;
  // }
}

class CommentNotifier extends StateNotifier<List<CommentModel>> {
  final Ref ref;
  CommentNotifier(this.ref) : super([]);
  late final _detailDocService = ref.read(detailDocumentServiceProvider);
  Future<void> getComment(String fileId) async {
    try {
      final result = await _detailDocService.getComment({'fileId': fileId});
      state = result;
    } catch (e) {
      state = [];
    }
  }

  Future<void> postComment(CommentDto data) async {
    try {
      await _detailDocService.postComment(data.toJson());
    } catch (e) {
      print(e);
    }
  }
}
