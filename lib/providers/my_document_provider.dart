import 'package:edoc_tabcom/core/utils/extension/object.dart';
import 'package:edoc_tabcom/models/home_model.dart';
import 'package:edoc_tabcom/services/my_document_service.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final myDocumentProvider = StateNotifierProvider<MyDocumentNotifier, List<DocumentItem>>((ref) {
  return MyDocumentNotifier(ref);
});

class MyDocumentNotifier extends StateNotifier<List<DocumentItem>> {
  final Ref ref;
  MyDocumentNotifier(this.ref) : super([]);
  late final _myDocumentService = ref.read(myDocumentServiceProvider);
  Future<bool> getDesktopList(PageLink param) async {
    try {
      final result = await _myDocumentService.getDesktopList(param.toJson());
      state = result.items ?? [];
      if (state.length < int.parse(result.totalCount.toString())) {
        return true; // has more
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getMoreDesktopList(PageLink param) async {
    try {
      final result = await _myDocumentService.getDesktopList(param.toJson());
      // state = [...state, ...result.items??[]];
      state = state + (result.items ?? []);
      if (state.length < int.parse(result.totalCount.toString())) {
        return true; // has more
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
