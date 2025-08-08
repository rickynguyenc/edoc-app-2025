import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black54.withOpacity(0.5),
      ),
      child: const SizedBox(
        width: 50,
        height: 50,
        child: SpinKitPouringHourGlassRefined(
          color: Colors.white,
          size: 50.0,
          duration: const Duration(milliseconds: 1200),
        ),
      ),
    );
  }
}
