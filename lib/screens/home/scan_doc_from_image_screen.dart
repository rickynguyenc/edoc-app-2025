import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

@RoutePage()
class ScanDocFromImageScreen extends HookConsumerWidget {
  const ScanDocFromImageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageFile = useState<String?>(null); // path or url
    final scannedText = useState<String>('');
    final isLoading = useState(false);

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
              'Quét tài liệu từ ảnh',
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
            Text(
              'Chọn ảnh tài liệu để quét',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 17,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 12),
            GestureDetector(
              onTap: () async {
                // TODO: Implement image picker
              },
              child: Container(
                height: 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Color(0xffef2e34), width: 1.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: imageFile.value == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, color: Color(0xffef2e34), size: 40),
                          SizedBox(height: 8),
                          Text(
                            'Nhấn để chọn ảnh',
                            style: TextStyle(color: Colors.black54, fontSize: 15),
                          ),
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          imageFile.value!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 180,
                        ),
                      ),
              ),
            ),
            SizedBox(height: 18),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffef2e34),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 48),
              ),
              icon: Icon(Icons.document_scanner, color: Colors.white),
              label: Text(
                'Quét văn bản từ ảnh',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: imageFile.value == null || isLoading.value
                  ? null
                  : () async {
                      isLoading.value = true;
                      // TODO: Implement OCR scan logic
                      await Future.delayed(Duration(seconds: 2));
                      scannedText.value = 'Kết quả quét văn bản sẽ hiển thị ở đây...';
                      isLoading.value = false;
                    },
            ),
            SizedBox(height: 24),
            Text(
              'Kết quả văn bản',
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
                  border: Border.all(color: Color(0xffef2e34), width: 1.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isLoading.value
                    ? Center(child: CircularProgressIndicator(color: Color(0xffef2e34)))
                    : SingleChildScrollView(
                        child: Text(
                          scannedText.value,
                          style: TextStyle(fontSize: 15, color: Colors.black87, height: 1.6),
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