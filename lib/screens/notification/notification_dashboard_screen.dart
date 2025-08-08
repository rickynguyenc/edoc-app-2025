import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/utils/extension/common_function.dart';
import 'package:edoc_tabcom/core/utils/extension/object.dart';
import 'package:edoc_tabcom/core/utils/local_storage.dart';
import 'package:edoc_tabcom/core/utils/widgets/appbar_template_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/loading_mark.dart';
import 'package:edoc_tabcom/core/utils/widgets/shimmer_loading/body_shimmer.dart';
import 'package:edoc_tabcom/providers/notification_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../models/notification_dashboard_model.dart';

@RoutePage()
class NotificationProductScreen extends HookConsumerWidget {
  const NotificationProductScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);
    final lstNotifications = ref.watch(notificationDashboardProvider);
    useEffect(() {
      final userIdLocal = UserPreferences.instance.getUserId();
      final pageLink = {'userId': userIdLocal, 'skipCount': 0, 'maxResultCount': 100};
      ref.read(notificationDashboardProvider.notifier).getNotificationDashboard(pageLink).then((value) => isLoading.value = false);
      return null;
    }, []);
    return LayoutEdoc(
      bodyWidget: Padding(
        padding: EdgeInsets.all(16),
        child: isLoading.value
            ? BodyShimmerWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 16),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          bottom: 8,
                          left: 16,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Thông báo',
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 18,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              width: 22,
                              height: 22,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 22,
                                      height: 22,
                                      decoration: ShapeDecoration(
                                        color: Colors.red,
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 7.70,
                                    top: 2.20,
                                    child: SizedBox(
                                      width: 6.60,
                                      height: 17.60,
                                      child: Text(
                                        '${lstNotifications.length}\n',
                                        textAlign: TextAlign.right,
                                        style: TextStyle(
                                          color: Color(0xFFF4F4F4),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Spacer(),
                      // Text(
                      //   'Clear All',
                      //   textAlign: TextAlign.right,
                      //   style: TextStyle(
                      //     color: Color(0xFF055FA7),
                      //     fontSize: 16,
                      //     fontWeight: FontWeight.w400,
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      itemCount: lstNotifications.length,
                      itemBuilder: (context, index) {
                        final item = lstNotifications[index];
                        return NotificationElementWidget(lstNotifications[index]);
                      },
                    ),
                  )
                ],
              ),
      ),
    );
  }
}

// Notification Element
class NotificationElementWidget extends HookConsumerWidget {
  final NotificationItem item;
  const NotificationElementWidget(this.item, {super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(12),
      decoration: ShapeDecoration(
        color: Color(0xFFF5F5F5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: ShapeDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/images_default.png'),
                fit: BoxFit.fill,
              ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.content ?? '',
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    CommonFunction.formatRelativeTime(item.creationTime ?? ''),
                    style: TextStyle(
                      color: Color(0xFFB8B8B8),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.06,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 16,
          )
        ],
      ),
    );
  }
}
