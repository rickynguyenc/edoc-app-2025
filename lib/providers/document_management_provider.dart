import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/document_management_model.dart';
import '../services/system_management_service.dart';

final documentManagementProvider = StateNotifierProvider<DocumentManagementNotifier, List<DocumentManage>>((ref) {
  return DocumentManagementNotifier(ref);
});

class DocumentManagementNotifier extends StateNotifier<List<DocumentManage>> {
  final Ref ref;
  DocumentManagementNotifier(this.ref) : super([]);
  late final systemManageService = ref.read(systemManagementServiceProvider);
  void addDocumentManage(DocumentManage documentManage) {
    state = [...state, documentManage];
  }

  void removeDocumentManage(DocumentManage documentManage) {
    state = state.where((e) => e.id != documentManage.id).toList();
  }

  Future<int> fetchDocumentManage(Map<String, dynamic> param) async {
    try {
      final response = await systemManageService.getLstDocumentManage(param);
      state = response.items ?? [];
      return response.totalCount ?? 0;
    } catch (e) {
      print('Error: $e');
      return 0;
    }
  }

  selectDocumentElement(String id) {
    state = state.map((e) => e.id == id ? e.copyWith(selected: !e.selected!) : e).toList();
  }

  selectAllDocumentElement(bool isSelected) {
    state = state.map((e) => e.copyWith(selected: isSelected)).toList();
  }
}
