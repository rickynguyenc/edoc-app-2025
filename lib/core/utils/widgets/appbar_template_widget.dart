import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../providers/account_provider.dart';

class LayoutEdoc extends HookConsumerWidget {
  final Widget bodyWidget;
  const LayoutEdoc({required this.bodyWidget, super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfor = ref.watch(accountProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 68,
        backgroundColor: Colors.white,
        title: Container(
          height: 32,
          alignment: Alignment.center,
          // margin: EdgeInsets.only(top: 16),
          child: SvgPicture.asset(
            'assets/icons/logo.svg',
          ),
        ),
        // automaticallyImplyLeading: false,
        leading: Container(
          alignment: Alignment.center,
          child: InkWell(
            onTap: () {
              context.router.push(PersonalViewRoute());
            },
            child: Material(
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  // radius: 16,
                  child: Image.network(
                    '${Environment.apiUrl}${userInfor.avatar}',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/images_default.png', fit: BoxFit.cover);
                    },
                  ),
                ),
              ),
            ),
          ),
        ),

        actions: [
          Container(
            alignment: Alignment.center,
            // width: 32,
            child: ElevatedButton(
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 16,
              ),
              onPressed: () {
                context.router.push(CreateDocumentRoute());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffEC1C23),
                fixedSize: const Size(32, 32),
                minimumSize: const Size(32, 32),
                padding: EdgeInsets.all(0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
      body: bodyWidget,
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          // side: BorderSide(
          //   color: Colors.grey.withOpacity(0.2),
          //   width: 1,
          // ),
        ),
        onPressed: () {
          context.router.push(AIAgentRoute());
        },
        backgroundColor: Colors.red,
        child: Image.asset(
          'assets/images/intelligence.png',
          width: 36,
          height: 36,
        ),
      ),
    );
  }
}
