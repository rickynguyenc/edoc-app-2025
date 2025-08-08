import 'package:edoc_tabcom/core/utils/extension/object.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/home_model.dart';
import '../services/home_service.dart';

final homeProvider = StateNotifierProvider<HomeProvider, List<DocumentItem>>((ref) {
  return HomeProvider(ref);
});

class HomeProvider extends StateNotifier<List<DocumentItem>> {
  final Ref ref;
  HomeProvider(this.ref) : super([]);
  late final _homeService = ref.read(homeServiceProvider);
  Future<bool> getPublicList(PageLink param) async {
    try {
      final result = await _homeService.getPublicList(param.toJson());
      state = result.items ?? [];
      if (state.length < int.parse(result.totalCount.toString())) {
        return true; // has more
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getMorePublicList(PageLink param) async {
    try {
      final result = await _homeService.getPublicList(param.toJson());
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

final categoryTreeProvider = StateNotifierProvider<CategoryTreeNotifier, List<CategoryTreeResonpse>>((ref) {
  return CategoryTreeNotifier(ref);
});

class CategoryTreeNotifier extends StateNotifier<List<CategoryTreeResonpse>> {
  final Ref ref;
  CategoryTreeNotifier(this.ref) : super([]);
  late final _homeService = ref.read(homeServiceProvider);
  Future<List<CategoryTreeResonpse>> getCategoryTree() async {
    try {
      final result = await _homeService.getCategoryTree();
      state = result;
      return state;
    } catch (e) {
      return [];
    }
  }
}

final organizationTreeProvider = StateNotifierProvider<DropDownTreeNotifier, List<DropdownTree>>((ref) {
  return DropDownTreeNotifier(ref);
});
final userTreeProvider = StateNotifierProvider<DropDownTreeNotifier, List<DropdownTree>>((ref) {
  return DropDownTreeNotifier(ref);
});
final userGroupTreeProvider = StateNotifierProvider<DropDownTreeNotifier, List<DropdownTree>>((ref) {
  return DropDownTreeNotifier(ref);
});

class DropDownTreeNotifier extends StateNotifier<List<DropdownTree>> {
  final Ref ref;
  DropDownTreeNotifier(this.ref) : super([]);
  late final _homeService = ref.read(homeServiceProvider);
  Future<List<DropdownTree>> getOrganiztionTree() async {
    try {
      final result = await _homeService.getOrganizationTree({});
      state = result;
      return state;
    } catch (e) {
      return [];
    }
  }

  Future<List<DropdownTree>> getUserTree() async {
    try {
      final result = await _homeService.getUserTree({});
      state = result;
      return state;
    } catch (e) {
      return [];
    }
  }

  Future<List<DropdownTree>> getUserGroupTree() async {
    try {
      final result = await _homeService.getUserGroupTree({});
      state = result;
      return state;
    } catch (e) {
      return [];
    }
  }
}
