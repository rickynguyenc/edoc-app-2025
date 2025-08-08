import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateButton extends HookConsumerWidget {
  final Function() onPressed;
  final String text;
  final Color? color;
  const CreateButton(this.text, {Key? key, required this.onPressed, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      height: 42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? Color(0xFFEC1C23),
          shape: RoundedRectangleBorder(
            side: BorderSide(width: 1, color: Color(0xFFEC1C23)),
            borderRadius: BorderRadius.circular(45),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          children: [
            Icon(
              Icons.add,
              color: Colors.white,
              size: 16,
            ),
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
