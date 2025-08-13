import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';

import '../../providers/ai_text_refactor_provider.dart';
import 'aichatbot_screen.dart';

@RoutePage()
class AIImproveTextPreviewScreen extends HookConsumerWidget {
  final String originalText;
  final VoidCallback? onApply;

  const AIImproveTextPreviewScreen({
    super.key,
    required this.originalText,
    this.onApply,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final improvedText = ref.watch(aiImproveTextsProvider);
    final isLoading = ref.watch(improveLoading);
    return Scaffold(
      backgroundColor: Color(0xfff6f7fb),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.close,
            color: Colors.white,
          ),
          constraints: const BoxConstraints(
            minWidth: 40,
            minHeight: 40,
            maxWidth: 40,
            maxHeight: 40,
          ),
          onPressed: () {
            context.router.pop();
          },
          padding: const EdgeInsets.all(0),
        ),
        title: Text(
          'Kết quả cải thiện văn bản',
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffef2e34),
      ),
      body: isLoading
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: Color(0xffef2e34),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoadingDots(
                        text: 'Đang cải thiện văn bản...',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ])
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Action Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton.icon(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Color(0xffef2e34),
                          side: BorderSide(color: Color(0xffef2e34)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Icon(Icons.copy, size: 18),
                        label: Text('Sao chép'),
                        onPressed: () {
                          Clipboard.setData(
                              ClipboardData(text: improvedText.response ?? ''));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Đã sao chép văn bản sau cải thiện!',
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.green,
                            ),
                          );
                        },
                      ),
                      SizedBox(width: 12),
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffef2e34),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        icon: Icon(Icons.check, size: 18, color: Colors.white),
                        label: Text(
                          'Áp dụng thay đổi',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          context.router.pop();
                          onApply ?? () {};
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  // Original Text
                  Text(
                    'Văn bản gốc',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Color(0xffef2e34), width: 1.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        child: Text(
                          originalText,
                          style: TextStyle(
                              fontSize: 15, color: Colors.black87, height: 1.6),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  // Improved Text
                  Text(
                    'Văn bản đã cải thiện',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 8),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Color(0xffef2e34), width: 1.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: BouncingScrollPhysics(),
                        child: Text(
                          improvedText.response ??
                              improvedText.errorMessage ??
                              'Không có nội dung',
                          style: TextStyle(
                              fontSize: 15, color: Colors.black87, height: 1.6),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
