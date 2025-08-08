import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:edoc_tabcom/providers/account_provider.dart';
import 'package:edoc_tabcom/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/utils/widgets/appbar_template_widget.dart';

@RoutePage()
class MyAccountTabScreen extends HookConsumerWidget {
  const MyAccountTabScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfor = ref.watch(accountProvider);
    return LayoutEdoc(
      bodyWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 16,
              ),
              Stack(children: [
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Color(0xFFE6E6E6),
                      ),
                      color: Colors.white,
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 135,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              topRight: Radius.circular(8),
                            ),
                            image: DecorationImage(
                              image: AssetImage('assets/images/banner_profile.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 95,
                          width: double.infinity,
                          padding: EdgeInsets.only(left: 136),
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 12,
                              ),
                              Text(
                                userInfor.fullName ?? '',
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'eDocument',
                                style: TextStyle(fontSize: 16, color: Color(0xFF243757)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                ),
                Positioned(
                  left: 20,
                  bottom: 45,
                  child: Container(
                    width: 100,
                    height: 100,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        '${Environment.apiUrl}${userInfor.avatar}',
                      ), // Your avatar image
                    ),
                  ),
                ),
              ]),
              Container(
                height: 56,
                margin: EdgeInsets.only(top: 16),
                alignment: Alignment.centerLeft,
                child: Text(
                  'SEETINGS',
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
                    context.router.push(PersonalViewRoute());
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
                        Icon(Icons.account_circle_outlined, size: 24),
                        SizedBox(width: 28),
                        Text(
                          'Cập nhật thông tin',
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
                    context.router.push(ChangePasswordRoute());
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
                        Icon(Icons.lock_outline, size: 24),
                        SizedBox(width: 28),
                        Text(
                          'Đổi mật khẩu',
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
                    ref.read(authProvider).logout();
                    context.router.replaceAll([LoginRoute()]);
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
                        Icon(Icons.logout_outlined, size: 24),
                        SizedBox(width: 28),
                        Text(
                          'Đăng xuất',
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
