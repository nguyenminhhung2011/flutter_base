import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

import '../../../../core/components/widgets/money_minder/budget_item.dart';
import '../../../../core/components/widgets/pie_chart.dart';

class BudgetScreen extends StatefulWidget {
  const BudgetScreen({super.key});

  @override
  State<BudgetScreen> createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 80.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: context.titleLarge.color),
          onPressed: () => context.pop(),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          S.of(context).budget,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          const SizedBox(height: 5.0),
          _overviewField(context),
          const SizedBox(height: 10.0),
          Divider(color: Theme.of(context).dividerColor),
          Row(
            children: [
              const SizedBox(width: Constant.hPadding),
              Text(
                S.of(context).budgetsCategories,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              TextButton(
                onPressed: () {},
                child: Text(
                  S.of(context).add,
                  style: context.titleSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            ],
          ),
          // _budget(context),
          BudgetItem(
            color: Colors.blue,
            header: 'Shopping',
            timeStart: Constant.timeNow,
            timeEnd: Constant.timeNow.add(const Duration(days: 1)),
            icon: '🛒',
            expense: 100000,
            budget: 400000,
          ),
          BudgetItem(
            color: Theme.of(context).primaryColor,
            header: 'Health',
            timeStart: Constant.timeNow,
            timeEnd: Constant.timeNow.add(const Duration(days: 1)),
            icon: '🏥',
            expense: 200000,
            budget: 400000,
          ),
          BudgetItem(
            color: Colors.yellow,
            header: 'Family',
            timeStart: Constant.timeNow,
            timeEnd: Constant.timeNow.add(const Duration(days: 1)),
            icon: '👪',
            expense: 100000,
            budget: 400000,
          ),
        ],
      ),
    );
  }

  Row _overviewField(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                10302032.price,
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 22.0,
                ),
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  style: context.titleSmall.copyWith(
                    color: Theme.of(context).hintColor,
                  ),
                  children: [
                    TextSpan(text: S.of(context).remainingAtThisMonth),
                    TextSpan(
                      text: ' 4.5%',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              RichText(
                text: TextSpan(
                  style: context.titleSmall
                      .copyWith(color: Theme.of(context).hintColor),
                  children: [
                    TextSpan(text: S.of(context).spent),
                    TextSpan(
                      text: ' ${100000.price}',
                      style: TextStyle(
                        color: context.titleLarge.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: ' of ${203000.price}')
                  ],
                ),
              ),
            ],
          ),
        ),
        const PieChartVIew(
          sum: 100,
          radius: 130,
          data: [
            {'data': 24, 'icon': 0, 'title': ''},
            {'data': 36, 'icon': 2, 'title': ''},
            {'data': 40, 'icon': 3, 'title': ''}
          ],
        ),
      ],
    );
  }
}
