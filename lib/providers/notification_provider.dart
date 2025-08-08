import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../models/notification_dashboard_model.dart';
import '../services/notification_dashboard_service.dart';

final notificationDashboardProvider = StateNotifierProvider<NotificationNotifier, List<NotificationItem>>((ref) {
  return NotificationNotifier(ref);
});

class NotificationNotifier extends StateNotifier<List<NotificationItem>> {
  final Ref ref;
  NotificationNotifier(this.ref) : super([]);
  late final _notificationService = ref.read(notificationDashboardServiceProvider);
  Future<void> getNotificationDashboard(Map<String, dynamic> params) async {
    try {
      final result = await _notificationService.getNotificationDashboard(params);
      state = result.items ?? [];
    } catch (e) {
      state = [];
    }
  }
}
