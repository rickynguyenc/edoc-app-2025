import 'package:auto_route/auto_route.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/extension/common_function.dart';
import 'package:edoc_tabcom/core/utils/extension/object.dart';
import 'package:edoc_tabcom/core/utils/widgets/appbar_template_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/search_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/submit_button_widget.dart';
import 'package:edoc_tabcom/models/group_management_model.dart';
import 'package:edoc_tabcom/providers/group_management_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/core.dart';
import '../../core/utils/widgets/create_button_widget.dart';
import '../../core/utils/widgets/shimmer_loading/common_simmer.dart';
import '../../core/utils/widgets/shimmer_loading/data_grid_shimmer.dart';
import '../../models/group_management_model.dart';
import '../../providers/group_management_provider.dart';
import '../../services/system_management_service.dart';

@RoutePage()
class GroupManagementScreen extends HookConsumerWidget {
  GroupManagementScreen({super.key});
  var paramPublic = PageLink2();
  final DataGridController _dataGridController = DataGridController();
  final DataPagerController _dataPageController = DataPagerController();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = useState(true);
    final lstGroupManage = ref.watch(groupManagementProvider);
    final isCheckAll = useState(false);
    final totalResult = useState(10);
    final selectedPageNumber = useState(0);
    // final categoryTree = ref.watch(categoryTreeProvider);
    final _gridColumn = <GridColumn>[
      GridColumn(
        columnName: 'select',
        label: Container(
            width: 30,
            // padding: EdgeInsets.only(left: 16.0),
            alignment: Alignment.center,
            child: Checkbox(
              value: isCheckAll.value,
              onChanged: (value) {
                isCheckAll.value = value!;
                ref.read(groupManagementProvider.notifier).selectAllGroupElement(value);
              },
            )),
      ),
      GridColumn(
        columnName: 'stt',
        label: Container(
          width: 60,
          padding: EdgeInsets.only(left: 16.0),
          alignment: Alignment.centerLeft,
          child: Text('STT',
              style: TextStyle(
                color: Color(0xFF5D6B82),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.06,
              )),
        ),
      ),
      GridColumn(
        columnName: 'fileName',
        label: Container(
          width: 154,
          padding: EdgeInsets.all(16.0),
          alignment: Alignment.centerLeft,
          child: Text('Tên nhóm',
              style: TextStyle(
                color: Color(0xFF5D6B82),
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.06,
              )),
        ),
      ),
    ];

    useEffect(() {
      ref.read(groupManagementProvider.notifier).fetchGroupManage(paramPublic.toJson()).then((value) {
        isLoading.value = false;
        totalResult.value = value;
      });
      return null;
    }, []);
    Future<void> _refresh() async {
      // isLoading.value = true;
      await ref.read(groupManagementProvider.notifier).fetchGroupManage(paramPublic.toJson()).then((value) {
        // isLoading.value = false;
        totalResult.value = value;
      });
    }

    return LayoutEdoc(
      bodyWidget: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              // mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CreateButton(
                  'Tạo mới nhóm',
                  onPressed: () {
                    context.router.push(CreateGroupRoute());
                  },
                )
              ],
            ),
            SizedBox(height: 16),
            SearchBarWidget(textSearch: 'Tìm kiếm theo tên, địa chỉ email, họ tên tác giả', hintText: 'Tìm kiếm theo tên, địa chỉ email, họ tên tác giả', onChanged: (d) {}, onSubmit: (d) {}),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF9FAFB),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1, color: Color(0xFFE5E7EB)),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      shadowColor: Colors.transparent,
                      // maximumSize: Size(84, 46),
                      minimumSize: Size(84, 46),
                      // fixedSize: Size(84, 46),
                    ),
                    onPressed: () {
                      CommonFunction().showDeleteConfirmationDialog(context, () {});
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.delete_outline_outlined,
                          color: Colors.red,
                          size: 16,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Xóa',
                          style: TextStyle(
                            color: Colors.red,
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
            SizedBox(height: 16),
            Expanded(
              child: isLoading.value
                  ? DataGridShimmer()
                  : lstGroupManage.isEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              alignment: Alignment.center,
                              child: Image(
                                image: AssetImage('assets/images/no_data.png'),
                                width: 200,
                                height: 200,
                              ),
                            ),
                            Text(
                              'Không tìm thấy kết quả nào',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF212121),
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Chúng tôi không thể tìm thấy những gì bạn tìm kiếm hãy thử tìm lại với từ khóa khác',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF646568),
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        )
                      : RefreshIndicator(
                          onRefresh: _refresh,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SfDataGrid(
                                    frozenColumnsCount: 2,
                                    controller: _dataGridController,
                                    columnWidthMode: ColumnWidthMode.auto,
                                    headerRowHeight: 56,
                                    rowHeight: 54,
                                    source: GroupDataSource(groups: lstGroupManage, ref: ref, pageLink: paramPublic),
                                    columns: _gridColumn),
                              ),
                              if (totalResult.value > 10)
                                SfDataPager(
                                  pageCount: totalResult.value / 10,
                                  delegate: GroupDataSource(groups: lstGroupManage, ref: ref, pageLink: paramPublic),
                                  direction: Axis.horizontal,
                                  pageItemBuilder: (indexStr) {
                                    if (indexStr == 'First') {
                                      return Material(
                                        child: InkWell(
                                          onTap: () {
                                            selectedPageNumber.value = 0;
                                            _dataPageController.firstPage();
                                            paramPublic = paramPublic.copyWith(skipCount: 0);
                                            _refresh();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(
                                              '<<',
                                              style: TextStyle(
                                                color: Color(0xFF212121),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.07,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (indexStr == 'Last') {
                                      return Material(
                                        child: InkWell(
                                          onTap: () {
                                            selectedPageNumber.value = (totalResult.value / 10).round();
                                            _dataPageController.lastPage();
                                            paramPublic = paramPublic.copyWith(skipCount: (totalResult.value / 10).floor() * 10);
                                            _refresh();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(
                                              '>>',
                                              style: TextStyle(
                                                color: Color(0xFF212121),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.07,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (indexStr.contains('Previo')) {
                                      return Material(
                                        child: InkWell(
                                          onTap: () {
                                            if (selectedPageNumber.value > 0) {
                                              selectedPageNumber.value = selectedPageNumber.value - 1;
                                            }
                                            _dataPageController.previousPage();
                                            paramPublic = paramPublic.copyWith(skipCount: selectedPageNumber.value * 10);
                                            _refresh();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(
                                              '<',
                                              style: TextStyle(
                                                color: Color(0xFF212121),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.07,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    if (indexStr.contains('Next')) {
                                      return Material(
                                        child: InkWell(
                                          onTap: () {
                                            if (selectedPageNumber.value < (totalResult.value / 10).round()) {
                                              selectedPageNumber.value = selectedPageNumber.value + 1;
                                            }
                                            _dataPageController.nextPage();
                                            paramPublic = paramPublic.copyWith(skipCount: selectedPageNumber.value * 10);
                                            _refresh();
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                                            child: Text(
                                              '>',
                                              style: TextStyle(
                                                color: Color(0xFF212121),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 0.07,
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                    return Material(
                                      child: InkWell(
                                        onTap: () {
                                          selectedPageNumber.value = int.parse(indexStr);
                                          paramPublic = paramPublic.copyWith(skipCount: int.parse(indexStr) * 10);
                                          _refresh();
                                        },
                                        child: Container(
                                          alignment: Alignment.center,
                                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                                          decoration:
                                              BoxDecoration(color: selectedPageNumber.value == int.parse(indexStr) ? Color(0xFFD71920) : Colors.transparent, borderRadius: BorderRadius.circular(4)),
                                          child: Text(
                                            indexStr,
                                            style: TextStyle(
                                              color: selectedPageNumber.value == int.parse(indexStr) ? Colors.white : Color(0xFF212121),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.07,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  controller: _dataPageController,
                                ),
                            ],
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}

class GroupDataSource extends DataGridSource {
  final WidgetRef ref;
  final List<GroupItem> groups;
  final PageLink2 pageLink;
  GroupDataSource({required this.groups, required this.ref, required this.pageLink}) {
    int stt = pageLink.skipCount + 1;
    _groups = groups
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<bool>(columnName: 'select', value: e.selected),
              DataGridCell<String>(columnName: 'stt', value: (stt++).toString()),
              DataGridCell<String>(columnName: 'fileName', value: e.groupName),
            ]))
        .toList();
  }

  List<DataGridRow> _groups = [];

  @override
  List<DataGridRow> get rows => _groups;
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: dataGridCell.columnName == 'select'
            ? Checkbox(
                value: dataGridCell.value,
                onChanged: (val) {
                  ref.read(groupManagementProvider.notifier).selectGroupElement(groups[_groups.indexOf(row)].id ?? '');
                })
            : Text(
                dataGridCell.value.toString(),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: dataGridCell.columnName == 'fileName' ? Color(0xFFD71920) : Color(0xFF212121),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.07,
                ),
              ),
      );
    }).toList());
  }
}
