import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/string_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/swiper_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/components/constant/constant.dart';
import '../../../../core/components/widgets/category/category_custom.dart';
import '../../../../core/components/widgets/category/category_model.dart';
import '../../../../core/components/widgets/category/category_type.dart';
import '../../../../core/components/widgets/money_minder/category_icon.dart';

class ChartData {
  ChartData(this.x, this.y, this.y1);

  final String x;
  final double y;
  final double y1;
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ChartData> data;
  late TooltipBehavior _tooltip;
  List<CategoryModel> listCategory = <CategoryModel>[
    CategoryModel(
      iconSize: 20,
      title: ' ${S.current.incomeMoney}',
      iconUrl: ImageConst.iMoneyIcon,
      color: '#07AEAF'.toColor(),
      isIconData: false,
    ),
    CategoryModel(
      iconSize: 20,
      title: ' ${S.current.expenseMoney}',
      iconUrl: ImageConst.eMoneyIcon,
      color: '#ffffc0ee'.toColor(),
      isIconData: false,
    ),
    CategoryModel(
      iconSize: 20,
      title: ' ${S.current.lendLoan}',
      iconUrl: ImageConst.loanIcon,
      color: '#ffffdab5'.toColor(),
      isIconData: false,
    ),
    CategoryModel(
      iconSize: 20,
      title: ' ${S.current.reports}',
      iconUrl: ImageConst.chartIcon,
      color: '#ff97d5ff'.toColor(),
      isIconData: false,
    ),
  ];

  @override
  void initState() {
    data = [
      ChartData('SUN', 12, 15),
      ChartData('MON', 15, 20),
      ChartData('TUE', 30, 24),
      ChartData('WED', 6.4, 11),
      ChartData('THU', 14, 9),
      ChartData('FRI', 0, 31),
      ChartData('SAT', 0, 10)
    ];
    _tooltip = TooltipBehavior(enable: true);
    super.initState();
  }

  // style
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final headerStyle =
        context.titleMedium.copyWith(fontWeight: FontWeight.w500);
    final boldHeader = headerStyle.copyWith(fontWeight: FontWeight.bold);
    final smallStyle =
        context.titleSmall.copyWith(fontWeight: FontWeight.w500, fontSize: 11);
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: _appBarField(context, backgroundColor),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              HeaderTextCustom(
                headerText: S.of(context).anotherFeature,
                textStyle: boldHeader,
                isShowSeeMore: true,
                onPress: () {},
              ),
              SwipedCustom(
                height: 200,
                itemCount: 3,
                isShowSlideDot: false,
                autoPlay: true,
                itemBuilder: (index) {
                  final color = switch (index) {
                    0 => const Color.fromARGB(255, 87, 152, 248),
                    1 => '#ffffdab5'.toColor(),
                    _ => Theme.of(context).primaryColor.withOpacity(0.5),
                  };
                  return Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: color,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(Constant.banners[index].toString()),
                        ),
                      ));
                },
                swipedLayout: SwiperLayout.DEFAULT,
              ),
            ],
          ),
          CategoryField(
            categoryType: CategoryType.expandCategory, // => Change here
            selectedColor: Theme.of(context).primaryColor,
            numberColumn: 2,
            spacingItem: 15.0,
            marginLeft: 10.0,
            marginRight: 10.0,
            isIconOut: false,
            categoryGridFormat:
                const CategoryGridFormat(crossSpacing: 10.0, mainSpacing: 10.0),
            unselectedColor: Theme.of(context).hintColor,
            categoryTextStyle: context.titleSmall.copyWith(
              fontWeight: FontWeight.w500,
              overflow: TextOverflow.ellipsis,
            ),
            categories: <CategoryStyle>[
              ...listCategory.mapIndexed(
                (index, e) => CategoryStyle(
                  isSelected: index == 0,
                  text: e.title,
                  typeImage: e.typeImage,
                  iconUrl: e.iconUrl,
                  color: e.color,
                  iconSize: e.iconSize,
                  isIcon: e.isIconData,
                  radius: 10,
                  paddingBottom: 15.0,
                  paddingRight: 15.0,
                  paddingTop: 15.0,
                  paddingLeft: 15.0,
                  onPress: () {},
                ),
              )
            ],
          ),
          HeaderTextCustom(
              headerText: S.of(context).overView, textStyle: boldHeader),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...<Map<String, dynamic>>[
                {
                  'color': Theme.of(context).primaryColor.withOpacity(0.7),
                  'body': _todayCardField(context, headerStyle, smallStyle),
                },
                {
                  'color': const Color.fromARGB(255, 242, 199, 120),
                  'body': _budgetsFastView(context, headerStyle, smallStyle),
                }
              ].mapIndexed((index, e) {
                const hPadding = Constant.hPadding;
                const halfPadding = hPadding / 2;
                return Container(
                  width: double.infinity,
                  height: 230,
                  margin: EdgeInsets.only(
                    left: index == 0 ? hPadding : halfPadding,
                    right: index == 1 ? hPadding : halfPadding,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 24.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: e['color'] as Color,
                  ),
                  child: e['body'] as Widget,
                );
              }),
            ].expand((element) => [Expanded(child: element)]).toList(),
          ),
          const Divider(),
          _headerCalendarView(context, headerStyle, smallStyle),
          _selectModView(context, smallStyle),
          _chartView(context),
        ].expand((element) => [element, const SizedBox(height: 15.0)]).toList(),
      ),
    );
  }

  SizedBox _chartView(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 220,
      child: SfCartesianChart(
        enableAxisAnimation: true,
        primaryXAxis: CategoryAxis(
          majorGridLines: const MajorGridLines(width: 0),
          minorGridLines: const MinorGridLines(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
          minorTickLines: const MinorTickLines(width: 0),
          axisLine: const AxisLine(width: 0.0),
        ),
        plotAreaBorderWidth: 0.0,
        primaryYAxis: NumericAxis(
          minimum: 0,
          maximum: 40,
          interval: 10,
          majorGridLines: const MajorGridLines(width: 0),
          minorGridLines: const MinorGridLines(width: 0),
          majorTickLines: const MajorTickLines(width: 0),
          minorTickLines: const MinorTickLines(width: 0),
          axisLine: const AxisLine(width: 0.0),
        ),
        tooltipBehavior: _tooltip,
        series: <ChartSeries<ChartData, String>>[
          ColumnSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y, // max
            name: 'Spend',
            borderRadius: BorderRadius.circular(25.0),
            pointColorMapper: (ChartData data, index) => index == 2
                ? Theme.of(context).primaryColor
                : Theme.of(context).dividerColor,
          ),
          SplineSeries<ChartData, String>(
            dataSource: data,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y1,
            name: 'Transactions',
            splineType: SplineType.cardinal,
            width: 2,
            color: const Color.fromARGB(255, 42, 128, 198),
          ),
        ],
      ),
    );
  }

  Column _selectModView(BuildContext context, TextStyle smallStyle) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ...<String>['D', 'W', 'M', 'Y'].mapIndexed((index, e) {
              final isSelected = index == 2;
              final backColor = isSelected
                  ? Theme.of(context).dividerColor
                  : Colors.transparent;
              final textColor = isSelected
                  ? Theme.of(context).primaryColor
                  : context.titleLarge.color;
              return InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(10.0),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 18.0,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: backColor,
                  ),
                  child: Center(
                    child: Text(
                      e.toUpperCase(),
                      style: context.titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              );
            }),
            const SizedBox(width: Constant.hPadding)
          ],
        ),
        const SizedBox(height: 10.0),
        ...<Map<String, dynamic>>[
          {'title': 'Spend (\$)', 'data': '\$700.12'},
          {'title': 'Transactions(#)', 'data': '10'},
        ].mapIndexed((index, e) {
          final color = index == 0
              ? Theme.of(context).primaryColor
              : const Color.fromARGB(255, 71, 157, 227);
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const SizedBox(width: Constant.hPadding),
              Container(
                height: 32.0,
                width: 8.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: color,
                ),
              ),
              const SizedBox(width: 10.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    e['title'].toString(),
                    style: smallStyle.copyWith(
                      color: Theme.of(context).hintColor,
                      fontSize: 13.0,
                    ),
                  ),
                  const SizedBox(height: 5.0),
                  Text(
                    e['data'].toString(),
                    style: smallStyle.copyWith(
                        color: color, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          );
        }).expandIndexed((index, element) =>
            [element, if (index == 0) const SizedBox(height: 10.0)]),
      ],
    );
  }

  AppBar _appBarField(BuildContext context, Color backgroundColor) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 80.0,
      backgroundColor: Colors.transparent,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(ImageConst.logoIcon, width: 50.0, height: 50.0),
          RichText(
            text: TextSpan(
              style: context.titleMedium.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: 'Money',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                const TextSpan(text: ' minder'),
              ],
            ),
          ),
          const Spacer(),
          ButtonCustom(
            color: backgroundColor,
            borderColor: Theme.of(context).primaryColor,
            onPress: () {},
            enableWidth: false,
            child: Row(
              children: [
                Text(
                  '🐼 Panda wallet',
                  style: context.titleSmall.copyWith(
                    color: backgroundColor.fontColorByBackground,
                    fontSize: 10.0,
                    fontWeight: FontWeight.w600,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _headerCalendarView(
      BuildContext context, TextStyle headerStyle, TextStyle smallStyle) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Constant.hPadding),
      child: Row(
        children: [
          CategoryIcon(
            color: Theme.of(context).primaryColor,
            icon: '🛒',
            radius: 40.0,
            iconSize: 14.0,
          ),
          const SizedBox(width: 10.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Shopping',
                  style: headerStyle.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  '\$630',
                  style: headerStyle.copyWith(fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ...getRangeDateFormat(
                Constant.timeNow,
                Constant.timeNow.add(const Duration(hours: 7 * 24)),
              )
                  .split('-')
                  .map(
                    (e) => Text(e.trim(), style: smallStyle),
                  )
                  .expand(
                    (element) => [
                      element,
                      Text(
                        '|',
                        style: smallStyle.copyWith(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                  .toList()
                ..removeLast()
            ],
          ),
        ],
      ),
    );
  }

  Column _budgetsFastView(
      BuildContext context, TextStyle headerStyle, TextStyle smallStyle) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(S.of(context).budgets, style: headerStyle),
            const Icon(Icons.arrow_forward_ios_sharp, size: 14.0)
          ],
        ),
        ...<Map<String, dynamic>>[
          {'icon': '🛒', 'title': 'Shopping', 'percent': 0.4, 'price': 300.0},
          {'icon': '🏥', 'title': 'Health', 'percent': 0.8, 'price': 740.0},
          {'icon': '🍉', 'title': 'Food', 'percent': 0.7, 'price': 620.0}
        ].map(
          (e) => _categoryFastPreview(
            smallStyle,
            icon: e['icon'].toString(),
            percent: e['percent'] as double,
            price: e['price'] as double,
            title: e['title'].toString(),
          ),
        ),
      ].expand((element) => [element, const Spacer()]).toList()
        ..removeLast(),
    );
  }

  Row _categoryFastPreview(
    TextStyle smallStyle, {
    required String icon,
    required double percent,
    required double price,
    required String title,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CategoryIcon(color: Colors.transparent, icon: icon),
        const SizedBox(width: 10.0),
        Expanded(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      style: smallStyle.copyWith(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Text(
                    '\$${price.round()}',
                    style: smallStyle.copyWith(
                        fontSize: 12.0, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 5.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: LinearPercentIndicator(
                      barRadius: const Radius.circular(10.0),
                      animation: true,
                      padding: EdgeInsets.zero,
                      animationDuration: 1000,
                      lineHeight: 8.0,
                      percent: percent,
                      backgroundColor: const Color.fromARGB(255, 91, 62, 18)
                          .withOpacity(0.3),
                      progressColor: const Color.fromARGB(255, 255, 229, 189),
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  Text('${(percent * 100).round()}%', style: smallStyle),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _todayCardField(
    BuildContext context,
    TextStyle headerStyle,
    TextStyle smallStyle,
  ) {
    Widget headText(String title) => Text(
          title,
          style: smallStyle.copyWith(
            color: Colors.white,
            fontSize: 13.0,
          ),
        );
    Widget subText(String title) => Text(
          title,
          style: smallStyle.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              S.of(context).today,
              style: headerStyle.copyWith(
                color: Colors.white,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_sharp,
              size: 14.0,
              color: Colors.white,
            )
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            headText(S.of(context).recentSpend),
            const SizedBox(height: 5.0),
            Row(
              children: <Widget>[
                const CategoryIcon(icon: '🐼', color: Colors.black),
                const SizedBox(width: 3.0),
                Expanded(child: subText('Panda')),
                subText('\$100'),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headText(S.of(context).category),
            const SizedBox(height: 5.0),
            subText('Panda & panda'),
          ],
        ),
      ].expand((element) => [element, const Spacer()]).toList()
        ..removeLast(),
    );
  }
}
