import 'package:auto_route/auto_route.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:edoc_tabcom/core/app_route/app_route.dart';
import 'package:edoc_tabcom/core/utils/env.dart';
import 'package:edoc_tabcom/core/utils/extension/common_function.dart';
import 'package:edoc_tabcom/core/utils/extension/object.dart';
import 'package:edoc_tabcom/core/utils/widgets/appbar_template_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/loading_mark.dart';
import 'package:edoc_tabcom/core/utils/widgets/search_widget.dart';
import 'package:edoc_tabcom/core/utils/widgets/shimmer_loading/common_simmer.dart';
import 'package:edoc_tabcom/models/home_model.dart';
import 'package:edoc_tabcom/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../core/utils/widgets/shimmer_loading/body_shimmer.dart';

@RoutePage()
class HomeScreen extends HookConsumerWidget {
  HomeScreen({super.key});
  bool isFinished = false;
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

  var paramPublic = PageLink();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final publicList = ref.watch(homeProvider);
    final categoryTree = ref.watch(categoryTreeProvider);
    final categorySelected = useState<CategoryTreeResonpse?>(null);
    final _userEditTextController = useTextEditingController();
    final ValueNotifier<int?> filterTab = useState(null);
    final disPlaySortingType = useState('');
    final isLoading = useState(true);
    final isLoandingMore = useState(false);
    final _scrollController = useScrollController();
    final hasMore = useState(true);
    Future<void> _loadMore() async {
      if (hasMore.value && _scrollController.position.pixels == _scrollController.position.maxScrollExtent && !isLoading.value) {
        isLoandingMore.value = true;
        paramPublic = paramPublic.copyWith(skipCount: paramPublic.skipCount + 20);
        try {
          hasMore.value = await ref.read(homeProvider.notifier).getMorePublicList(paramPublic);
          isLoandingMore.value = false;
        } catch (e) {
          hasMore.value = false;
          isLoandingMore.value = false;
          CommonFunction.showSnackBar('Có lỗi xảy ra trong quá trình kết xuất dữ liệu!', context, Colors.red);
        }
      }
    }

    Future<void> _refresh() async {
      isLoading.value = true;
      paramPublic = paramPublic.copyWith(skipCount: 20);
      hasMore.value = await ref.read(homeProvider.notifier).getPublicList(paramPublic);
      isLoading.value = false;
    }

    useEffect(() {
      Future.wait([ref.read(homeProvider.notifier).getPublicList(paramPublic), ref.read(categoryTreeProvider.notifier).getCategoryTree()]).then((value) {
        isLoading.value = false;
        _scrollController.addListener(_loadMore);
      });
      return () {};
    }, []);
    return LayoutEdoc(
      bodyWidget: Column(
        children: [
          Container(
            height: 46,
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 16, bottom: 16),
            padding: EdgeInsets.only(left: 16, right: 16),
            child: DropdownSearch<CategoryTreeResonpse>(
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  prefixIcon: Container(
                    padding: EdgeInsets.only(left: 40, right: 8),
                    child: SvgPicture.asset(
                      'assets/icons/sorting_icon.svg',
                      height: 20,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 20, minHeight: 20),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  hintText: 'Lọc theo danh mục',
                  filled: true,
                  fillColor: const Color(0xFFEC1C23),
                  hintStyle: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Color(0xFFEC1C23),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  // border: InputBorder.none,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(45),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(45),
                  ),
                ),
              ),
              filterFn: (item, filter) {
                return item.label!.toLowerCase().contains(filter.toLowerCase());
              },
              selectedItem: categorySelected.value,
              onChanged: (value) {
                categorySelected.value = value;
                paramPublic = paramPublic.copyWith(categoryId: value!.id, skipCount: 0);
                isLoading.value = true;
                ref.read(homeProvider.notifier).getPublicList(paramPublic).then((value) {
                  isLoading.value = false;
                  hasMore.value = value;
                });
              },
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
                onPressed: () {
                  categorySelected.value = null;
                  paramPublic = paramPublic.setNullCategoryId();
                  isLoading.value = true;
                  ref.read(homeProvider.notifier).getPublicList(paramPublic).then((value) {
                    isLoading.value = false;
                    hasMore.value = value;
                  });
                },
              ),
              dropdownButtonProps: const DropdownButtonProps(
                isVisible: false,
                icon: Icon(Icons.keyboard_arrow_down_outlined),
                iconSize: 24,
                color: Colors.white,
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
                  controller: _userEditTextController,
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
                        _userEditTextController.clear();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: SearchBarWidget(
              textSearch: '',
              hintText: 'Tìm kiếm tài liệu',
              onChanged: (value) {
                // filterLstProduct.value = lstProduct.where((element) => element.name!.toLowerCase().contains(value.toLowerCase())).toList();
              },
              onSubmit: (value) {
                paramPublic = paramPublic.copyWith(filter: value, skipCount: 0);
                isLoading.value = true;
                ref.read(homeProvider.notifier).getPublicList(paramPublic).then((value) {
                  isLoading.value = false;
                  hasMore.value = value;
                });
              },
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Sắp xếp theo:',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, shadowColor: Colors.transparent, padding: EdgeInsets.zero),
                  onPressed: () {
                    showModalBottomSheet(
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(24), topRight: Radius.circular(24))),
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.white,
                        builder: (context) {
                          return SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  // width: MediaQuery.of(context).size.width,
                                  // height: 52,
                                  padding: EdgeInsets.all(24),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: 1, color: Color(0xFFE0E0E0)),
                                    ),
                                  ),
                                  child: const Text(
                                    'Sắp xếp theo',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 58,
                                  color: Colors.white,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: Row(children: [
                                        SizedBox(
                                          width: 50,
                                          child: Visibility(
                                            visible: filterTab.value == 0,
                                            child: const Icon(
                                              Icons.check_outlined,
                                              size: 24,
                                              color: Color(0xFFEF4444),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Tài liệu mới nhất',
                                          style: TextStyle(
                                            color: filterTab.value == 0 ? Color(0xFFEF4444) : Color(0xFF42526D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.08,
                                          ),
                                        ),
                                      ]),
                                      onTap: () {
                                        context.router.pop();
                                        disPlaySortingType.value = 'Tài liệu mới nhất';
                                        filterTab.value = 0;
                                        paramPublic = paramPublic.copyWith(sorting: 'Lastest', skipCount: 0);
                                        isLoading.value = true;
                                        ref.read(homeProvider.notifier).getPublicList(paramPublic).then((value) {
                                          isLoading.value = false;
                                          hasMore.value = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 58,
                                  color: Colors.white,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: Row(children: [
                                        SizedBox(
                                          width: 50,
                                          child: Visibility(
                                            visible: filterTab.value == 1,
                                            child: const Icon(
                                              Icons.check_outlined,
                                              size: 24,
                                              color: Color(0xFFEF4444),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Lượt xem nhiều nhất',
                                          style: TextStyle(
                                            color: filterTab.value == 1 ? Color(0xFFEF4444) : Color(0xFF42526D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.08,
                                          ),
                                        ),
                                      ]),
                                      onTap: () {
                                        context.router.pop();
                                        disPlaySortingType.value = 'Lượt xem nhiều nhất';
                                        filterTab.value = 1;
                                        paramPublic = paramPublic.copyWith(sorting: 'MostView', skipCount: 0);
                                        isLoading.value = true;
                                        ref.read(homeProvider.notifier).getPublicList(paramPublic).then((value) {
                                          isLoading.value = false;
                                          hasMore.value = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 58,
                                  color: Colors.white,
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      child: Row(children: [
                                        SizedBox(
                                          width: 50,
                                          child: Visibility(
                                            visible: filterTab.value == 2,
                                            child: const Icon(
                                              Icons.check_outlined,
                                              size: 24,
                                              color: Color(0xFFEF4444),
                                            ),
                                          ),
                                        ),
                                        Text(
                                          'Nhiều lượt thích nhất',
                                          style: TextStyle(
                                            color: filterTab.value == 2 ? Color(0xFFEF4444) : Color(0xFF42526D),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.08,
                                          ),
                                        ),
                                      ]),
                                      onTap: () {
                                        context.router.pop();
                                        disPlaySortingType.value = 'Nhiều lượt thích nhất';
                                        filterTab.value = 2;
                                        paramPublic = paramPublic.copyWith(sorting: 'MostLike', skipCount: 0);
                                        isLoading.value = true;
                                        ref.read(homeProvider.notifier).getPublicList(paramPublic).then((value) {
                                          isLoading.value = false;
                                          hasMore.value = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Row(
                    children: [
                      Text(
                        disPlaySortingType.value == '' ? 'Mặc định' : disPlaySortingType.value,
                        style: TextStyle(
                          color: Color(0xFFEC1C23),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 4),
                      if (disPlaySortingType.value != '')
                        Icon(
                          Icons.arrow_upward_outlined,
                          color: Colors.black,
                          size: 14,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading.value
                ? BodyShimmerWidget()
                : publicList.isEmpty
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
                        child: Container(
                          padding: EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 24),
                          // margin: EdgeInsets.only(bottom: 24),
                          color: Color(0xffF7F7F7),
                          child: Scrollbar(
                            thumbVisibility: true,
                            controller: _scrollController,
                            child: GridView.builder(
                              controller: _scrollController,
                              padding: EdgeInsets.zero,
                              // shrinkWrap: true,
                              // physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, // This creates 2 elements in a row
                                childAspectRatio: 0.64,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 16,
                              ),
                              itemCount: publicList.length + (isLoandingMore.value ? 1 : 0),
                              itemBuilder: (BuildContext context, int index) {
                                if (index == publicList.length) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                return Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () {
                                      context.router.push(DetailDocumentRoute(id: publicList[index].id ?? ''));
                                    },
                                    child: Container(
                                      // height: 48,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8.32),
                                        // color: Colors.blueGrey,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          AspectRatio(
                                            aspectRatio: 1.085,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Image.network(
                                                '${Environment.apiUrl}/${publicList[index].avatarUrl ?? ''}',
                                                errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                                  return Image(
                                                    image: AssetImage('assets/images/images_default.png'),
                                                  );
                                                },
                                                fit: BoxFit.fitWidth,
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(12),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    publicList[index].fileName ?? '',
                                                    maxLines: 3,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                      color: Color(0xFF243757),
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),
                                                  Spacer(),
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/download_icon.svg',
                                                        height: 12,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        '${publicList[index].size} MB',
                                                        style: TextStyle(
                                                          color: Color(0xFF98A1B0),
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      Spacer(),
                                                      SvgPicture.asset(
                                                        'assets/icons/bx_heart.svg',
                                                        height: 12,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        publicList[index].likes.toString(),
                                                        style: TextStyle(
                                                          color: Color(0xFF98A1B0),
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                      SizedBox(width: 4),
                                                      SvgPicture.asset(
                                                        'assets/icons/u_eye.svg',
                                                        height: 12,
                                                      ),
                                                      SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        publicList[index].point.toString(),
                                                        style: TextStyle(
                                                          color: Color(0xFF98A1B0),
                                                          fontSize: 11,
                                                          fontWeight: FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        publicList[index].createDate ?? '',
                                                        style: TextStyle(color: Color(0xFF98A1B0), fontSize: 11, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, height: 1.5),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}
