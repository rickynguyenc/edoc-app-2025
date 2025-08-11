import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../providers/ai_document_genarator_provider.dart';
import 'aichatbot_screen.dart';

@RoutePage()
class AIDocumentPreviewScreen extends HookConsumerWidget {
  const AIDocumentPreviewScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = ref.watch(aiDocumentGeneratorProvider);
    final isLoading = ref.watch(genarateDocLoading);
    return Scaffold(
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
          'Xem trước tài liệu',
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
                        text: 'Đang tạo tài liệu...',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      )
                    ],
                  ),
                ])
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // Icon(Icons.remove_red_eye_outlined,
                      //     color: Colors.grey, size: 20),
                      // SizedBox(width: 8),
                      // Text('Xem trước',
                      //     style: TextStyle(
                      //         color: Colors.black87,
                      //         fontSize: 16,
                      //         fontWeight: FontWeight.w500)),
                      // Spacer(),
                      // Chỉnh sửa
                      SizedBox(
                        // height: 30,
                        child: ElevatedButton(
                          onPressed: () {
                            context.router.pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: BorderSide(color: Color(0xffef2e34)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.edit_outlined,
                                  color: Color(0xffef2e34), size: 20),
                              SizedBox(width: 4),
                              Text(
                                'Chỉnh sửa',
                                style: TextStyle(
                                    color: Color(0xffef2e34), fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 8),
                      // Tải xuống
                      SizedBox(
                        // height: 30,
                        child: ElevatedButton(
                          onPressed: () async {
                            final text = content.response ??
                                content.errorMessage ??
                                'Không có nội dung';
                            if (text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(
                                        'Không có nội dung để tải xuống.')),
                              );
                            }
                            // Request storage permission (Android)
                            // if (Platform.isAndroid) {
                            //   final status = await Permission.storage.request();
                            //   if (!status.isGranted) {
                            //     ScaffoldMessenger.of(context).showSnackBar(
                            //       SnackBar(
                            //           content: Text(
                            //               'Cần quyền truy cập bộ nhớ để tải xuống.')),
                            //     );
                            //     return;
                            //   }
                            // }

                            try {
                              // Get directory for downloads
                              Directory? directory;
                              if (Platform.isAndroid) {
                                directory = await getExternalStorageDirectory();
                                // Optional: Clean up the path for Android 11+
                                String newPath = "";
                                List<String> paths = directory!.path.split("/");
                                for (int x = 1; x < paths.length; x++) {
                                  String folder = paths[x];
                                  if (folder == "Android") break;
                                  newPath += "/" + folder;
                                }
                                newPath = newPath + "/Download";
                                directory = Directory(newPath);
                              } else {
                                directory =
                                    await getApplicationDocumentsDirectory();
                              }

                              String filePath =
                                  "${directory.path}/tai_lieu_ai.txt";
                              final file = File(filePath);
                              await file.writeAsString(text);

                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  content: Text(
                                    'Đã lưu file tại: $filePath',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                    'Lỗi khi lưu file: $e',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xffef2e34),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: EdgeInsets.all(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.download_outlined,
                                  color: Colors.white, size: 20),
                              SizedBox(width: 4),
                              Text(
                                'Tải xuống',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey.shade300),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: Text(
                          content.response ??
                              content.errorMessage ??
                              'Không có nội dung',
                          style: TextStyle(fontSize: 16, color: Colors.black87),
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
