import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/models/ai_agent_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/app_route/app_route.dart';
import '../../providers/ai_document_genarator_provider.dart';

@RoutePage()
class AIDocumentGenaratorScreen extends HookConsumerWidget {
  const AIDocumentGenaratorScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final styleDoc = useState('professional');
    final lengthDoc = useState('medium');
    final docTypeIndex = ref.watch(docTypeIndexProvider);

    // Add controllers for each field
    final _txtController1 = useTextEditingController();
    final _txtController2 = useTextEditingController();
    final _txtController3 = useTextEditingController();
    final _txtController4 = useTextEditingController();
    final _txtController5 = useTextEditingController();
    final _txtController6 = useTextEditingController();
    final _txtController7 = useTextEditingController();

    // Define label and hint text for each docTypeIndex
    final List<List<String>> labels = [
      // 0: Đề xuất Kinh doanh
      [
        'Tên công ty *',
        'Tên dự án *',
        'Ngân sách dự kiến *',
        'Thời gian thực hiện *',
        'Mục tiêu dự án *',
        'Đối tượng mục tiêu',
      ],
      // 1: Biên bản Họp
      [
        'Tiêu đề cuộc họp *',
        'Ngày họp *',
        'Địa điểm *',
        'Người tham dự *',
        'Nội dung chính *',
        'Quyết định',
      ],
      // 2: Báo cáo Dự án
      [
        'Tên dự án *',
        'Kỳ báo cáo *',
        'Tiến độ hoàn thành (%) *',
        'Thành tựu đạt được *',
        'Thách thức gặp phải',
        'Kế hoạch tiếp theo *',
      ],
      // 3: Mô tả Công việc
      [
        'Tên vị trí *',
        'Phòng ban *',
        'Kinh nghiệm yêu cầu *',
        'Trách nhiệm chính *',
        'Yêu cầu kỹ năng *',
        'Quyền lợi',
      ],
    ];

    final List<List<String>> hints = [
      // 0: Đề xuất Kinh doanh
      [
        'VD: Công ty ABC',
        'VD: Hệ thống quản lý tài liệu',
        'VD: 500 triệu VNĐ',
        'VD: 6 tháng',
        'Mô tả chi tiết mục tiêu...',
        'VD: Doanh nghiệp vừa và nhỏ',
      ],
      // 1: Biên bản Họp
      [
        'VD: Họp tổng kết quý I',
        'VD: 01/08/2025',
        'VD: Phòng họp tầng 3',
        'VD: Nguyễn Văn A, Trần Thị B...',
        'Tóm tắt nội dung chính...',
        'Các quyết định đã thống nhất...',
      ],
      // 2: Báo cáo Dự án
      [
        'VD: Dự án ABC',
        'VD: Tháng 7/2025',
        'VD: 80',
        'Liệt kê thành tựu nổi bật...',
        'Những khó khăn, thách thức...',
        'Kế hoạch cho giai đoạn tiếp theo...',
      ],
      // 3: Mô tả Công việc
      [
        'VD: Nhân viên kinh doanh',
        'VD: Phòng Kinh doanh',
        'VD: 2 năm kinh nghiệm',
        'Liệt kê trách nhiệm chính...',
        'Các kỹ năng cần thiết...',
        'Quyền lợi, phúc lợi...',
      ],
    ];

    final documentTypes = [
      'Đề xuất Kinh doanh',
      'Biên bản Họp',
      'Báo cáo Dự án',
      'Mô tả Công việc',
    ];

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
              Text('Tạo tài liệu AI',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold)),
            ],
          ),
          subtitle: Text('Tạo tài liệu chuyên nghiệp với AI',
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DocTypeCard(
                    index: 0,
                    icon: Icons.work_outline,
                    title: "Đề xuất Kinh doanh",
                    subtitle: "Tạo đề xuất kinh doanh chuyên nghiệp",
                    tag: "Kinh doanh",
                    tagColor: Color(0xffef2e34),
                  ),
                  _DocTypeCard(
                    index: 1,
                    icon: Icons.groups_outlined,
                    title: "Biên bản Họp",
                    subtitle: "Tạo biên bản họp chi tiết và chuyên nghiệp",
                    tag: "Văn phòng",
                    tagColor: Color(0xffef2e34),
                  ),
                  _DocTypeCard(
                    index: 2,
                    icon: Icons.show_chart_outlined,
                    title: "Báo cáo Dự án",
                    subtitle: "Tạo báo cáo tiến độ và kết quả dự án",
                    tag: "Dự án",
                    tagColor: Color(0xffef2e34),
                  ),
                  _DocTypeCard(
                    index: 3,
                    icon: Icons.person_outline,
                    title: "Mô tả Công việc",
                    subtitle: "Tạo mô tả công việc thu hút ứng viên",
                    tag: "Nhân sự",
                    tagColor: Color(0xffef2e34),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _FormLabel(labels[docTypeIndex][0]),
                      SizedBox(height: 4),
                      _FormTextField(
                        hint: hints[docTypeIndex][0],
                        controller: _txtController1,
                      ),
                      SizedBox(height: 16),
                      _FormLabel(labels[docTypeIndex][1]),
                      SizedBox(height: 4),
                      _FormTextField(
                        hint: hints[docTypeIndex][1],
                        controller: _txtController2,
                      ),
                      SizedBox(height: 16),
                      _FormLabel(labels[docTypeIndex][2]),
                      SizedBox(height: 4),
                      _FormTextField(
                        hint: hints[docTypeIndex][2],
                        controller: _txtController3,
                      ),
                      SizedBox(height: 16),
                      _FormLabel(labels[docTypeIndex][3]),
                      SizedBox(height: 4),
                      _FormTextField(
                        hint: hints[docTypeIndex][3],
                        controller: _txtController4,
                      ),
                      SizedBox(height: 16),
                      _FormLabel(labels[docTypeIndex][4]),
                      SizedBox(height: 4),
                      _FormTextField(
                        hint: hints[docTypeIndex][4],
                        maxLines: 4,
                        controller: _txtController5,
                      ),
                      SizedBox(height: 16),
                      _FormLabel(labels[docTypeIndex][5]),
                      SizedBox(height: 4),
                      _FormTextField(
                        hint: hints[docTypeIndex][5],
                        controller: _txtController6,
                      ),
                      SizedBox(height: 16),
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
                                        value: 'formal',
                                        child: Text('Trang trọng'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'friendly',
                                        child: Text('Thân thiện'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'professional',
                                        child: Text('Chuyên nghiệp'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'persuasive',
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
                                _FormLabel('Độ dài'),
                                SizedBox(height: 4),
                                Container(
                                  child: DropdownButtonFormField<String>(
                                    value: lengthDoc.value,
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontSize: 14,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    items: [
                                      DropdownMenuItem(
                                        value: 'short',
                                        child: Text('Ngắn gọn'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'medium',
                                        child: Text('Trung bình'),
                                      ),
                                      DropdownMenuItem(
                                        value: 'long',
                                        child: Text('Chi tiết'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      lengthDoc.value = value ?? 'Trung bình';
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
                        hint: 'Thêm bất kỳ yêu cầu đặc biệt nào...',
                        maxLines: 4,
                        controller: _txtController7,
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
            String requirement = "";
            switch (docTypeIndex) {
              case 0: // Đề xuất Kinh doanh
                requirement = "Tạo đề xuất kinh doanh với các thông tin: \n"
                    "Tên công ty: ${_txtController1.text}\n"
                    "Tên dự án: ${_txtController2.text}\n"
                    "Ngân sách: ${_txtController3.text}\n"
                    "Thời gian: ${_txtController4.text}\n"
                    "Mục tiêu: ${_txtController5.text}\n"
                    "Đối tượng: ${_txtController6.text}\n"
                    "Phong cách: ${styleDoc.value}\n"
                    "Độ dài: ${lengthDoc.value}\n";
                break;
              case 1: // Biên bản Họp
                requirement = "Tạo biên bản họp với các thông tin: \n"
                    "Tiêu đề: ${_txtController1.text}\n"
                    "Ngày họp: ${_txtController2.text}\n"
                    "Địa điểm: ${_txtController3.text}\n"
                    "Người tham dự: ${_txtController4.text}\n"
                    "Nội dung chính: ${_txtController5.text}\n"
                    "Quyết định: ${_txtController6.text}\n"
                    "Phong cách: ${styleDoc.value}\n"
                    "Độ dài: ${lengthDoc.value}\n";
                break;
              case 2: // Báo cáo Dự án
                requirement = "Tạo báo cáo dự án với các thông tin: \n"
                    "Tên dự án: ${_txtController1.text}\n"
                    "Kỳ báo cáo: ${_txtController2.text}\n"
                    "Tiến độ hoàn thành: ${_txtController3.text}\n"
                    "Thành tựu: ${_txtController4.text}\n"
                    "Thách thức: ${_txtController5.text}\n"
                    "Kế hoạch tiếp theo: ${_txtController6.text}\n"
                    "Phong cách: ${styleDoc.value}\n"
                    "Độ dài: ${lengthDoc.value}\n";
                break;
              case 3: // Mô tả Công việc
                requirement = "Tạo mô tả công việc với các thông tin: \n"
                    "Tên vị trí: ${_txtController1.text}\n"
                    "Phòng ban: ${_txtController2.text}\n"
                    "Kinh nghiệm yêu cầu: ${_txtController3.text}\n"
                    "Trách nhiệm chính: ${_txtController4.text}\n"
                    "Yêu cầu kỹ năng: ${_txtController5.text}\n"
                    "Quyền lợi: ${_txtController6.text}\n"
                    "Phong cách: ${styleDoc.value}\n"
                    "Độ dài: ${lengthDoc.value}\n";
                break;
              default:
            }
            final dtoBody = GenarateDocDto(
                documentType: documentTypes[docTypeIndex],
                title: _txtController1.text,
                requirements: requirement,
                tone: styleDoc.value,
                length: lengthDoc.value,
                includeVisuals: false,
                language: "vi");
            ref
                .read(aiDocumentGeneratorProvider.notifier)
                .generateDocument(dtoBody);
            context.router.push(AIDocumentPreviewRoute());
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xffef2e34),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            minimumSize: Size(0, 48),
          ),
          child: Text(
            'Tạo tài liệu',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// Add this widget below your class or in a separate file
class _DocTypeCard extends HookConsumerWidget {
  final int index;
  final IconData icon;
  final String title;
  final String subtitle;
  final String tag;
  final Color tagColor;

  const _DocTypeCard({
    required this.index,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.tagColor,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final docTypeIndex = ref.watch(docTypeIndexProvider);
    return Container(
      height: 142,
      width: 200,
      margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: docTypeIndex == index ? Color(0xffef2e34) : Colors.grey[300]!,
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
                  color: tagColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(8),
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
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
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: tagColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        tag,
                        style: TextStyle(
                          color: tagColor,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
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
