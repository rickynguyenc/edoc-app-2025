import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/app_route/app_route.dart';

@RoutePage()
class AIAgentScreen extends HookConsumerWidget {
  const AIAgentScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Expanded(
              child: _FeatureCard(
                title: "Tạo tài liệu với AI",
                subtitle: "Tạo tài liệu chuyên nghiệp với sự hỗ trợ của AI",
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: _FeatureCard(
                title: "Cải thiện văn bản AI",
                subtitle:
                    "Nâng cao chất lượng văn bản của bạn với sự hỗ trợ của AI",
              ),
            ),
            SizedBox(height: 20),
            // Scan Document Feature
            Expanded(
              child: _FeatureCard(
                title: "Scan tài liệu",
                subtitle: "Quét tài liệu nhanh chóng và dễ dàng",
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 56,
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xffef2e34),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.zero,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon(Icons.close, color: Colors.white, size: 18,),
                    // SizedBox(width: 8),
                    Text(
                      'Đóng',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ],
                ),
                onPressed: () {
                  context.router.pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Add this widget below your class or in a separate file
class _FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;

  const _FeatureCard({
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          context.router.push(
            title == "Tạo tài liệu với AI"
                ? AIDocumentGenaratorRoute()
                : title == "Cải thiện văn bản AI"
                    ? AITextRefactorRoute()
                    : ScanDocFromImageRoute(), // Adjust this route as needed
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            border: Border.all(
              color: Colors.red.withOpacity(0.6),
              width: 1,
            ),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.only(bottom: 8),
                        child: Icon(
                          title == "Tạo tài liệu với AI"
                              ? Icons.edit_document
                              : title == "Cải thiện văn bản AI"
                                  ? Icons.text_fields
                                  : Icons.document_scanner_outlined,
                          color: Colors.red,
                          size: 48,
                        )),
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
