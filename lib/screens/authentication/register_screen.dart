import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/extension/common_function.dart';
import 'package:edoc_tabcom/core/utils/widgets/loading_mark.dart';

import '../../core/utils/widgets/submit_button_widget.dart';
import '../../core/utils/widgets/text_field_widget.dart';
import '../../providers/authentication_provider.dart';

@RoutePage()
class RegisterScreen extends HookConsumerWidget {
  final _userNameFormKey = GlobalKey<FormState>();
  final _fullNameFormKey = GlobalKey<FormState>();
  final _emailFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _confirmPasswordFormKey = GlobalKey<FormState>();
  final _txtUsernameCtrl = TextEditingController();
  final _txtFullNameCtrl = TextEditingController();
  final _txtEmailCtrl = TextEditingController();
  final _txtPasswordCtrl = TextEditingController();
  final _txtConfirmPasswordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _policyCheck = useState(false);
    final isLoading = useState(false);
    final _passwordVisible = useState(false);
    final _passwordConfirmVisible = useState(false);

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 16),
                        child: SvgPicture.asset(
                          'assets/icons/logo.svg',
                          height: 48,
                        )),
                  ],
                ),
                SizedBox(height: 24),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Text(
                    'Đăng ký',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF243757),
                      fontSize: 20,
                      height: 1.7,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 29),
                TextFieldWidget(
                  formKey: _fullNameFormKey,
                  keyboardType: TextInputType.text,
                  hintText: 'Tên của bạn',
                  labelText: 'Tên của bạn',
                  onChanged: (value) => {},
                  validateFunc: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Đây là trường bắt buộc';
                    }
                    return null;
                  },
                  controller: _txtFullNameCtrl,
                ),
                SizedBox(height: 16),
                TextFieldWidget(
                  formKey: _userNameFormKey,
                  keyboardType: TextInputType.text,
                  hintText: 'Username',
                  labelText: 'Username',
                  onChanged: (value) => {},
                  validateFunc: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Đây là trường bắt buộc';
                    }
                    return null;
                  },
                  controller: _txtUsernameCtrl,
                ),
                SizedBox(height: 16),
                TextFieldWidget(
                  formKey: _emailFormKey,
                  keyboardType: TextInputType.emailAddress,
                  hintText: 'Email',
                  labelText: 'Email',
                  onChanged: (value) => {},
                  validateFunc: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Đây là trường bắt buộc';
                    }
                    return null;
                  },
                  controller: _txtEmailCtrl,
                ),
                SizedBox(height: 16),
                TextFieldWidget(
                  formKey: _passwordFormKey,
                  keyboardType: TextInputType.visiblePassword,
                  passwordVisible: _passwordVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordVisible.value ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromRGBO(121, 120, 130, 1),
                    ),
                    onPressed: () {
                      _passwordVisible.value = !_passwordVisible.value;
                    },
                  ),
                  hintText: 'Mật khẩu',
                  labelText: 'Mật khẩu',
                  onChanged: (value) => {},
                  validateFunc: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Đây là trường bắt buộc';
                    }
                    return null;
                  },
                  controller: _txtPasswordCtrl,
                ),
                SizedBox(height: 16),
                TextFieldWidget(
                  formKey: _confirmPasswordFormKey,
                  keyboardType: TextInputType.visiblePassword,
                  passwordVisible: _passwordConfirmVisible.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      // Based on passwordVisible state choose the icon
                      _passwordConfirmVisible.value ? Icons.visibility : Icons.visibility_off,
                      color: const Color.fromRGBO(121, 120, 130, 1),
                    ),
                    onPressed: () {
                      _passwordConfirmVisible.value = !_passwordConfirmVisible.value;
                    },
                  ),
                  hintText: 'Xác nhận mật khẩu',
                  labelText: 'Xác nhận mật khẩu',
                  onChanged: (value) => {},
                  validateFunc: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Đây là trường bắt buộc';
                    } else if (value != _txtPasswordCtrl.text) {
                      return 'Xác nhận khẩu không trùng khớp';
                    }
                    return null;
                  },
                  controller: _txtConfirmPasswordCtrl,
                ),
                SizedBox(height: 16),
                Container(
                  height: 48,
                  width: double.infinity,
                  child: SubmitButton(
                    'Đăng ký',
                    onPressed: () {
                      if (_emailFormKey.currentState!.validate() && _userNameFormKey.currentState!.validate()) {
                        isLoading.value = true;
                        ref
                            .read(authProvider)
                            .register(
                              _txtFullNameCtrl.text,
                              _txtUsernameCtrl.text,
                              _txtEmailCtrl.text,
                              _txtPasswordCtrl.text,
                            )
                            .then((value) {
                          isLoading.value = false;
                          if (value) {
                            CommonFunction.showSnackBar('Đăng ký thành công, vui lòng kiểm tra email để kích hoạt', context, Colors.green);
                            context.router.push(LoginRoute());
                          } else {
                            CommonFunction.showSnackBar('Email đã được đăng ký', context, Colors.red);
                          }
                        });
                      }
                    },
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Bạn đã có tài khoản?',
                      style: TextStyle(
                        color: Color(0xFF243757),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        context.router.pop();
                      },
                      child: Text(
                        'Đăng nhập',
                        style: TextStyle(
                          color: Color(0xFFD71920),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.06,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        isLoading.value ? Loading() : const SizedBox.shrink(),
      ],
    );
  }
}
