import 'dart:async';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/utils/widgets/appbar_template_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/loading_mark.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import '../../providers/detail_document_provider.dart';

@RoutePage()
class ViewPdfFileScreen extends HookConsumerWidget {
  final List<int> filePath;
  final String idFile;

  ViewPdfFileScreen(this.filePath, this.idFile);
  late PDFViewController _pdfViewController;
  int _totalPages = 0;
  int _currentPage = 0;
  final Completer<PDFViewController> _controllerPdf = Completer<PDFViewController>();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);
    final ValueNotifier<File?> _filePdf = useState(null);
    final ValueNotifier<String?> errorText = useState(null);
    final _currentPage = useState(0);
    final _totalPages = useState(0);
    Future<void> _createPdfFile(List<int> fileInput) async {
      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/$idFile.pdf');
      await file.writeAsBytes(fileInput);
      _filePdf.value = file;
      isLoading.value = false;
      // await OpenFile.open('${tempDir.path}/3a0fe5e2-e5df-e5a9-b844-787b76c862a1.pdf');
    }

    useEffect(() {
      ref.read(detailDocumentProvider.notifier).downloadDocument(idFile).then((value) {
        if (value != null) {
          errorText.value = null;
          _createPdfFile(value);
        } else {
          errorText.value = 'Không thể tải file';
          isLoading.value = false;
        }
      }).catchError((e) {
        errorText.value = 'Không thể tải file';
        isLoading.value = false;
      });
      return () {};
    }, []);
    return Stack(
      children: [
        LayoutEdoc(
          bodyWidget: isLoading.value
              ? Center(
                  child: Container(),
                )
              : errorText.value != null
                  ? Center(
                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                        Text(
                          errorText.value ?? '',
                          style: TextStyle(color: Colors.red, fontSize: 18),
                        ),
                        TextButton(
                          onPressed: () {
                            isLoading.value = true;
                            ref.read(detailDocumentProvider.notifier).downloadDocument(idFile).then((value) {
                              if (value != null) {
                                errorText.value = null;
                                _createPdfFile(value);
                              } else {
                                errorText.value = '! Không thể tải file';
                                isLoading.value = false;
                              }
                            }).catchError((e) {
                              errorText.value = '! Không thể tải file';
                              isLoading.value = false;
                            });
                          },
                          child: Text('Tải lại'),
                        )
                      ]),
                    )
                  : Column(
                      children: [
                        Expanded(
                          child: PDFView(
                            // fitEachPage: true,
                            onPageError: (page, error) {
                              print('$page: ${error.description}');
                            },
                            filePath: _filePdf.value?.path ?? '',
                            onViewCreated: (PDFViewController pdfViewController) async {
                              _controllerPdf.complete(pdfViewController);
                              _totalPages.value = await pdfViewController.getPageCount() ?? 0;
                            },
                            onPageChanged: (page, total) {
                              _currentPage.value = page ?? 0;
                              _totalPages.value = total ?? 0;
                            },

                            // Other PDFView properties
                          ),
                        ),
                        if (_totalPages.value > 0)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.arrow_back),
                                  onPressed: () async {
                                    final pdfViewController = await _controllerPdf.future;
                                    if (_currentPage.value > 0) {
                                      _currentPage.value--;
                                      pdfViewController.setPage(_currentPage.value);
                                    }
                                  },
                                ),
                                Text('Page ${_currentPage.value + 1} of ${_totalPages.value}'),
                                IconButton(
                                  icon: Icon(Icons.arrow_forward),
                                  onPressed: () async {
                                    final pdfViewController = await _controllerPdf.future;
                                    if (_currentPage.value < _totalPages.value - 1) {
                                      _currentPage.value++;
                                      pdfViewController.setPage(_currentPage.value);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
        ),
        isLoading.value ? Loading() : SizedBox.shrink(),
        Positioned(
          top: 100, // Adjust the position based on your layout
          left: 20, // Adjust the position based on your layout
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              icon: Icon(Icons.close, color: Colors.black), // Adjust color as needed
              onPressed: () {
                context.router.pop();
              },
            ),
          ),
        ),
      ],
    );
  }
}
