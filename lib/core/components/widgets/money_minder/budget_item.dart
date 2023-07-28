import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class BudgetItem extends StatelessWidget {
  final Color color;
  final String header;
  final DateTime timeStart;
  final DateTime timeEnd;
  final String icon;
  final int expense;
  final int budget;
  final String heroTag;

  final Function() viewDetail;
  const BudgetItem({
    super.key,
    required this.color,
    required this.header,
    required this.timeStart,
    required this.timeEnd,
    required this.icon,
    required this.expense,
    required this.budget,
    required this.viewDetail,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    titleTextStyle({Color? color, double size = 14}) =>
        context.titleSmall.copyWith(
          color: color ?? Theme.of(context).hintColor,
          fontSize: size,
          fontWeight: FontWeight.w600,
        );
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: Constant.hPadding),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(5.0),
              ),
            ),
            const SizedBox(width: 10.0),
            Expanded(
              child: Hero(
                tag: heroTag,
                child: Text(
                  '$icon $header',
                  style: context.titleMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),
            ButtonCustom(
              onPress: viewDetail,
              enableWidth: false,
              height: 27,
              radius: 5.0,
              child: Text(
                S.of(context).view,
                style: context.titleSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: Constant.hPadding),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: Constant.hPadding + 10),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              left: BorderSide(
                width: 1,
                color: Theme.of(context).dividerColor,
              ),
            ),
          ),
          child: Column(
            children: [
              LinearPercentIndicator(
                barRadius: const Radius.circular(10.0),
                animation: true,
                padding: EdgeInsets.zero,
                animationDuration: 1000,
                lineHeight: 8.0,
                percent: expense / budget,
                backgroundColor: color.withOpacity(0.2),
                progressColor: color,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ...[
                    getYmdFormat(timeStart),
                    getYmdFormat(timeEnd),
                  ].map((e) => Text(e, style: titleTextStyle(size: 12))),
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(Constant.hPadding * 2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                      width: 1.5, color: Theme.of(context).dividerColor),
                ),
                child: Column(
                  children: [
                    ...<Map<String, dynamic>>[
                      {'header': S.of(context).expenseMoney, 'data': expense},
                      {'header': S.of(context).budget, 'data': budget},
                      {
                        'header': S.of(context).summary,
                        'data': budget - expense
                      }
                    ].mapIndexed(
                      (index, e) {
                        final headerPrice =
                            switch (index) { 0 => '-', 1 => '+', _ => '' };
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              e['header'].toString(),
                              style: titleTextStyle(),
                            ),
                            Text(
                              '$headerPrice ${(e['data'] as int).price}',
                              style: titleTextStyle(
                                color: context.titleLarge.color,
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ]
                      .expandIndexed(
                        (index, element) => [
                          element,
                          if (index == 1) const Divider(thickness: 1.3)
                        ],
                      )
                      .toList(),
                ),
              ),
            ]
                .expand((element) => [element, const SizedBox(height: 10.0)])
                .toList()
              ..removeLast(),
          ),
        )
      ],
    );
  }
}
