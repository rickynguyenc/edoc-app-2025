import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/app_dio.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:edoc_tabcom/core/utils/extension/common_function.dart';
import 'package:edoc_tabcom/core/utils/widgets/appbar_template_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/loading_mark.dart';
import 'package:edoc_tabcom/core/utils/widgets/shimmer_loading/common_simmer.dart';
import 'package:edoc_tabcom/models/detail_document_model.dart';
import 'package:edoc_tabcom/providers/account_provider.dart';
import 'package:edoc_tabcom/providers/detail_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/utils/widgets/shimmer_loading/body_shimmer.dart';
import '../../core/utils/widgets/shimmer_loading/detail_document_shimmer.dart';

@RoutePage()
class DetailDocumentScreen extends HookConsumerWidget {
  final String id;
  DetailDocumentScreen(this.id, {super.key});
  final TextEditingController _commentTextController = TextEditingController();
  File? filePdf;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);
    final detailDoc = ref.watch(detailDocumentProvider);
    final lstComment = ref.watch(commentProvider);
    final userInfor = ref.watch(accountProvider);
    final isRequesting = useState(false);
    useEffect(() {
      Future.wait([ref.read(detailDocumentProvider.notifier).getDetailDocument(id), ref.read(commentProvider.notifier).getComment(id)]).then((value) {
        isLoading.value = false;
      });
      return null;
    }, []);
    return LayoutEdoc(
      bodyWidget: Container(
        padding: EdgeInsets.all(16),
        color: Color(0xfffafafa),
        child: SingleChildScrollView(
          child: isLoading.value
              ? DetailDocumentShimmer()
              : Column(children: [
                  AspectRatio(
                    aspectRatio: 0.78,
                    child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Image.network(
                        '${Environment.apiUrl}/${detailDoc.avatarUrl}',
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                          return Image(
                            image: AssetImage('assets/images/images_default.png'),
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          detailDoc.fileName ?? '',
                          style: TextStyle(
                            color: Color(0xFF243757),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text('Author: ',
                                style: TextStyle(
                                  color: Color(0xFF5D6B82),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                )),
                            Text(
                              detailDoc.author ?? '',
                              style: TextStyle(
                                color: Color(0xFF243757),
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              ref.read(detailDocumentProvider.notifier).addToWishList(id);
                            },
                            child: Row(
                              children: [
                                Icon(
                                  detailDoc.isLike == true ? Icons.favorite_outlined : Icons.favorite_border_outlined,
                                  size: 16,
                                  color: Color(0xFF64748B),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Add to wishlist',
                                  style: TextStyle(
                                    color: Color(0xFF243757),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return SafeArea(
                                    child: Container(
                                        height: 200,
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.all(0),
                                        child: Dialog(
                                            alignment: Alignment.center,
                                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                                            child: Container(
                                              padding: EdgeInsets.all(15),
                                              child: QrImageView(
                                                data: "https://edoc.tabcom.vn/my-document/$id", // Replace with your actual data
                                                version: QrVersions.auto,
                                                // size: 200.0,
                                              ),
                                            ))),
                                  );
                                },
                              );
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.qr_code,
                                  size: 16,
                                  color: Color(0xFF64748B),
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Get QR',
                                  style: TextStyle(
                                    color: Color(0xFF243757),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Color(0xFFE6E6E6),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          'Ngày đăng: ${detailDoc.createDate ?? ''}',
                          style: TextStyle(
                            color: Color(0xFF444444),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Trạng thái: ${detailDoc.lastestUserUpdate == null || detailDoc.lastestUserUpdate == '' ? 'Chưa có cập nhật mới' : detailDoc.lastestUserUpdate}',
                          style: TextStyle(
                            color: Color(0xFF444444),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                        Text(
                          detailDoc.description ?? '',
                          style: TextStyle(
                            color: Color(0xFF444444),
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Color(0xFFE6E6E6),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(children: [
                          Expanded(
                            flex: 5,
                            child: Container(
                              // height: 42,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFEC1C23),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39.31),
                                  ),
                                  minimumSize: Size(32, 32),
                                  padding: const EdgeInsets.symmetric( vertical: 13.36),
                                ),
                                onPressed: () {
                                  if (isRequesting.value) return;
                                  isRequesting.value = true;
                                  ref.read(detailDocumentProvider.notifier).downloadDocument(id).then((value) async {
                                    if (value != null) {
                                      if (Platform.isAndroid) {
                                        final tempDir = await getExternalStorageDirectory();
                                        final file = File('/storage/emulated/0/Download/$id.pdf');
                                        await file.writeAsBytes(value);
                                        isRequesting.value = false;
                                        CommonFunction.showSnackBar('Downloaded successfully', context, Colors.green);
                                      } else {
                                        Directory documents = await getApplicationDocumentsDirectory();
                                        final file = File('${documents.path}/$id.pdf');
                                        await file.writeAsBytes(value);
                                        isRequesting.value = false;
                                        CommonFunction.showSnackBar('Downloaded successfully', context, Colors.green);
                                      }
                                    } else {
                                      isRequesting.value = false;
                                      CommonFunction.showSnackBar('Download failed', context, Colors.red);
                                    }
                                  }).catchError((e) {
                                    isRequesting.value = false;
                                    CommonFunction.showSnackBar('Download failed', context, Colors.red);
                                  });
//                                   String downloadUrl = '${Environment.apiUrl}${detailDoc.downloadUrl}';
// String savePath = '/storage/emulated/0/Download/$id.pdf';
//                                   ref.read(detailDocumentProvider.notifier).downloadFile()
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    isRequesting.value
                                        ? Container(
                                            height: 14,
                                            width: 14,
                                            child: CircularProgressIndicator(
                                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                            ),
                                          )
                                        : Icon(
                                            Icons.download_outlined,
                                            size: 14,
                                            color: Colors.white,
                                          ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      isRequesting.value ? 'Downloading' : 'Download',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                              // height: 42,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFC6C6C6),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39.31),
                                  ),
                                  minimumSize: Size(32, 32),
                                  padding: const EdgeInsets.symmetric( vertical: 13.36),
                                ),
                                onPressed: () async {
                                  context.router.push(ViewPdfFileRoute(filePath: [], idFile: id));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.remove_red_eye_outlined,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 8,
                                    ),
                                    Text(
                                      'Xem trước',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        
                          SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            flex: 3,
                            child: Container(
                              // height: 42,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color.fromARGB(255, 36, 204, 2),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(39.31),
                                  ),
                                  minimumSize: Size(32, 32),
                                  padding: const EdgeInsets.symmetric( vertical: 13.36),
                                ),
                                onPressed: () async {
                                  context.router.push(AichatbotRoute(fileId: id));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.support_agent_outlined,
                                      size: 14,
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 2,
                                    ),
                                    Text(
                                      'Hỏi AI',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        
                        ]),
                        SizedBox(
                          height: 16,
                        ),
                        Container(
                          height: 1,
                          width: double.infinity,
                          color: Color(0xFFE6E6E6),
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Row(
                          children: [
                            Text('Categories: ',
                                style: TextStyle(
                                  color: Color(0xFF5D6B82),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
                                )),
                            Text(
                              detailDoc.categoryName ?? '',
                              style: TextStyle(
                                color: Color(0xFF243757),
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Container(
                              child: IconButton(
                                onPressed: () async {
                                  final url = Uri.parse("https://www.facebook.com/sharer/sharer.php?u=https://edoc.tabcom.vn/my-document/$id");

                                  launchUrl(
                                    url,
                                  );
                                },
                                alignment: Alignment.center,
                                style: ButtonStyle(
                                  backgroundColor: WidgetStateProperty.all(Color(0xFF3B5998)),
                                  padding: WidgetStateProperty.all(EdgeInsets.all(8)),
                                  shape: WidgetStateProperty.all(CircleBorder()),
                                  minimumSize: WidgetStateProperty.all(Size(32, 32)),
                                ),
                                icon: Icon(Icons.facebook, color: Colors.blue, size: 32),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              onPressed: () {
                                // share on email
                                final url = Uri.parse("mailto:?subject=Check out this document&body=https://edoc.tabcom.vn/my-document/$id");
                                launchUrl(url);
                              },
                              alignment: Alignment.center,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Colors.grey.shade400),
                                padding: WidgetStateProperty.all(EdgeInsets.all(8)),
                                shape: WidgetStateProperty.all(CircleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                )),
                                minimumSize: WidgetStateProperty.all(Size(32, 32)),
                              ),
                              icon: Icon(Icons.email_outlined, color: Colors.white, size: 32),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              onPressed: () {
                                final url = Uri.parse("https://www.viber://forward?text=Tài liệu chia sẻ với bạn https://edoc.tabcom.vn/my-document/$id");
                                launchUrl(url);
                              },
                              alignment: Alignment.center,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Color.fromARGB(255, 122, 11, 102)),
                                padding: WidgetStateProperty.all(EdgeInsets.all(8)),
                                shape: WidgetStateProperty.all(CircleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                )),
                                minimumSize: WidgetStateProperty.all(Size(32, 32)),
                              ),
                              icon: Icon(Icons.phone_in_talk, color: Colors.white, size: 32),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            IconButton(
                              onPressed: () {
                                String documentUrl = "https://edoc.tabcom.vn/my-document/$id";
                                Clipboard.setData(ClipboardData(text: documentUrl)).then((_) {
                                  // Optionally, show a message that the URL has been copied.
                                  // You can use a SnackBar for a simple feedback message.
                                  CommonFunction.showSnackBar('Link copied to clipboard', context, Colors.green);
                                });
                              },
                              alignment: Alignment.center,
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(Color(0xFF00ACEE)),
                                padding: WidgetStateProperty.all(EdgeInsets.all(8)),
                                shape: WidgetStateProperty.all(CircleBorder(
                                  side: BorderSide(
                                    color: Colors.grey.shade300,
                                    width: 1,
                                  ),
                                )),
                                minimumSize: WidgetStateProperty.all(Size(32, 32)),
                              ),
                              icon: Icon(Icons.copy_all, color: Colors.white, size: 32),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Color(0xFFEC1C23), width: 1)),
                        ),
                        child: Text(
                          'Bình luận',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Color(0xFF5E5E5E), fontSize: 14, fontWeight: FontWeight.w600, height: 1.5),
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.sync_outlined,
                        color: Color(0xFF243757),
                      ),
                      TextButton(
                        onPressed: () {
                          ref.read(commentProvider.notifier).getComment(id);
                        },
                        child: Text(
                          'Cập nhật bình luận',
                          style: TextStyle(
                            color: Color(0xFF243757),
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFE6E6E6)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                // radius: 16,
                                child: Image.network(
                                  '${Environment.apiUrl}${userInfor.avatar}',
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset('assets/images/images_default.png', fit: BoxFit.cover);
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: TextFormField(
                                controller: _commentTextController,
                                textInputAction: TextInputAction.newline,
                                minLines: 3,
                                maxLines: 5,
                                decoration: InputDecoration(
                                  suffix: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        final commentDto = CommentDto(content: _commentTextController.text, fileId: id, level: 0);
                                        ref.read(commentProvider.notifier).postComment(commentDto).then((value) {
                                          ref.read(commentProvider.notifier).getComment(id);
                                          _commentTextController.clear();
                                        });
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.send,
                                          color: Color(0xFF64748B),
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                  hintText: 'Viết bình luận...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      color: Color(0xFFE6E6E6),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        ...lstComment
                            .map((e) => Container(
                                  // margin: EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 32,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(16),
                                          // radius: 16,
                                          child: Image.network(
                                            '${Environment.apiUrl}${userInfor.avatar}',
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset('assets/images/images_default.png', fit: BoxFit.cover);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Expanded(
                                        child: ListTile(
                                          title: Text(
                                            e.studentName ?? '',
                                            style: TextStyle(
                                              color: Color(0xFF243757),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          subtitle: Text(
                                            e.content ?? '',
                                            style: TextStyle(
                                              color: Color(0xFF666666),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ))
                            .toList()
                      ],
                    ),
                  ),
                ]),
        ),
      ),
    );
  }
}
