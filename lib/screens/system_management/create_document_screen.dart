import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:edoc_tabcom/core/utils/extension/object.dart';
import 'package:edoc_tabcom/core/utils/widgets/appbar_template_widget.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/extension/common_function.dart';
import '../../core/utils/widgets/loading_mark.dart';
import '../../core/utils/widgets/shimmer_loading/body_shimmer.dart';
import '../../core/utils/widgets/shimmer_loading/detail_document_shimmer.dart';
import '../../core/utils/widgets/text_field_widget.dart';
import '../../models/home_model.dart';
import '../../providers/home_provider.dart';
import '../../providers/my_document_provider.dart';

@RoutePage()
class CreateDocumentScreen extends HookConsumerWidget {
  CreateDocumentScreen({super.key});
  var paramPublic = PageLink(sorting: 'Lastest');
  final _fileNameFormKey = GlobalKey<FormState>();
  final _txtFileNameCtrl = TextEditingController();
  final _authorFormKey = GlobalKey<FormState>();
  final _txtAuthorCtrl = TextEditingController();
  final _noteFormKey = GlobalKey<FormState>();
  final _txtNoteCtrl = TextEditingController();
  Widget _customPopupItemBuilder(BuildContext context, CategoryTreeResonpse item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.label ?? ''),
      ),
    );
  }

  Widget _customDropDownPopupItemBuilder(BuildContext context, DropdownTree item, bool isSelected) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: !isSelected
          ? null
          : BoxDecoration(
              border: Border.all(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
            ),
      child: ListTile(
        selected: isSelected,
        title: Text(item.displayName ?? ''),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _fileName = useState('');
    final categoryTree = ref.watch(categoryTreeProvider);
    final organizationTree = ref.watch(organizationTreeProvider);
    final userTree = ref.watch(userTreeProvider);
    final userGroupTree = ref.watch(userGroupTreeProvider);
    final _categorySearchTextController = useTextEditingController();
    final categorySelected = useState<CategoryTreeResonpse?>(null);
    final _organizationSearchTextController = useTextEditingController();
    final organizationSelected = useState<DropdownTree?>(null);
    final _userSearchTextController = useTextEditingController();
    final userSelected = useState<DropdownTree?>(null);
    final _userGroupSearchTextController = useTextEditingController();
    final userGroupSelected = useState<DropdownTree?>(null);
    final fileMode = useState(0);

    final isLoading = useState(true);
    final isSaving = useState(false);
    final ValueNotifier<File?> thumbnailImage = useState(null);
    useEffect(() {
      Future.wait([
        ref.read(myDocumentProvider.notifier).getDesktopList(paramPublic),
        ref.read(categoryTreeProvider.notifier).getCategoryTree(),
        ref.read(organizationTreeProvider.notifier).getOrganiztionTree(),
        ref.read(userTreeProvider.notifier).getUserTree(),
        ref.read(userGroupTreeProvider.notifier).getUserGroupTree()
      ]).then((value) {
        isLoading.value = false;
      });
      return null;
    }, []);
    openPicker(ImageSource source, BuildContext ctx) async {
      // ignore: invalid_use_of_visible_for_testing_member
      try {
        final XFile? pickFile = await ImagePicker.platform.getImageFromSource(source: source);
        if (pickFile != null) {
          // final fileBytes = await pickFile.readAsBytes();
          thumbnailImage.value = File(pickFile.path);
          // final linkArr = res[0].split('/').sublist(3);
          // avatarUrl.value = '${Environment.apiUrl}/${linkArr[0]}/${linkArr[1]}/${linkArr[2]}';
          // user.avatar = '/${linkArr[0]}/${linkArr[1]}/${linkArr[2]}';
        }
      } catch (e) {
        // showCupertinoDialog(
        //   context: ctx,
        //   builder: (BuildContext context) {
        //     return CupertinoAlertDialog(
        //       title: const Text('Không được phép!'),
        //       content: Text('Bạn không có quyền truy cập ${source == ImageSource.camera ? 'Camera' : 'Ảnh'}. Vui lòng thay đổi trong cài đặt.'),
        //       actions: <Widget>[
        //         CupertinoDialogAction(
        //           child: const Text('Xác nhận'),
        //           onPressed: () {
        //             Navigator.of(context).pop();
        //           },
        //         ),
        //       ],
        //     );
        //   },
        // );
        CommonFunction.showSnackBar('Có lỗi xảy ra', context, Colors.red);
      }
    }

    return Stack(children: [
      LayoutEdoc(
        bodyWidget: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: isLoading.value
                ? DetailDocumentShimmer()
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 56,
                        margin: EdgeInsets.only(top: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Tạo mới tài liệu',
                          style: TextStyle(
                            color: Color(0xFF243757),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.30,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Text(
                        'Ảnh Đại diện tài liệu',
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.07,
                        ),
                      ),
                      SizedBox(height: 14),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Column(
                                children: [
                                  thumbnailImage.value == null
                                      ? SvgPicture.asset(
                                          'assets/icons/ic_file_upload.svg',
                                          width: 70,
                                        )
                                      : Image.file(
                                          thumbnailImage.value!,
                                          height: 70,
                                        ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Drop your files here or',
                                        style: TextStyle(
                                          color: Color(0xFF1F2937),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.08,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          openPicker(ImageSource.gallery, context);
                                        },
                                        child: Text(
                                          ' browse',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFF43F5E),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.08,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Kích thước ảnh khuyến nghị tỉ lệ dọc: 1:1,2',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF9CA3AF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.07,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 21),
                      Text(
                        'Upload tài liệu',
                        style: TextStyle(
                          color: Color(0xFF475569),
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.07,
                        ),
                      ),
                      SizedBox(height: 14),
                      Container(
                        child: Column(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 50, horizontal: 16),
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Column(
                                children: [
                                  // SvgPicture.asset(
                                  //   'assets/icons/ic_file_upload.svg',
                                  //   width: 70,
                                  // ),
                                  // SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Drop your files here or',
                                        style: TextStyle(
                                          color: Color(0xFF1F2937),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.08,
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () async {
                                          FilePickerResult? result = await FilePicker.platform.pickFiles();

                                          if (result != null) {
                                            File file = File(result.files.single.path!);
                                          } else {
                                            // User canceled the picker
                                          }
                                        },
                                        child: Text(
                                          ' browse',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xFFF43F5E),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.08,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Dung lượng file không quá 100MB',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF9CA3AF),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.07,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 29),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'THÔNG TIN TÀI LIỆU',
                          style: TextStyle(
                            color: Color(0xFF243757),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.38,
                          ),
                        ),
                      ),
                      SizedBox(height: 29),
                      Container(
                        child: Row(
                          children: [
                            Text('1.1 Tên file ', style: TextStyle(color: Color(0xFF475569), fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.07)),
                            Text('*', style: TextStyle(color: Color(0xFFF43F5E), fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.07)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFieldWidget(
                        keyboardType: TextInputType.text,
                        formKey: _fileNameFormKey,
                        hintText: 'Tên file',
                        onChanged: (value) => _fileName.value = value,
                        validateFunc: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Đây là trường bắt buộc!';
                          }
                          return null;
                        },
                        controller: _txtFileNameCtrl,
                      ),
                      SizedBox(height: 16),
                      Container(
                        child: Row(
                          children: [
                            Text('1.2 Tác giả ', style: TextStyle(color: Color(0xFF475569), fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.07)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      TextFieldWidget(
                        keyboardType: TextInputType.text,
                        formKey: _authorFormKey,
                        hintText: 'Tác giả',
                        onChanged: (value) {},
                        validateFunc: (value) {},
                        controller: _txtAuthorCtrl,
                      ),
                      SizedBox(height: 16),
                      Container(
                        child: Row(
                          children: [
                            Text('1.3 Danh mục ', style: TextStyle(color: Color(0xFF475569), fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.07)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        // margin: const EdgeInsets.all(16),
                        child: DropdownSearch<CategoryTreeResonpse>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              hintText: 'Chọn danh mục',
                              filled: true,
                              constraints: BoxConstraints(minHeight: 48, maxHeight: 60),
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                color: Color(0xff797882),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              // border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFF055FA7)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          filterFn: (item, filter) {
                            return item.label!.toLowerCase().contains(filter.toLowerCase());
                          },
                          selectedItem: categorySelected.value,
                          onChanged: (value) {},
                          dropdownBuilder: categorySelected.value != null
                              ? (context, item) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item!.label ?? '',
                                      style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5, fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }
                              : null,
                          clearButtonProps: ClearButtonProps(
                            icon: const Icon(
                              Icons.clear,
                            ),
                            color: Colors.white,
                            iconSize: 24,
                            isVisible: categorySelected.value != null,
                            onPressed: () {},
                          ),
                          dropdownButtonProps: const DropdownButtonProps(
                            isVisible: true,
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            iconSize: 24,
                            color: Color(0xFF475569),
                          ),
                          items: categoryTree,
                          compareFn: (i, s) => (i.label ?? '') == (s.label ?? ''),
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                            searchDelay: const Duration(milliseconds: 100),
                            loadingBuilder: (context, item) => const Loading(),
                            itemBuilder: _customPopupItemBuilder,
                            emptyBuilder: (context, searchEntry) {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: const Text(
                                  'Không có dữ liệu',
                                  style: TextStyle(color: Color(0xff797882), fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
                                ),
                              );
                            },
                            searchFieldProps: TextFieldProps(
                              controller: _categorySearchTextController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 12),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Color(0xff797882),
                                  ),
                                  onPressed: () {
                                    _categorySearchTextController.clear();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        child: Row(
                          children: [
                            Text('1.4 Danh sách tổ chức', style: TextStyle(color: Color(0xFF475569), fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.07)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        // margin: const EdgeInsets.all(16),
                        child: DropdownSearch<DropdownTree>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              hintText: 'Chọn tổ chức',
                              filled: true,
                              constraints: BoxConstraints(minHeight: 48, maxHeight: 60),
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                color: Color(0xff797882),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              // border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFF055FA7)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          filterFn: (item, filter) {
                            return item.displayName!.toLowerCase().contains(filter.toLowerCase());
                          },
                          selectedItem: organizationSelected.value,
                          onChanged: (value) {},
                          dropdownBuilder: organizationSelected.value != null
                              ? (context, item) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item!.displayName ?? '',
                                      style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5, fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }
                              : null,
                          clearButtonProps: ClearButtonProps(
                            icon: const Icon(
                              Icons.clear,
                            ),
                            color: Colors.white,
                            iconSize: 24,
                            isVisible: organizationSelected.value != null,
                            onPressed: () {},
                          ),
                          dropdownButtonProps: const DropdownButtonProps(
                            isVisible: true,
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            iconSize: 24,
                            color: Color(0xFF475569),
                          ),
                          items: organizationTree,
                          compareFn: (i, s) => (i.displayName ?? '') == (s.displayName ?? ''),
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                            searchDelay: const Duration(milliseconds: 100),
                            loadingBuilder: (context, item) => const Loading(),
                            itemBuilder: _customDropDownPopupItemBuilder,
                            emptyBuilder: (context, searchEntry) {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: const Text(
                                  'Không có dữ liệu',
                                  style: TextStyle(color: Color(0xff797882), fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
                                ),
                              );
                            },
                            searchFieldProps: TextFieldProps(
                              controller: _organizationSearchTextController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 12),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Color(0xff797882),
                                  ),
                                  onPressed: () {
                                    _organizationSearchTextController.clear();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 29),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'ĐỐI TƯỢNG CHIA SẺ',
                          style: TextStyle(
                            color: Color(0xFF243757),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.38,
                          ),
                        ),
                      ),
                      SizedBox(height: 29),
                      Container(
                        child: Row(
                          children: [
                            Text('Chia sẻ cá nhân', style: TextStyle(color: Color(0xFF475569), fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.07)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        // margin: const EdgeInsets.all(16),
                        child: DropdownSearch<DropdownTree>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              hintText: 'Chọn cá nhân chia sẻ',
                              filled: true,
                              constraints: BoxConstraints(minHeight: 48, maxHeight: 60),
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                color: Color(0xff797882),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              // border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFF055FA7)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          filterFn: (item, filter) {
                            return item.displayName!.toLowerCase().contains(filter.toLowerCase());
                          },
                          selectedItem: userSelected.value,
                          onChanged: (value) {},
                          dropdownBuilder: userSelected.value != null
                              ? (context, item) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item!.displayName ?? '',
                                      style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5, fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }
                              : null,
                          clearButtonProps: ClearButtonProps(
                            icon: const Icon(
                              Icons.clear,
                            ),
                            color: Colors.white,
                            iconSize: 24,
                            isVisible: userSelected.value != null,
                            onPressed: () {},
                          ),
                          dropdownButtonProps: const DropdownButtonProps(
                            isVisible: true,
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            iconSize: 24,
                            color: Color(0xFF475569),
                          ),
                          items: userTree,
                          compareFn: (i, s) => (i.displayName ?? '') == (s.displayName ?? ''),
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                            searchDelay: const Duration(milliseconds: 100),
                            loadingBuilder: (context, item) => const Loading(),
                            itemBuilder: _customDropDownPopupItemBuilder,
                            emptyBuilder: (context, searchEntry) {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: const Text(
                                  'Không có dữ liệu',
                                  style: TextStyle(color: Color(0xff797882), fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
                                ),
                              );
                            },
                            searchFieldProps: TextFieldProps(
                              controller: _userSearchTextController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 12),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Color(0xff797882),
                                  ),
                                  onPressed: () {
                                    _userSearchTextController.clear();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        child: Row(
                          children: [
                            Text('Chia sẻ nhóm', style: TextStyle(color: Color(0xFF475569), fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.07)),
                          ],
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        alignment: Alignment.center,
                        height: 60,
                        // margin: const EdgeInsets.all(16),
                        child: DropdownSearch<DropdownTree>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                              hintText: 'Chọn nhóm chia sẻ',
                              filled: true,
                              constraints: BoxConstraints(minHeight: 48, maxHeight: 60),
                              fillColor: Colors.white,
                              hintStyle: const TextStyle(
                                color: Color(0xff797882),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              // border: InputBorder.none,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFF055FA7)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          filterFn: (item, filter) {
                            return item.displayName!.toLowerCase().contains(filter.toLowerCase());
                          },
                          selectedItem: userGroupSelected.value,
                          onChanged: (value) {},
                          dropdownBuilder: userGroupSelected.value != null
                              ? (context, item) {
                                  return Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      item!.displayName ?? '',
                                      style: const TextStyle(color: Colors.white, fontSize: 14, height: 1.5, fontWeight: FontWeight.w500),
                                    ),
                                  );
                                }
                              : null,
                          clearButtonProps: ClearButtonProps(
                            icon: const Icon(
                              Icons.clear,
                            ),
                            color: Colors.white,
                            iconSize: 24,
                            isVisible: userGroupSelected.value != null,
                            onPressed: () {},
                          ),
                          dropdownButtonProps: const DropdownButtonProps(
                            isVisible: true,
                            icon: Icon(Icons.keyboard_arrow_down_outlined),
                            iconSize: 24,
                            color: Color(0xFF475569),
                          ),
                          items: userGroupTree,
                          compareFn: (i, s) => (i.displayName ?? '') == (s.displayName ?? ''),
                          popupProps: PopupProps.menu(
                            showSelectedItems: true,
                            showSearchBox: true,
                            searchDelay: const Duration(milliseconds: 100),
                            loadingBuilder: (context, item) => const Loading(),
                            itemBuilder: _customDropDownPopupItemBuilder,
                            emptyBuilder: (context, searchEntry) {
                              return Container(
                                alignment: Alignment.center,
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                child: const Text(
                                  'Không có dữ liệu',
                                  style: TextStyle(color: Color(0xff797882), fontSize: 16, height: 1.5, fontWeight: FontWeight.w400),
                                ),
                              );
                            },
                            searchFieldProps: TextFieldProps(
                              controller: _userGroupSearchTextController,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 12, top: 0, bottom: 0, right: 12),
                                border: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                // border: InputBorder.none,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: Color(0xffE4E4E6)),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.clear,
                                    color: Color(0xff797882),
                                  ),
                                  onPressed: () {
                                    _userGroupSearchTextController.clear();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 29),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'CHÚ THÍCH',
                          style: TextStyle(
                            color: Color(0xFF243757),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.38,
                          ),
                        ),
                      ),
                      SizedBox(height: 29),
                      Form(
                        key: _noteFormKey,
                        child: TextFormField(
                          controller: _txtNoteCtrl,
                          minLines: 5,
                          maxLines: 12,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            filled: true,
                            hintStyle: TextStyle(color: Color.fromRGBO(165, 165, 171, 1)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(width: 1, color: Color(0xFF055FA7)),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(
                                width: 1,
                                style: BorderStyle.none,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(width: 1, color: Color(0xFFC2C7D0)),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6)),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Color.fromRGBO(234, 84, 85, 1),
                                )),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              borderSide: BorderSide(
                                width: 1,
                                color: Color.fromRGBO(234, 84, 85, 1),
                              ),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                        ),
                      ),
                      SizedBox(height: 29),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'CHẾ ĐỘ',
                          style: TextStyle(
                            color: Color(0xFF243757),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 2.38,
                          ),
                        ),
                      ),
                      SizedBox(height: 29),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                fileMode.value = 0;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                clipBehavior: Clip.antiAlias,
                                decoration: ShapeDecoration(
                                  color: fileMode.value == 0 ? Color(0xFFEC1C23) : Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(6),
                                        bottomLeft: Radius.circular(6),
                                      ),
                                      side: BorderSide(
                                        width: 1,
                                        color: fileMode.value == 0 ? Color(0xFFEC1C23) : Color(0xFF6B788E),
                                      )),
                                ),
                                child: Text(
                                  'Công khai',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: fileMode.value == 0 ? Colors.white : Color(0xFF6B788E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.07,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                fileMode.value = 1;
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: fileMode.value == 1 ? Color(0xFFEC1C23) : Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(6),
                                    bottomRight: Radius.circular(6),
                                  ),
                                  border: Border(
                                    left: BorderSide(color: fileMode.value == 1 ? Color(0xFFEC1C23) : Color(0xFF6B788E)),
                                    top: BorderSide(width: 1, color: fileMode.value == 1 ? Color(0xFFEC1C23) : Color(0xFF6B788E)),
                                    right: BorderSide(width: 1, color: fileMode.value == 1 ? Color(0xFFEC1C23) : Color(0xFF6B788E)),
                                    bottom: BorderSide(width: 1, color: fileMode.value == 1 ? Color(0xFFEC1C23) : Color(0xFF6B788E)),
                                  ),
                                ),
                                child: Text(
                                  'Riêng tư',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: fileMode.value == 1 ? Colors.white : Color(0xFF6B788E),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.07,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
                                isSaving.value = true;
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
        ),
      ),
      isSaving.value ? Loading() : const SizedBox.shrink(),
    ]);
  }
}
