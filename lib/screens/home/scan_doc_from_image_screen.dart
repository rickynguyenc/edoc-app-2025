import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

@RoutePage()
class ScanDocFromImageScreen extends HookConsumerWidget {
  const ScanDocFromImageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scannedText = useState<String>('');
    return Scaffold(
      backgroundColor: Color(0xfff6f7fb),
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          children: [
            Icon(Icons.document_scanner, color: Colors.white),
            SizedBox(width: 8),
            Text(
              'Scan tài liệu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xffef2e34),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 18),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffef2e34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              icon: Icon(Icons.camera_alt_outlined, color: Colors.white),
              label: Text(
                'Scan tại đây',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () async {
                try {
                  final res =
                      await FlutterDocScanner().getScanDocuments(page: 4) ??
                          'Unknown platform documents';
                  // Parse the result if it's a Map

                  try {
                    await http.post(
                        Uri.parse(
                          'https://68bb195284055bce63f130ba.mockapi.io/logs',
                        ),
                        body: {
                          'name': 'line 76 - scan doc',
                          'url': res.toString()
                        });
                    if (Platform.isIOS) {
                      scannedText.value = res[0].toString();
                      return;
                    }
                    // Get directory for downloads
                    if (res is Map && res['pdfUri'] != null) {
                      scannedText.value = res['pdfUri'];
                    } else {
                      scannedText.value = res.toString();
                    }
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
                } on PlatformException {
                  scannedText.value = 'Failed to get scanned documents.';
                }
              },
            ),
            SizedBox(height: 24),
            if (scannedText.value.isNotEmpty)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tài liệu đã scan',
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 17,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(width: 8),
                  // Tải xuống button
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffef2e34),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: Icon(Icons.download, color: Colors.white),
                    label: Text(
                      'Tải xuống',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    onPressed: () async {
                      if (scannedText.value.isNotEmpty) {
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
                          directory = await getApplicationDocumentsDirectory();
                        }
                        final fileSave =
                            File(scannedText.value.replaceFirst('file://', ''));
                        String fileName = scannedText.value.split('/').last;
                        String filePath = "${directory.path}/$fileName";
                        // Write the file to the downloads directory
                        final File file = File(filePath);
                        await file.writeAsBytes(fileSave.readAsBytesSync());
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                              'Đã lưu file tại: $filePath',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            SizedBox(height: 8),
            if (scannedText.value.isNotEmpty)
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffef2e34), width: 1.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  // child: SingleChildScrollView(
                  //   child: Text(
                  //     scannedText.value,
                  //     style: TextStyle(
                  //         fontSize: 15, color: Colors.black87, height: 1.6),
                  //   ),
                  // ),
                  child: Platform.isIOS
                      ? Column(children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(scannedText.value),
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) =>
                                  Center(
                                child: Text(
                                  'Không thể hiển thị ảnh',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ),
                          ),
                        ])
                      : FutureBuilder<bool>(
                          future: Future.value(
                              File(scannedText.value.replaceFirst('file://', '')).existsSync()),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState !=
                                ConnectionState.done) {
                              return Center(
                                  child: CircularProgressIndicator(
                                      color: Color(0xffef2e34)));
                            }
                            if (snapshot.data == true) {
                              return PDFView(
                                filePath: scannedText.value.replaceFirst('file://', ''),
                              );
                            } else {
                              return Center(
                                child: Text(
                                  'Không tìm thấy file PDF hoặc không thể đọc file.',
                                  style: TextStyle(color: Colors.red),
                                ),
                              );
                            }
                          },
                        ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
