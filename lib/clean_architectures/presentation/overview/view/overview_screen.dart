import 'dart:developer';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

import '../../../../core/components/constant/image_const.dart';
import '../../../../core/components/widgets/category_layout/category_layout.dart';
import '../../../../core/components/widgets/category_layout/category_layout_type.dart';
import '../../tes_ui/views/test_ui.dart';

class Transaction {
  final String id;

  Transaction({
    required this.id,
  });
}

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<CategoryLayoutModel> categoryTest = <CategoryLayoutModel>[
    CategoryLayoutModel(
        id: '1', title: ' Shopping', widgetCategory: const Text('🛒')),
    CategoryLayoutModel(
        id: '2', title: ' Food', widgetCategory: const Text('🍉')),
    CategoryLayoutModel(
        id: '3', title: ' Health', widgetCategory: const Text('🏥')),
    CategoryLayoutModel(
        id: '4', title: ' Family', widgetCategory: const Text('👪')),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 10, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        // toolbarHeight: 80.0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_vert_sharp,
              color: Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: backgroundColor,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Theme.of(context).dividerColor,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor.withOpacity(0.1),
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              unselectedLabelStyle: context.titleSmall,
              labelColor: context.titleSmall.color,
              unselectedLabelColor: Theme.of(context).hintColor,
              labelStyle: context.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
              ),
              indicatorColor: Theme.of(context).primaryColor,
              tabs: [
                ...[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map(
                  (e) => Tab(
                    text: '$e - 31313',
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: CategoryLayoutView<ModelImageTest>(
              hPadding: 10,
              vPadding: 10,
              categoryLayoutType: CategoryLayoutType.both,
              selectedTextStyle: context.titleSmall.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
              unselectedTextStyle: context.titleSmall.copyWith(
                color: Theme.of(context).hintColor,
                fontSize: 12.0,
              ),
              bothCategoryStyle: BothCategoryStyle(
                firstSiteColor: backgroundColor,
                secondSiteColor: backgroundColor,
                hPaddingSecondSite: 5.0,
                selectedFormat: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.5),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5.0),
                    bottomRight: Radius.circular(5.0),
                  ),
                ),
                categoryPadding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 12,
                ),
                categorySpacing: 10.0,
                firstExpand: 4,
                headerCategoryView: (categoryModel) {
                  return _headerCategoryStyle(context, categoryModel);
                },
              ),
              categoryLayoutModel: categoryTest,
              paginationDataCall: (currentPage, category) async {
                log(category);
                await Future.delayed(const Duration(seconds: 3));
                return <ModelImageTest>[
                  for (int t = 0; t < 6; t++)
                    ModelImageTest(
                      imageUrl: ImageConst.baseImageView,
                      title: 'Product t$t',
                      subTitle: 'This is product $t of category $category',
                    ),
                ];
              },
              itemBuilder: (ModelImageTest data) => Container(
                width: double.infinity,
                padding: const EdgeInsets.all(10.0),
                color: Theme.of(context).primaryColor.withOpacity(0.05),
              ),
              itemCategoryBuilder: (data) => const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _headerCategoryStyle(
      BuildContext context, CategoryLayoutModel categoryModel) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10.0),
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Theme.of(context).cardColor,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor.withOpacity(0.2),
            blurRadius: 5.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              if (categoryModel.widgetCategory != null) ...<Widget>[
                categoryModel.widgetCategory!,
                const SizedBox(width: 5.0),
              ],
              Expanded(
                child: Text(
                  categoryModel.title,
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              getRangeDateFormat(Constant.timeNow,
                  Constant.timeNow.add(const Duration(days: 1))),
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w600,
                color: Theme.of(context).primaryColor,
                fontSize: 10.0,
              ),
            ),
          ),
          ...<Map<String, dynamic>>[
            {'header': S.of(context).outFlow, 'data': 103013},
            {'header': S.of(context).inFlow, 'data': 403013},
            {'header': S.of(context).summary, 'data': 303013}
          ].mapIndexed(
            (index, e) {
              final headerPrice =
                  switch (index) { 0 => '-', 1 => '+', _ => '' };
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    e['header'].toString(),
                    style: context.titleSmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).hintColor,
                      fontSize: 12.0,
                    ),
                  ),
                  Text(
                    '$headerPrice ${(e['data'] as int).price}',
                    style: context.titleSmall.copyWith(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              );
            },
          ),
          InkWell(
            onTap: () {},
            child: Text(
              S.of(context).viewReport,
              style: context.titleSmall.copyWith(
                fontSize: 12.0,
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ]
            .expandIndexed((index, element) => [
                  element,
                  const SizedBox(height: 5.0),
                  if (index == 3) ...<Widget>[
                    const Divider(),
                    const SizedBox(),
                  ],
                ])
            .toList()
          ..removeLast(),
      ),
    );
  }
}
