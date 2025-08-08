import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/widgets/submit_button_widget.dart';

@RoutePage()
class WelcomeScreen extends HookConsumerWidget {
  final lstUrlImage = ['assets/images/intro_app.png', 'assets/images/intro_app1.png', 'assets/images/intro_app2.png'];
  final lstWidget = <Widget>[
    Column(
      children: [
        Text(
          'Khám phá khả năng mua sắm vô tận',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Khám phá bộ sưu tập lớn các sản phẩm từ các thương hiệu hàng đầu, tất cả ở một nơi.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    ),
    Column(
      children: [
        Text(
          'Trải nghiệm mua sắm dễ dàng',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Tận hưởng giao diện liền mạch và trực quan giúp việc mua sắm trở nên dễ dàng.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    ),
    Column(
      children: [
        Text(
          'Đón đầu các xu hướng mới nhất"',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        Text(
          'Hãy là người đầu tiên khám phá và sở hữu những sản phẩm thời trang, công nghệ và phong cách sống hot nhất',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFFFAFAFA),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        )
      ],
    )
  ];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final indexNow = useState(0);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: AssetImage(lstUrlImage[indexNow.value]),
          fit: BoxFit.cover,
        )),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Spacer(),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              height: 130,
              child: lstWidget[indexNow.value],
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: lstWidget.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => {indexNow.value = entry.key},
                  child: Container(
                    width: indexNow.value == entry.key ? 24.0 : 12.0,
                    height: 12.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: indexNow.value == entry.key ? Color(0xFF055FA7) : Colors.white),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 40),
            Container(
              width: double.infinity,
              height: 48,
              margin: EdgeInsets.symmetric(horizontal: 16),
              decoration: ShapeDecoration(
                color: Color(0xFF055FA7),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(56),
                ),
              ),
              child: SubmitButton(
                indexNow.value == 2 ? 'Bắt đầu' : 'Next',
                onPressed: () {
                  if (indexNow.value == 2) {
                    AutoRouter.of(context).push(LoginRoute());
                  } else {
                    indexNow.value++;
                  }
                },
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
