import 'package:edoc_tabcom/core/app_dio.dart';
import 'package:edoc_tabcom/models/home_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/retrofit.dart';
part 'my_document_service.g.dart';

final myDocumentServiceProvider = Provider<MyDocumentService>((ref) {
  return MyDocumentService(ref);
});

@RestApi()
abstract class MyDocumentService {
  factory MyDocumentService(Ref ref) => _MyDocumentService(ref.read(dioProvider));
  @GET('/api/app/app-file/desktop-list')
  Future<PublicListResonpse> getDesktopList(@Queries() Map<String, dynamic> data);
}
