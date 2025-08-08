import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/extension/common_function.dart';
import 'package:edoc_tabcom/core/utils/widgets/loading_mark.dart';
import 'package:edoc_tabcom/core/utils/widgets/submit_button_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/text_field_widget.dart';
import 'package:edoc_tabcom/providers/authentication_provider.dart';

@RoutePage()
class ForgotPasswordScreen extends HookConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _emailFormKey = GlobalKey<FormState>();
    final _txtEmailCtrl = TextEditingController();
    final isLoading = useState(false);
    return Stack(children: [
      Scaffold(
        resizeToAvoidBottomInset: true,
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
                  'Quên mật khẩu',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF243757),
                    fontSize: 20,
                    height: 1.7,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 24),
              TextFieldWidget(
                formKey: _emailFormKey,
                keyboardType: TextInputType.emailAddress,
                hintText: 'Email đã đăng ký',
                labelText: 'Email',
                onChanged: (value) {},
                validateFunc: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Vui lòng nhập email';
                  }
                  return null;
                },
                controller: _txtEmailCtrl,
              ),
              SizedBox(height: 24),
              Row(
                children: [
                  Container(
                    width: 108,
                    height: 48,
                    child: SubmitButton(
                      'Quay lại',
                      color: Color(0xFF98A1B0),
                      onPressed: () async {
                        context.router.pop();
                      },
                    ),
                  ),
                  SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 48,
                      width: double.infinity,
                      child: SubmitButton(
                        'Gửi đi',
                        onPressed: () async {
                          if (_emailFormKey.currentState!.validate()) {
                            isLoading.value = true;
                            final result = await ref.read(authProvider).forgotPassword(_txtEmailCtrl.text);
                            isLoading.value = false;
                            if (result) {
                              context.router.pop();
                              CommonFunction.showSnackBar('Vui lòng kiểm tra email để thay đổi mật khẩu mới', context, Colors.green);
                            } else {
                              CommonFunction.showSnackBar('Email của bạn không đúng', context, Colors.red);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      isLoading.value ? Loading() : const SizedBox.shrink(),
    ]);
  }
}
