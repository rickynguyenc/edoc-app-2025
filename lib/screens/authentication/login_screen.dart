import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/utils/widgets/loading_mark.dart';
import 'package:edoc_tabcom/core/utils/widgets/text_field_widget.dart';
import 'package:edoc_tabcom/providers/authentication_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/local_storage.dart';

import '../../core/utils/widgets/submit_button_widget.dart';

@RoutePage()
class LoginScreen extends HookConsumerWidget {
  final _userNameFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _txtUsernameCtrl = TextEditingController();
  final _txtPasswordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _rememberLogin = useState(false);
    final _username = useState('');
    final _password = useState('');
    final isLoading = useState(false);
    final _passwordVisible = useState(false);
    useEffect(() {
      UserPreferences.instance.saveLanLogin(1);
      return null;
    }, const []);
    return Stack(children: [
      Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 64,
                ),
                Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 16),
                    child: SvgPicture.asset(
                      'assets/icons/logo.svg',
                      height: 48,
                    )),
                SizedBox(
                  height: 32,
                ),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  alignment: Alignment.center,
                  child: Text(
                    'Chào mừng bạn đã trở lại!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF212121),
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 227,
                    child: Text(
                      'Kho thư viện trực tuyến được chia sẻ lớn nhất Việt Nam',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF98A1B0),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.06,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 24),
                // Text(
                //   'Tên người dùng',
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // SizedBox(height: 8),
                TextFieldWidget(
                  keyboardType: TextInputType.emailAddress,
                  formKey: _userNameFormKey,
                  hintText: 'Tên người dùng/email hoặc SĐT',
                  labelText: 'Tên người dùng',
                  onChanged: (value) => _username.value = value,
                  validateFunc: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Đây là trường bắt buộc!';
                    }
                    return null;
                  },
                  controller: _txtUsernameCtrl,
                ),
                SizedBox(height: 16),
                // Text(
                //   'Mật khẩu',
                //   style: TextStyle(
                //     fontSize: 14,
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // SizedBox(height: 8),
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
                  onChanged: (value) => _password.value = value,
                  validateFunc: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Đây là trường bắt buộc!';
                    }
                    return null;
                  },
                  controller: _txtPasswordCtrl,
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        context.router.push(ForgotPasswordRoute());
                      },
                      child: Text(
                        'Quên mật khẩu',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFD71920),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        context.router.push(RegisterRoute());
                      },
                      child: Text(
                        'Tạo tài khoản',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Color(0xFFD71920),
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 32,
                ),
                Container(
                  height: 48,
                  width: double.infinity,
                  child: SubmitButton(
                    'Đăng nhập',
                    onPressed: () {
                      if (_passwordFormKey.currentState!.validate() && _userNameFormKey.currentState!.validate()) {
                        isLoading.value = true;
                        ref
                            .read(authProvider)
                            .login(
                              context,
                              _username.value,
                              _password.value,
                            )
                            .then((value) {
                          isLoading.value = false;
                          if (value) {
                            context.router.replaceAll([HomeRoute()], updateExistingRoutes: true);
                          }
                        });
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        color: Color(0xFFBDBDBD),
                        height: 1,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'Hoặc',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF98A1B0),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        color: Color(0xFFBDBDBD),
                        height: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                Material(
                  child: InkWell(
                    onTap: () {
                      ref.read(authProvider).loginWithGoogle(context).then((value) {
                        if (value) {
                          context.router.replaceAll([HomeRoute()], updateExistingRoutes: true);
                        }
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFEEEEEE)),
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            child: Image.asset(
                              'assets/images/google.png',
                              height: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Đăng nhập với Google',
                            style: TextStyle(
                              color: Color(0xFF212121),
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.20,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      isLoading.value ? Loading() : const SizedBox.shrink(),
    ]);
  }
}
