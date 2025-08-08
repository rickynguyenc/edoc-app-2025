import 'dart:async';

import 'package:auto_route/auto_route.dart';
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
import 'package:pin_code_fields/pin_code_fields.dart';

@RoutePage()
class ResetPasswordScreen extends HookConsumerWidget {
  final String email;
  ResetPasswordScreen({required this.email});
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _newPasswordFormKey = GlobalKey<FormState>();
    final _confirmPasswordFormKey = GlobalKey<FormState>();
    final _txtnewPasswordCtrl = TextEditingController();
    final _txtConfirmPasswordCtrl = TextEditingController();
    final currentText = useState('');
    final isLoading = useState(false);
    useEffect(() {
      onTapRecognizer = TapGestureRecognizer()
        ..onTap = () {
          // Navigator.pop(context);
        };
      errorController = StreamController<ErrorAnimationType>();
      return () {
        onTapRecognizer.dispose();
        errorController.close();
      };
    }, []);
    return Stack(children: [
      Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_outlined,
                        size: 24,
                      ),
                      onPressed: () {
                        context.router.pop();
                      },
                    ),
                  )
                ],
              ),
              SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 24),
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          'Đặt lại mật khẩu',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF212121),
                            fontSize: 24,
                            height: 1.7,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: SizedBox(
                          width: 283,
                          child: Text(
                            'Nhập Email của bạn. Một mã OTP sẽ được gửi để đặt lại mật khẩu mới.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF616161),
                              fontSize: 16,
                              height: 1.7,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                      Form(
                        key: formKey,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0),
                            child: PinCodeTextField(
                              appContext: context,
                              pastedTextStyle: const TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),
                              length: 6,
                              obscureText: false,
                              obscuringCharacter: '*',
                              animationType: AnimationType.fade,
                              // validator: (v) {
                              //   if ((v?.length ?? 0) < 3) {
                              //     return 'Vui lòng nhập mã xác thực';
                              //   } else {
                              //     return null;
                              //   }
                              // },
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.box,
                                activeColor: Colors.transparent, // active border color
                                inactiveColor: Colors.transparent, // inactive border color
                                selectedColor: Color(0xFF055FA7),
                                borderRadius: BorderRadius.circular(5),
                                fieldHeight: 60,
                                fieldWidth: 50,
                                fieldOuterPadding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                                selectedFillColor: Color(0xFFF4F6F9),
                                activeFillColor: Color(0xFFF4F6F9), // active fill color
                                inactiveFillColor: Color(0xFFF4F6F9), // inactive fill color
                                errorBorderColor: Colors.red,
                              ),
                              cursorColor: Colors.black,
                              animationDuration: Duration(milliseconds: 300),
                              textStyle: TextStyle(fontSize: 20, height: 1.6),
                              enableActiveFill: true,
                              errorAnimationController: errorController,
                              controller: textEditingController,
                              keyboardType: TextInputType.text,
                              boxShadows: [
                                BoxShadow(
                                  offset: Offset(0, 1),
                                  color: Colors.black12,
                                  blurRadius: 10,
                                )
                              ],
                              onCompleted: (v) {
                                print('Completed');
                              },
                              // onTap: () {
                              //   print("Pressed");
                              // },
                              onChanged: (value) {
                                currentText.value = value;
                              },
                              beforeTextPaste: null,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Text(
                          hasError ? '*Please fill up all the cells properly' : '',
                          style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
                        ),
                      ),
                      SizedBox(height: 24),
                      Text(
                        'Mật khẩu',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFieldWidget(
                        formKey: _newPasswordFormKey,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Enter your password',
                        labelText: 'Mật khẩu',
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
                      Text(
                        'Xác nhận mật khẩu',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 8),
                      TextFieldWidget(
                        formKey: _confirmPasswordFormKey,
                        keyboardType: TextInputType.visiblePassword,
                        hintText: 'Enter your password',
                        labelText: 'Xác nhận mật khẩu',
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
                      SizedBox(height: 48),
                      Container(
                        height: 48,
                        width: double.infinity,
                        child: SubmitButton(
                          'Xác nhận',
                          onPressed: () async {
                            if (_newPasswordFormKey.currentState!.validate() && _confirmPasswordFormKey.currentState!.validate()) {
                              isLoading.value = true;
                              ref.read(authProvider).resetPassword(email, currentText.value, _txtConfirmPasswordCtrl.text).then((value) {
                                isLoading.value = false;
                                if (value) {
                                  CommonFunction.showSnackBar('Đặt lại mật khẩu thành công', context, Colors.green);

                                  context.router.replaceAll(
                                    [
                                      const LoginRoute(),
                                    ],
                                  );
                                } else {
                                  CommonFunction.showSnackBar('Mã OTP không đúng', context, Colors.red);
                                }
                              });
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      isLoading.value ? Loading() : const SizedBox.shrink(),
    ]);
  }
}
