import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/ai_document_genarator_provider.dart';
import '../../providers/ai_text_refactor_provider.dart';

@RoutePage()
class AITextRefactorScreen extends HookConsumerWidget {
  const AITextRefactorScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleDoc = useState('Chuyên nghiệp');
    final targetReader = useState('Công chúng');
    final refactorType = ref.watch(docTypeIndexProvider);

    // Add controllers for each field
    final _txtController1 = useTextEditingController();
    final _txtController2 = useTextEditingController();
    final _txtController3 = useTextEditingController();
    final _txtController4 = useTextEditingController();
    final _txtController5 = useTextEditingController();
    final _txtController6 = useTextEditingController();
    final _txtController7 = useTextEditingController();

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
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          horizontalTitleGap: 0,
          minLeadingWidth: 0,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.support_agent_outlined, color: Colors.white),
              SizedBox(width: 8),
              Text('Cải thiện văn bản AI',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          subtitle: Text('Nâng cao chất lượng văn bản của bạn với AI', overflow: TextOverflow.ellipsis,
              style: TextStyle(color: Colors.white70, fontSize: 14)),
        ),
        centerTitle: true,
        backgroundColor: Color(0xffef2e34),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            _FormLabel('Văn bản cần cải thiện'),
            SizedBox(height: 4),
            _FormTextField(
              hint: 'Nhập văn bản cần cải thiện...',
              maxLines: 6,
              controller: _txtController1,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _RefactorTypeCard(
                    index: 0,
                    icon: Icons.edit_outlined,
                    title: "Ngữ pháp & Chính tả",
                    subtitle: "Sửa lỗi ngữ pháp, chính tả và dấu câu",
                  ),
                  _RefactorTypeCard(
                    index: 1,
                    icon: Icons.format_color_text_outlined,
                    title: "Độ rõ ràng",
                    subtitle: "Làm cho văn bản dễ hiểu và rõ ràng hơn",
                  ),
                  _RefactorTypeCard(
                    index: 2,
                    icon: Icons.style_outlined,
                    title: "Chuyên nghiệp",
                    subtitle: "Nâng cao tính chuyên nghiệp trong văn bản",
                  ),
                  _RefactorTypeCard(
                    index: 3,
                    icon: Icons.format_quote_outlined,
                    title: "Súc tích",
                    subtitle: "Rút gọn và loại bỏ từ ngữ thừa",
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _FormLabel('Phong cách'),
                                SizedBox(height: 4),
                                Container(
                                  child: DropdownButtonFormField<String>(
                                    value: styleDoc.value,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Trang trọng',
                                        child: Text('Trang trọng'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Thân thiện',
                                        child: Text('Thân thiện'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Chuyên nghiệp',
                                        child: Text('Chuyên nghiệp'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Thuyết phục',
                                        child: Text('Thuyết phục'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      styleDoc.value = value ?? 'Chuyên nghiệp';
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!, width: 1),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!, width: 1),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _FormLabel('Đối tượng đọc'),
                                SizedBox(height: 4),
                                Container(
                                  child: DropdownButtonFormField<String>(
                                    value: targetReader.value,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'Công chúng',
                                        child: Text('Công chúng'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Chuyên gia',
                                        child: Text('Chuyên gia'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Khách hàng',
                                        child: Text('Khách hàng'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Đồng nghiệp',
                                        child: Text('Đồng nghiệp'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'Cấp trên',
                                        child: Text('Cấp trên'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      targetReader.value =
                                          value ?? 'Trung bình';
                                    },
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!, width: 1),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!, width: 1),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide(
                                            color: Colors.grey[300]!, width: 1),
                                      ),
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      _FormLabel('Hướng dẫn bổ sung(tùy chọn)'),
                      SizedBox(height: 4),
                      _FormTextField(
                        hint: 'Thêm yêu cầu cụ thể cho việc cải thiện...',
                        maxLines: 4,
                        controller: _txtController2,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: () {
            // You can now access the text values:
            // _txtController1.text, _txtController2.text, etc.
            context.router.pop();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffef2e34),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: Size(0, 48),
          ),
          child: Text(
            'Cải thiện văn bản',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Add this widget below your class or in a separate file
class _RefactorTypeCard extends HookConsumerWidget {
  final int index;
  final IconData icon;
  final String title;
  final String subtitle;

  const _RefactorTypeCard({
    required this.index,
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refactorType = ref.watch(textRefactorTypeIndexProvider);
    return Container(
      // height: 130,
      width: 200,
      margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: refactorType == index ? Color(0xffef2e34) : Colors.grey[300]!,
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            ref.read(docTypeIndexProvider.notifier).state = index;
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(icon, color: Colors.red, size: 24),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
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

class _FormLabel extends StatelessWidget {
  final String text;
  const _FormLabel(this.text, {super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 15,
        color: Colors.black87,
      ),
    );
  }
}

// Update _FormTextField to accept a controller
class _FormTextField extends StatelessWidget {
  final String hint;
  final int maxLines;
  final TextEditingController? controller;
  const _FormTextField({
    required this.hint,
    this.maxLines = 1,
    this.controller,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle:
            TextStyle(color: Colors.grey[500], fontWeight: FontWeight.w400),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      ),
    );
  }
}
