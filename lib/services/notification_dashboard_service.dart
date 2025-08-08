import 'package:edoc_tabcom/core/app_dio.dart';
import 'package:edoc_tabcom/models/notification_dashboard_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:retrofit/http.dart';
part 'notification_dashboard_service.g.dart';

final notificationDashboardServiceProvider = Provider<NotificationDashboardService>((ref) {
  return NotificationDashboardService(ref);
});

@RestApi()
abstract class NotificationDashboardService {
  factory NotificationDashboardService(Ref ref) => _NotificationDashboardService(ref.read(dioProvider));
  @GET('/api/app/notification/notification')
  Future<NotificationListResonpse> getNotificationDashboard(@Queries() Map<String, dynamic> data); //PageLink
}
