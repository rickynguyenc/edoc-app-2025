import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doc_scanner/flutter_doc_scanner.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
                  if (res is Map && res['pdfUri'] != null) {
                    final pdfUri = res['pdfUri'] as String;
                    scannedText.value = pdfUri;
                  } else {
                    scannedText.value = res.toString();
                  }
                } on PlatformException {
                  scannedText.value = 'Failed to get scanned documents.';
                }
              },
            ),
            SizedBox(height: 24),
            if (scannedText.value.isNotEmpty)Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [
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
              onPressed: () {
                if (scannedText.value.isNotEmpty) {
                  final file = File(scannedText.value.replaceFirst('file://', ''));
                  if (file.existsSync()) {
                    // Handle file download or processing
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tải xuống thành công, đường dẫn: ${file.path}', style: TextStyle(color: Colors.white),),backgroundColor: Colors.green,),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('File không tồn tại!')),
                    );
                  }
                }
              },
            ),
            ],),
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
                  child: FutureBuilder<bool>(
                    future: Future.value(
                        File(scannedText.value.replaceFirst('file://', ''))
                            .existsSync()),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState != ConnectionState.done) {
                        return Center(
                            child: CircularProgressIndicator(
                                color: Color(0xffef2e34)));
                      }
                      if (snapshot.data == true) {
                        return PDFView(
                          filePath:
                              scannedText.value.replaceFirst('file://', ''),
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
