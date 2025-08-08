import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/utils/extension/common_function.dart';
import 'package:edoc_tabcom/core/utils/widgets/appbar_template_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/submit_button_widget.dart';
import 'package:edoc_tabcom/providers/account_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/utils/widgets/loading_mark.dart';
import '../../core/utils/widgets/text_field_widget.dart';
import '../../models/account_model.dart';
import '../../providers/authentication_provider.dart';

@RoutePage()
class PersonalViewScreen extends HookConsumerWidget {
  PersonalViewScreen({super.key});
  final _tenHienThiFormKey = GlobalKey<FormState>();
  final _txtTenHienThiCtrl = TextEditingController();
  final _tenTkFormKey = GlobalKey<FormState>();
  final _txtTenTkCtrl = TextEditingController();
  final _emailFormKey = GlobalKey<FormState>();
  final _txtEmailCtrl = TextEditingController();
  final _sdtFormKey = GlobalKey<FormState>();
  final _txtSdtCtrl = TextEditingController();
  final _diaChiFormKey = GlobalKey<FormState>();
  final _txtDiaChiCtrl = TextEditingController();
  final _congviecFormKey = GlobalKey<FormState>();
  final _txtCongViecCtrl = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userInfor = ref.watch(accountProvider);
    final isUpdating = useState(false);
    final avatarUrl = useState('');
    final ValueNotifier<File?> pickedImage = useState(null);
    useEffect(() {
      ref.read(accountProvider.notifier).getUserInfor().then((v) {
        final thongtinNguoiDung = ref.read(accountProvider);
        _txtTenHienThiCtrl.text = thongtinNguoiDung.fullName ?? '';
        _txtTenTkCtrl.text = thongtinNguoiDung.name ?? '';
        _txtEmailCtrl.text = thongtinNguoiDung.email ?? '';
        _txtSdtCtrl.text = thongtinNguoiDung.phoneNumber ?? '';
        _txtDiaChiCtrl.text = thongtinNguoiDung.address ?? '';
        _txtCongViecCtrl.text = thongtinNguoiDung.jobPosition ?? '';
        avatarUrl.value = thongtinNguoiDung.avatar ?? '';
      });
      return null;
    }, []);

    OpenPicker(ImageSource source, BuildContext ctx) async {
      // ignore: invalid_use_of_visible_for_testing_member
      try {
        final XFile? pickFile =
            await ImagePicker.platform.getImageFromSource(source: source);
        if (pickFile != null) {
          // final fileBytes = await pickFile.readAsBytes();
          pickedImage.value = File(pickFile.path);
          final res = await ref
              .read(accountProvider.notifier)
              .upLoadIamge(pickedImage.value!);
          avatarUrl.value = res[0].replaceFirst('/app/wwwroot', '');
          // final linkArr = res[0].split('/').sublist(3);
          // avatarUrl.value = '${Environment.apiUrl}/${linkArr[0]}/${linkArr[1]}/${linkArr[2]}';
          // user.avatar = '/${linkArr[0]}/${linkArr[1]}/${linkArr[2]}';
        }
        Navigator.of(context).pop();
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

    return Stack(
      children: [
        LayoutEdoc(
          bodyWidget: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 16,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Color(0xFFE6E6E6),
                            ),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: 135,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    topRight: Radius.circular(8),
                                  ),
                                  image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/banner_profile.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Container(
                                height: 95,
                                width: double.infinity,
                                padding: EdgeInsets.only(left: 136),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      userInfor.fullName ?? '',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      'eDocument',
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color(0xFF243757)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 20,
                          bottom: 45,
                          child: Stack(
                            children: [
                              Container(
                                  width: 100,
                                  height: 100,
                                  child: pickedImage.value == null
                                      ? CircleAvatar(
                                          backgroundImage: NetworkImage(
                                            '${Environment.apiUrl}${avatarUrl.value}',
                                          ), // Your avatar image
                                        )
                                      : CircleAvatar(
                                          backgroundImage:
                                              FileImage(pickedImage.value!),
                                        )),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                          shape: const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(24),
                                                  topRight:
                                                      Radius.circular(24))),
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.white,
                                          builder: (context) {
                                            return SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  Stack(children: [
                                                    Container(
                                                      alignment:
                                                          Alignment.center,
                                                      width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                      height: 52,
                                                      child: const Text(
                                                        'Thay ảnh đại diện',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0.0,
                                                      left: 0.0,
                                                      child: IconButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        icon: const Icon(
                                                            Icons
                                                                .clear_outlined,
                                                            size: 20,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ]),
                                                  const Divider(
                                                    height: 1,
                                                  ),
                                                  Container(
                                                    height: 178,
                                                    color: Colors.white,
                                                    child: Column(children: [
                                                      ListTile(
                                                        title: const Text(
                                                            "Chụp ảnh bằng camera"),
                                                        onTap: () {
                                                          print(
                                                              'Chụp ảnh bằng camera');
                                                          OpenPicker(
                                                              ImageSource
                                                                  .camera,
                                                              context);
                                                        },
                                                      ),
                                                      const Divider(
                                                        height: 1,
                                                        thickness: 1,
                                                      ),
                                                      ListTile(
                                                        title: const Text(
                                                            "Chọn từ thư viện ảnh"),
                                                        onTap: () {
                                                          OpenPicker(
                                                              ImageSource
                                                                  .gallery,
                                                              context);
                                                        },
                                                      ),
                                                    ]),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      width: 100,
                                      height: 38,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(80),
                                          bottomRight: Radius.circular(80),
                                        ),
                                        color: Colors.transparent,

                                        // color: Color(0xA01C1C1C),
                                        // borderRadius: BorderRadius.all(Radius.circular(100)),
                                      ),
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
                                        size: 19,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      height: 56,
                      margin: EdgeInsets.only(top: 16),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Thông tin cá nhân',
                        style: TextStyle(
                          color: Color(0xFF243757),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.30,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('Tên hiển thị',
                              style: TextStyle(
                                  color: Color(0xFF475569),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.07)),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      formKey: _tenHienThiFormKey,
                      hintText: 'Tên hiển thị',
                      onChanged: (value) {},
                      validateFunc: (value) {},
                      controller: _txtTenHienThiCtrl,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('Tên tài khoản',
                              style: TextStyle(
                                  color: Color(0xFF475569),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.07)),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      formKey: _tenTkFormKey,
                      hintText: 'Tên tài khoản',
                      onChanged: (value) {},
                      validateFunc: (value) {},
                      controller: _txtTenTkCtrl,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('Địa chỉ email *',
                              style: TextStyle(
                                  color: Color(0xFF475569),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.07)),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      formKey: _emailFormKey,
                      hintText: 'Email',
                      onChanged: (value) {},
                      validateFunc: (value) {},
                      controller: _txtEmailCtrl,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('Số điện thoại',
                              style: TextStyle(
                                  color: Color(0xFF475569),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.07)),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      formKey: _sdtFormKey,
                      hintText: 'Số điện thoại',
                      onChanged: (value) {},
                      validateFunc: (value) {},
                      controller: _txtSdtCtrl,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('Địa chỉ',
                              style: TextStyle(
                                  color: Color(0xFF475569),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.07)),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      formKey: _diaChiFormKey,
                      hintText: 'Địa chỉ',
                      onChanged: (value) {},
                      validateFunc: (value) {},
                      controller: _txtDiaChiCtrl,
                    ),
                    SizedBox(
                      height: 12,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text('Công việc',
                              style: TextStyle(
                                  color: Color(0xFF475569),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.07)),
                        ],
                      ),
                    ),
                    SizedBox(height: 12),
                    TextFieldWidget(
                      keyboardType: TextInputType.text,
                      formKey: _congviecFormKey,
                      hintText: 'Công việc',
                      onChanged: (value) {},
                      validateFunc: (value) {},
                      controller: _txtCongViecCtrl,
                    ),
                    SizedBox(
                      height: 48,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              backgroundColor: Color(0xFFEC1C23),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFFEC1C23)),
                                borderRadius: BorderRadius.circular(45),
                              ),
                            ),
                            onPressed: () {
                              isUpdating.value = true;
                              final userInforDTO = UserInforDTO(
                                avatar: avatarUrl.value,
                                email: _txtEmailCtrl.text,
                                fullName: _txtTenHienThiCtrl.text,
                                address: _txtDiaChiCtrl.text,
                                jobPosition: _txtCongViecCtrl.text,
                                phoneNumber: _txtSdtCtrl.text,
                                name: _txtTenTkCtrl.text,
                                status: userInfor.status,
                                accountType: userInfor.accountType,
                                roleIds: userInfor.roleIds,
                                roleNames: userInfor.roleNames,
                                organizationId: userInfor.organizationId,
                              );
                              ref
                                  .read(accountProvider.notifier)
                                  .updateUserInfor(userInforDTO)
                                  .then(
                                (value) {
                                  isUpdating.value = false;
                                  if (value) {
                                    CommonFunction.showSnackBar(
                                        'Cập nhật thành công',
                                        context,
                                        Colors.green);
                                  } else {
                                    CommonFunction.showSnackBar(
                                        'Cập nhật thất bại',
                                        context,
                                        Colors.red);
                                  }
                                },
                              );
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
                                  'Cập nhật',
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
                        SizedBox(
                          width: 16,
                        ),
                        Container(
                          height: 48,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(horizontal: 24),
                              backgroundColor: Color(0xFFEC1C23),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    width: 1, color: Color(0xFFEC1C23)),
                                borderRadius: BorderRadius.circular(45),
                              ),
                            ),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Xác nhận'),
                                      content: const Text(
                                          'Bạn có chắc chắn muốn xóa tài khoản?'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('Hủy'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            ref
                                                .read(authProvider)
                                                .deleteAccount()
                                                .then((value) {
                                              if (value) {
                                                CommonFunction.showSnackBar(
                                                    'Xóa tài khoản thành công',
                                                    context,
                                                    Colors.green);
                                                context.router
                                                    .replaceAll([LoginRoute()]);
                                              } else {
                                                CommonFunction.showSnackBar(
                                                    'Xóa tài khoản thất bại',
                                                    context,
                                                    Colors.red);
                                              }
                                            });
                                          },
                                          child: const Text('Xác nhận'),
                                        ),
                                      ],
                                    );
                                  });
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.delete_outline,
                                  color: Colors.white,
                                  size: 16,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Xóa tài khoản',
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
                      ],
                    ),
                    SizedBox(
                      height: 24,
                    ),
                  ]),
            ),
          ),
        ),
        isUpdating.value ? Loading() : const SizedBox.shrink(),
      ],
    );
  }
}
