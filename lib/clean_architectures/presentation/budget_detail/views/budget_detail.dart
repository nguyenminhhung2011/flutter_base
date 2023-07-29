import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/line_chart.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/components/utils/hero_tag.dart';
import '../../../../generated/l10n.dart';

class TimeChartData {
  final DateTime time;
  final double data;
  TimeChartData({
    required this.time,
    required this.data,
  });
}

class BudgetDetail extends StatefulWidget {
  final int heroIndex;
  const BudgetDetail({super.key, required this.heroIndex});

  @override
  State<BudgetDetail> createState() => _BudgetDetailState();
}

class _BudgetDetailState extends State<BudgetDetail> {
  final List<TimeChartData> data = [];
  @override
  void initState() {
    for (var i = 0; i < 31; i++) {
      data.add(TimeChartData(
          time: Constant.timeNow.add(Duration(days: i)),
          data: (i < 14 ? 1301 + i * 10 : 2103 + (i < 27 ? i * 2 : i * 20))
              .toDouble()));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final budgetItem = Constant.budgetItems[widget.heroIndex];
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: backgroundColor,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(Icons.arrow_back, color: context.titleLarge.color),
        ),
        elevation: 0,
        title: Text(
          S.of(context).budgetDetail,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit, color: context.titleLarge.color),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete, color: context.titleLarge.color),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const SizedBox(height: 10.0),
          const SizedBox(height: 10.0),
          _headerField(backgroundColor, context, budgetItem),
          const SizedBox(height: 30.0),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: LineChartCustom(
              isShowingMainData: false,
              maxData: 4290,
              data: data.map((e) => e.data).toList(),
              timeEnd: data.first.time,
              timeStart: data.last.time,
              limitData: 1821,
            ),
          ),
          const SizedBox(height: 10.0),
          const Divider(),
          const SizedBox(height: 10.0),
          ...<Map<String, dynamic>>[
            {
              'tit': S.of(context).limit,
              'color': Colors.red,
              'data': 4929493,
            },
            {
              'tit': S.of(context).spentPerDate,
              'color': Theme.of(context).primaryColor,
              'data': 103021,
            }
          ]
              .map(
                (e) => Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: Constant.hPadding * 2),
                  child: Row(
                    children: [
                      Container(
                        width: 6,
                        height: 18,
                        decoration: BoxDecoration(
                          color: e['color'] as Color,
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                      const SizedBox(width: 5.0),
                      Text(
                        '${e['tit'].toString()}: ',
                        style: context.titleSmall.copyWith(
                          color: Theme.of(context).hintColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.0,
                        ),
                      ),
                      Text(
                        (e['data'] as int).price,
                        style: context.titleSmall.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
              .expandIndexed(
                (index, element) =>
                    [element, if (index == 0) const SizedBox(height: 5.0)],
              ),
          const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonCustom(
                enableWidth: false,
                child: Text(
                  S.of(context).transactions,
                  style: context.titleSmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
                onPress: () {},
              ),
            ],
          )
        ],
      ),
    );
  }

  Container _headerField(Color backgroundColor, BuildContext context,
      Map<String, dynamic> budgetItem) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      margin: const EdgeInsets.symmetric(horizontal: Constant.hPadding),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(width: 1, color: Theme.of(context).dividerColor),
        boxShadow: [
          BoxShadow(
            color: context.titleLarge.color!.withOpacity(0.3),
            blurRadius: 10.0,
          )
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: '${HeroTag.budgetItemTag} ${widget.heroIndex}',
                  child: Text(
                    '${budgetItem['icon'].toString()} ${budgetItem['header'].toString()}',
                    style: context.titleMedium.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  13013009.price,
                  style: context.titleLarge.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                    fontSize: 24.0,
                  ),
                ),
                Text(
                  '📋 ${getRangeDateFormat(Constant.timeNow, Constant.timeNow.add(const Duration(days: 1)))}',
                  style: context.titleMedium.copyWith(
                    fontSize: 13.0,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'This is description this description this is description this description',
                  style: context.titleSmall.copyWith(
                    fontSize: 11.0,
                    color: Theme.of(context).hintColor,
                  ),
                )
              ]
                  .expand((element) => [element, const SizedBox(height: 10.0)])
                  .toList()
                ..removeLast(),
            ),
          ),
          const SizedBox(width: 10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: 45.0,
                animation: true,
                lineWidth: 6.0,
                percent: 0.90,
                circularStrokeCap: CircularStrokeCap.round,
                center: Text(
                  '90%',
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                progressColor: Theme.of(context).primaryColor,
                backgroundColor:
                    Theme.of(context).primaryColor.withOpacity(0.3),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  ...<Map<String, dynamic>>[
                    {
                      'tit': S.of(context).spent,
                      'color': Theme.of(context).primaryColor,
                    },
                    {
                      'tit': S.of(context).empty,
                      'color': Theme.of(context).primaryColor.withOpacity(0.3),
                    }
                  ]
                      .mapIndexed(
                        (index, e) => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 7.0,
                              height: 7.0,
                              decoration: BoxDecoration(
                                color: e['color'] as Color,
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                            const SizedBox(width: 2.0),
                            Text(
                              e['tit'].toString(),
                              style: context.titleSmall.copyWith(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).hintColor,
                                fontSize: 11.0,
                              ),
                            )
                          ],
                        ),
                      )
                      .expandIndexed(
                        (index, element) => [
                          element,
                          if (index == 0) const SizedBox(width: 5.0)
                        ],
                      ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
