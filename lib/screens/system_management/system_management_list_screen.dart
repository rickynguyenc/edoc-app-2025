import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:edoc_tabcom/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/utils/widgets/appbar_template_widget.dart';

@RoutePage()
class SystemManagementListScreen extends HookConsumerWidget {
  const SystemManagementListScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutEdoc(
      bodyWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 56,
                margin: EdgeInsets.only(top: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  'Quản trị hệ thống',
                  style: TextStyle(
                    color: Color(0xFF243757),
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.30,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.router.push(DocumentManagementRoute());
                  },
                  child: Container(
                    height: 68,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFEBEDF0),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(Icons.file_present_outlined, size: 24),
                        SizedBox(width: 28),
                        Text(
                          'Quản lý tài liệu',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    context.router.push(GroupManagementRoute());
                  },
                  child: Container(
                    height: 68,
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Color(0xFFEBEDF0),
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 8),
                        Icon(Icons.group_outlined, size: 24),
                        SizedBox(width: 28),
                        Text(
                          'Quản lý nhóm',
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          width: 12,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
