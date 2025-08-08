import 'package:flutter/material.dart';

class TextFieldWidget extends StatefulWidget {
  final String? Function(String?)? validateFunc;
  final Function(String)? onChanged;
  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final bool? passwordVisible;
  final Widget? suffixIcon;
  final GlobalKey<FormState> formKey;
  const TextFieldWidget(
      {super.key,
      required this.validateFunc,
      required this.controller,
      required this.hintText,
      required this.formKey,
      required this.onChanged,
      this.labelText,
      required this.keyboardType,
      this.suffixIcon,
      this.passwordVisible});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        controller: widget.controller,
        obscureText: widget.passwordVisible ?? false,
        keyboardType: widget.keyboardType,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            fillColor: Colors.white,
            filled: true,
            hintStyle: TextStyle(color: Color.fromRGBO(165, 165, 171, 1)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(width: 1, color: Color(0xFF055FA7)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                width: 1,
                style: BorderStyle.none,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
            ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                borderSide: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(234, 84, 85, 1),
                )),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(6)),
              borderSide: BorderSide(
                width: 1,
                color: Color.fromRGBO(234, 84, 85, 1),
              ),
            ),
            suffixIcon: widget.suffixIcon),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: widget.validateFunc,
      ),
    );
  }
}
