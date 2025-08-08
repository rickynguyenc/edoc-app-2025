import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'dart:async';

import 'package:flutter/gestures.dart';

@RoutePage()
class OTPConfirmScreen extends HookConsumerWidget {
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  late StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentText = useState('');
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
    return Scaffold(
      key: scaffoldKey,
      body: GestureDetector(
        onTap: () {},
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  'Xác thực tài khoản',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
                child: Text(
                  'Chúng tôi đã gửi mã xác thực đến số điện thoại của bạn',
                  style: TextStyle(color: Colors.black54, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Form(
                key: formKey,
                child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 30),
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
                      validator: (v) {
                        if ((v?.length ?? 0) < 3) {
                          return 'Vui lòng nhập mã xác thực';
                        } else {
                          return null;
                        }
                      },
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        activeColor: Colors.black38, // active border color
                        inactiveColor: Colors.black38, // inactive border color
                        selectedColor: Colors.black38,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 60,
                        fieldWidth: 50,
                        selectedFillColor: Colors.white,
                        activeFillColor: Colors.white, // active fill color
                        inactiveFillColor: Colors.white, // inactive fill color
                        errorBorderColor: Colors.red,
                      ),
                      cursorColor: Colors.black,
                      animationDuration: Duration(milliseconds: 300),
                      textStyle: TextStyle(fontSize: 20, height: 1.6),
                      enableActiveFill: true,
                      errorAnimationController: errorController,
                      controller: textEditingController,
                      keyboardType: TextInputType.number,
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
                      beforeTextPaste: (text) {
                        print('Allowing to paste $text');
                        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                        //but you can show anything you want here, like your pop up saying wrong paste format or etc
                        return true;
                      },
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  hasError ? '*Please fill up all the cells properly' : '',
                  style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Bạn không nhận được mã?',
                    style: const TextStyle(color: Colors.black54, fontSize: 15),
                    children: [TextSpan(text: ' Gửi lại', recognizer: onTapRecognizer, style: const TextStyle(color: Color(0xFF91D3B3), fontWeight: FontWeight.bold, fontSize: 16))]),
              ),
              SizedBox(
                height: 14,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 16.0),
                padding: const EdgeInsets.all(0),
                height: 48,
                width: 200,
                // constraints: const BoxConstraints(maxWidth: 200, minWidth: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0),
                    // backgroundColor: theme.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                  ),
                  onPressed: () {
                    formKey.currentState?.validate();
                    // conditions for validating
                    // if (currentText.length != 6 || currentText != 'towtow') {
                    //   errorController.add(ErrorAnimationType
                    //       .shake); // Triggering error shake animation
                    //   setState(() {
                    //     hasError = true;
                    //   });
                    // } else {
                    //   setState(() {
                    //     hasError = false;
                    //     scaffoldKey.currentState!.showSnackBar(SnackBar(
                    //       content: Text('Aye!!'),
                    //       duration: Duration(seconds: 2),
                    //     ));
                    //   });
                    // }
                  },
                  child: Center(
                      child: Text(
                    'Xác nhận'.toUpperCase(),
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        ),
      ),
    );
  }
}
