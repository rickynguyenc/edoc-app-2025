import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/utils/extension/object.dart';
import 'package:edoc_tabcom/core/utils/widgets/appbar_template_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/utils/widgets/text_field_widget.dart';

@RoutePage()
class CreateGroupScreen extends HookConsumerWidget {
  CreateGroupScreen({super.key});
  var paramPublic = PageLink(sorting: 'Lastest');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabController = useTabController(initialLength: 2);
    // final publicList = ref.watch(myDocumentProvider);
    // final categoryTree = ref.watch(categoryTreeProvider);
    final _groupName = useState('');
    final _groupNameFormKey = GlobalKey<FormState>();
    final _txtgroupNameCtrl = useTextEditingController();

    useEffect(() {
      return null;
    }, []);
    return LayoutEdoc(
      bodyWidget: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              height: 56,
              margin: EdgeInsets.only(top: 16),
              alignment: Alignment.centerLeft,
              child: Text(
                'Tạo mới nhóm quyền',
                style: TextStyle(
                  color: Color(0xFF243757),
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  letterSpacing: -0.30,
                ),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              child: TabBar(
                controller: tabController,
                labelColor: Color(0xFFEC1C23),
                unselectedLabelColor: Color(0xFF243757),
                indicatorColor: Color(0xFFEC1C23),
                onTap: (index) {
                  // Tab index when user select it, it start from zero
                },
                padding: EdgeInsets.zero,
                labelStyle: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.07,
                ),
                // unselectedLabelStyle: TextStyle(fontSize: 16, color: Color(0xFF243757), fontWeight: FontWeight.w600),
                tabs: [
                  Tab(
                    text: 'Thông tin chung',
                  ),
                  Tab(text: 'Người dùng'),
                ],
              ),
            ),
            SizedBox(height: 32),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  // First tab content
                  Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text('Tên nhóm ', style: TextStyle(color: Color(0xFF475569), fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.07)),
                            Text('*', style: TextStyle(color: Color(0xFFF43F5E), fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.07)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFieldWidget(
                        keyboardType: TextInputType.text,
                        formKey: _groupNameFormKey,
                        hintText: 'Tên nhóm',
                        onChanged: (value) => _groupName.value = value,
                        validateFunc: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Đây là trường bắt buộc!';
                          }
                          return null;
                        },
                        controller: _txtgroupNameCtrl,
                      ),
                    ],
                  ),
                  // Second tab content
                  Center(
                    child: Text(''),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF7A8699),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFF7A8699)),
                        borderRadius: BorderRadius.circular(45),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 24),
                    ),
                    onPressed: () {
                      context.router.pop();
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Hủy',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Container(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      backgroundColor: Color(0xFFEC1C23),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFEC1C23)),
                        borderRadius: BorderRadius.circular(45),
                      ),
                    ),
                    onPressed: () {
                      // isSaving.value = true;
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.save_alt_outlined,
                          color: Colors.white,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Lưu lại',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
