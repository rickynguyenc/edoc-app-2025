import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/group_management_model.dart';
import '../services/system_management_service.dart';

final groupManagementProvider = StateNotifierProvider<GroupManagementNotifier, List<GroupItem>>((ref) {
  return GroupManagementNotifier(ref);
});

class GroupManagementNotifier extends StateNotifier<List<GroupItem>> {
  final Ref ref;
  GroupManagementNotifier(this.ref) : super([]);
  late final systemManageService = ref.read(systemManagementServiceProvider);
  void addGroupManage(GroupItem groupManage) {
    state = [...state, groupManage];
  }

  void removeGroupManage(GroupItem groupManage) {
    state = state.where((e) => e.id != groupManage.id).toList();
  }

  Future<int> fetchGroupManage(Map<String, dynamic> param) async {
    try {
      final response = await systemManageService.getLstGroupManage(param);
      state = response.items ?? [];
      return response.totalCount ?? 0;
    } catch (e) {
      print('Error: $e');
      return 0;
    }
  }

  selectGroupElement(String id) {
    state = state.map((e) => e.id == id ? e.copyWith(selected: !e.selected!) : e).toList();
  }

  selectAllGroupElement(bool isSelected) {
    state = state.map((e) => e.copyWith(selected: isSelected)).toList();
  }
}
