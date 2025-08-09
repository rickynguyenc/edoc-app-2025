import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/ai_document_genarator_provider.dart';

@RoutePage()
class AIDocumentGenaratorScreen extends HookConsumerWidget {
  const AIDocumentGenaratorScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            // Text(
            //   "Chọn loại tài liệu",
            //   style: TextStyle(
            //     fontSize: 22,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black87,
            //   ),
            // ),
            // Divider(height: 32, thickness: 1, color: Color(0xFFE6E6E6)),
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
            )
          ],
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
    return  Container(
          height: 130,
          width: 200,
          margin: const EdgeInsets.only(right: 8, top: 8, bottom: 8),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border:  Border.all(
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
