import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/extension/common_function.dart';
import 'package:edoc_tabcom/core/utils/widgets/loading_mark.dart';
import 'package:edoc_tabcom/core/utils/widgets/submit_button_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/text_field_widget.dart';
import 'package:edoc_tabcom/providers/authentication_provider.dart';

import '../../core/utils/widgets/appbar_template_widget.dart';
import '../../providers/account_provider.dart';

@RoutePage()
class ChangePasswordScreen extends HookConsumerWidget {
  ChangePasswordScreen();
  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfor = ref.watch(accountProvider);

    final _currentPasswordFormKey = GlobalKey<FormState>();
    final _newPasswordFormKey = GlobalKey<FormState>();
    final _confirmPasswordFormKey = GlobalKey<FormState>();
    final _txtCurrentPasswordCtrl = TextEditingController();
    final _txtnewPasswordCtrl = TextEditingController();
    final _txtConfirmPasswordCtrl = TextEditingController();
    final currentText = useState('');
    final isLoading = useState(false);
    return Stack(
      children: [
        LayoutEdoc(
          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Stack(
                    children: [
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
                                  image: AssetImage(
                                      'assets/images/banner_profile.png'),
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
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'eDocument',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xFF243757)),
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
                    ],
                  ),
                  Container(
                    height: 56,
                    margin: EdgeInsets.only(top: 16),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Đổi mật khẩu',
                      style: TextStyle(
                        color: Color(0xFF243757),
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.30,
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  Container(
                    child: Row(
                      children: [
                        Text('Mật khẩu hiện tại ',
                            style: TextStyle(
                                color: Color(0xFF475569),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.07)),
                        Text('*',
                            style: TextStyle(
                                color: Color(0xFFF43F5E),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.07)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFieldWidget(
                    formKey: _currentPasswordFormKey,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter your password',
                    onChanged: (value) => {},
                    validateFunc: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: _txtCurrentPasswordCtrl,
                  ),
                  SizedBox(height: 16),
                  Container(
                    child: Row(
                      children: [
                        Text('Mật khẩu mới ',
                            style: TextStyle(
                                color: Color(0xFF475569),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.07)),
                        Text('*',
                            style: TextStyle(
                                color: Color(0xFFF43F5E),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.07)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFieldWidget(
                    formKey: _newPasswordFormKey,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter your password',
                    onChanged: (value) => {},
                    validateFunc: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    controller: _txtnewPasswordCtrl,
                  ),
                  SizedBox(height: 16),
                  Container(
                    child: Row(
                      children: [
                        Text('Nhập lại mật khẩu mới ',
                            style: TextStyle(
                                color: Color(0xFF475569),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.07)),
                        Text('*',
                            style: TextStyle(
                                color: Color(0xFFF43F5E),
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.07)),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFieldWidget(
                    formKey: _confirmPasswordFormKey,
                    keyboardType: TextInputType.text,
                    hintText: 'Enter your password',
                    onChanged: (value) => {},
                    validateFunc: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your password';
                      } else if (value != _txtnewPasswordCtrl.text) {
                        return 'Password does not match';
                      }
                      return null;
                    },
                    controller: _txtConfirmPasswordCtrl,
                  ),
                  SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 48,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(horizontal: 24),
                            backgroundColor: Color(0xFFEC1C23),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1, color: Color(0xFFEC1C23)),
                              borderRadius: BorderRadius.circular(45),
                            ),
                          ),
                          onPressed: () {
                            isLoading.value = true;
                            ref
                                .read(authProvider)
                                .changePassword(_txtCurrentPasswordCtrl.text,
                                    _txtnewPasswordCtrl.text)
                                .then((value) {
                              isLoading.value = false;
                              if (value) {
                                CommonFunction.showSnackBar(
                                    'Đổi mật khẩu thành công',
                                    context,
                                    Colors.green);
                              } else {
                                CommonFunction.showSnackBar(
                                    'Đổi mật khẩu thất bại',
                                    context,
                                    Colors.red);
                              }
                            });
                          },
                          child: Row(
                            children: [
                              Icon(
                                Icons.save_alt_outlined,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Cập nhật',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
        isLoading.value ? Loading() : const SizedBox.shrink(),
      ],
    );
  }
}
