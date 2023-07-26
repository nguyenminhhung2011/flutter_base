import 'dart:developer';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/money_minder/category_icon.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/popup_button_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import '../../../../core/components/enum/category_type.dart';
import '../../../../core/components/enum/time_view_enum.dart';
import '../../../../core/components/widgets/category_layout/category_layout.dart';
import '../../../../core/components/widgets/category_layout/category_layout_type.dart';

class TimeView {
  final DateTime startTime;
  final DateTime finishTime;

  TimeView({
    required this.startTime,
    required this.finishTime,
  });
}

class Transaction {
  final String id;
  final String categoryId;
  final String withPerson;
  final String walletId;
  final String note;
  final int price;
  final DateTime time;
  Transaction({
    required this.id,
    required this.categoryId,
    required this.walletId,
    required this.note,
    required this.price,
    required this.withPerson,
    required this.time,
  });
}

class Category {
  final String id;
  final String title;
  final int indexIcon;
  final CategoryType categoryType;
  Category({
    required this.id,
    required this.title,
    required this.indexIcon,
    required this.categoryType,
  });
}

Map<String, Category> categories = {
  '1': Category(
      id: '1',
      title: 'Shopping',
      indexIcon: 0,
      categoryType: CategoryType.expense),
  '2': Category(
      id: '2', title: 'Food', indexIcon: 1, categoryType: CategoryType.expense),
  '3': Category(
      id: '3',
      title: 'Health',
      indexIcon: 2,
      categoryType: CategoryType.expense),
  '4': Category(
      id: '4',
      title: 'Family',
      indexIcon: 3,
      categoryType: CategoryType.expense),
};
List<String> listTypeView = [
  'Day',
  'Week',
  'Month',
  'Year',
  'All transactions'
];

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final ValueNotifier<String> _typeView =
      ValueNotifier<String>(listTypeView.first);

  List<CategoryLayoutModel> categoryTest = <CategoryLayoutModel>[
    CategoryLayoutModel(
      id: '0',
      title: S.current.all,
      widgetCategory: const Text('🌈'),
    ),
    ...categories.entries.mapIndexed(
      (index, e) => CategoryLayoutModel(
          id: e.key,
          title: e.value.title,
          widgetCategory:
              Text(Constant.icons[e.value.indexIcon]['icon'].toString())),
    )
  ];
  final _tabs = <TimeView>[];

  List<TimeView> onGetDate(TimeViewEnum timeViewEnum) {
    final currentDate = Constant.timeNow;
    return <TimeView>[
      ...switch (timeViewEnum) {
        TimeViewEnum.year => [
            for (var i = 13; i >= 0; i--)
              TimeView(
                startTime: DateTime(
                    currentDate.year - i, currentDate.month, currentDate.day),
                finishTime: Constant.timeNow,
              ),
            TimeView(
              startTime: DateTime(
                  currentDate.year + 1, currentDate.month, currentDate.day),
              finishTime: Constant.timeNow,
            ),
          ],
        TimeViewEnum.month => [
            for (var i = 13; i >= 0; i--)
              TimeView(
                startTime: DateTime(
                    currentDate.year, currentDate.month - i, currentDate.day),
                finishTime: Constant.timeNow,
              ),
            TimeView(
              startTime: DateTime(
                  currentDate.year, currentDate.month + 1, currentDate.day),
              finishTime: Constant.timeNow,
            ),
          ],
        TimeViewEnum.week => [
            ...[for (var i = 13; i >= -1; i--) i].map((e) {
              final date = e == -1
                  ? Constant.timeNow.add(const Duration(days: 7))
                  : Constant.timeNow.subtract(Duration(days: e * 7));
              return TimeView(
                startTime: date.subtract(Duration(days: date.weekday - 1)),
                finishTime: date.add(
                  Duration(days: DateTime.daysPerWeek - date.weekday),
                ),
              );
            }),
          ],
        _ => <TimeView>[
            for (var i = 13; i >= 0; i--)
              TimeView(
                startTime: Constant.timeNow.subtract(Duration(days: i)),
                finishTime: Constant.timeNow,
              ),
            TimeView(
              startTime: Constant.timeNow.add(const Duration(days: 1)),
              finishTime: Constant.timeNow,
            )
          ],
      }
    ];
  }

  void _onSelectedTypeView(String view) {
    _typeView.value = view;
    int countable = 15;
    _tabs.clear();
    switch (view) {
      case 'Day':
        _tabs.addAll(onGetDate(TimeViewEnum.day));
      case 'Week':
        _tabs.addAll(onGetDate(TimeViewEnum.week));
      case 'Month':
        _tabs.addAll(onGetDate(TimeViewEnum.month));
      case 'Year':
        _tabs.addAll(onGetDate(TimeViewEnum.year));
      default:
        countable = 1;
        for (var i = 0; i < 15; i++) {
          _tabs.add(
            TimeView(startTime: Constant.timeNow, finishTime: Constant.timeNow),
          );
        }
    }
    _tabController ??= TabController(length: countable, vsync: this);
    if (countable != 1) {
      _tabController!.animateTo(13);
    } else {
      _tabController!.animateTo(0);
    }
    setState(() {});
  }

  Future<List<Transaction>> paginationCall(
      int currentPage, String categoryId) async {
    log(categoryId);

    await Future.delayed(const Duration(seconds: 3));
    if (categoryId == '0') {
      return <Transaction>[
        for (var i = 1; i <= 4; i++)
          for (var t = 0; t < 6; t++)
            Transaction(
              id: 'transaction $t',
              categoryId: i.toString(),
              walletId: 'walletId',
              note: 'Some note',
              price: (t + 1) * 10000,
              withPerson: 'Hung',
              time: Constant.timeNow.add(Duration(days: t)),
            )
      ];
    }
    return <Transaction>[
      for (int t = 0; t < 6; t++)
        Transaction(
          id: 'transaction $t',
          categoryId: categoryId,
          walletId: 'walletId',
          note: 'Some note',
          price: (t + 1) * 10000,
          withPerson: 'Hung',
          time: Constant.timeNow.add(Duration(days: t)),
        )
    ];
  }

  @override
  void initState() {
    _onSelectedTypeView(_typeView.value);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      extendBody: true,
      backgroundColor: backgroundColor,
      appBar: _appBar(backgroundColor, context),
      body: Column(
        children: [
          _selectedTimeField(backgroundColor, context),
          const SizedBox(height: 10.0),
          _listTransactionField(context, backgroundColor),
        ],
      ),
    );
  }

  Expanded _listTransactionField(BuildContext context, Color backgroundColor) {
    return Expanded(
      child: CategoryLayoutView<Transaction>(
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
          separated: Divider(
            color: Theme.of(context).hintColor,
            thickness: 0.2,
          ),
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
          firstExpand: 5,
          secondExpand: 15,
          headerCategoryView: (categoryModel) {
            return _headerCategoryStyle(context, categoryModel);
          },
        ),
        categoryLayoutModel: categoryTest,
        paginationDataCall: paginationCall,
        itemBuilder: (Transaction data) {
          final category = categories[data.categoryId];
          final isExpense = category?.categoryType.isExpense ?? false;
          final categoryIndexIcon = category?.indexIcon ?? 0;
          final colorCategory =
              Constant.icons[categoryIndexIcon]['color'] as Color;
          final iconCategory =
              Constant.icons[categoryIndexIcon]['icon'].toString();
          final priceColor =
              isExpense ? Colors.red.withOpacity(0.9) : Colors.green;
          return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10.0),
            // color: Theme.of(context).primaryColor.withOpacity(0.2),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CategoryIcon(
                  color: colorCategory,
                  icon: iconCategory,
                  radius: 30,
                  iconSize: 15,
                ),
                const SizedBox(width: 10.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        categories[data.categoryId]?.title ?? '',
                        style: context.titleMedium.copyWith(
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        getYmdHmFormat(data.time),
                        style: context.titleSmall.copyWith(
                          fontSize: 11.0,
                          color: Theme.of(context).hintColor,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                Text(
                  data.price.price,
                  style: context.titleSmall.copyWith(
                    color: priceColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        },
        itemCategoryBuilder: (data) => const SizedBox(),
      ),
    );
  }

  Container _selectedTimeField(Color backgroundColor, BuildContext context) {
    return Container(
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
        labelStyle: context.titleSmall.copyWith(fontWeight: FontWeight.bold),
        indicatorColor: Theme.of(context).primaryColor,
        tabs: [
          if (_typeView.value != 'All transactions')
            ..._tabs.mapIndexed((index, e) {
              final text = switch (_typeView.value) {
                'Day' => index >= 13
                    ? index == 13
                        ? S.of(context).today
                        : S.of(context).tomorrow
                    : getYmdFormat(e.startTime),
                'Week' =>
                  '${e.startTime.day}/${e.startTime.month} - ${e.finishTime.day}/${e.finishTime.month}',
                'Month' => index >= 13
                    ? index == 13
                        ? S.of(context).thisMonth
                        : S.of(context).nextMonth
                    : '${e.startTime.month}/${e.startTime.year}',
                _ => index >= 13
                    ? index == 13
                        ? S.of(context).thisYear
                        : S.of(context).nextYear
                    : e.startTime.year.toString(),
              };
              return Tab(text: text.toString());
            })
          else
            ..._tabs.mapIndexed((index, element) {
              if (index != 0) {
                return const SizedBox();
              }
              return const Tab(text: 'All transactions');
            })
        ],
      ),
    );
  }

  AppBar _appBar(Color backgroundColor, BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      toolbarHeight: 80.0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🐼 Panda wallet',
            style: context.titleSmall.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 10.0,
            ),
          ),
          Text(
            75103140.price,
            style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
      actions: [
        ValueListenableBuilder<String>(
          valueListenable: _typeView,
          builder: (context, typeView, child) {
            return PopUpButtonCustom<String>(
              onSelected: _onSelectedTypeView,
              itemBuilder: (_) {
                return listTypeView
                    .map<PopupMenuEntry<String>>(
                      (e) => PopupMenuItem(
                        value: e,
                        child: Row(
                          children: [
                            Text(
                              e.toString(),
                              style: context.titleSmall.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 10.0),
                            if (typeView == e)
                              const Icon(Icons.check, color: Colors.green)
                          ],
                        ),
                      ),
                    )
                    .toList();
              },
              icon: Icon(Icons.more_vert, color: Theme.of(context).hintColor),
            );
          },
        ),
      ],
    );
  }

  Widget _headerCategoryStyle(
      BuildContext context, CategoryLayoutModel categoryModel) {
    final isExpense =
        categories[categoryModel.id]?.categoryType.isExpense ?? false;
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
            if (isExpense || categoryModel.id == '0')
              {'header': S.of(context).outFlow, 'data': 103013},
            if (!isExpense || categoryModel.id == '0')
              {'header': S.of(context).inFlow, 'data': 403013},
            if (categoryModel.id == '0')
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
                  if (index == 3 && categoryModel.id == '0') ...<Widget>[
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
