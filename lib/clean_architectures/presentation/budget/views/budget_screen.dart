import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
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
        flexibleSpace: Container(
          width: double.infinity,
        ),
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
          _headerView(context),
          const SizedBox(height: 30.0),
          Row(
            children: [
              const SizedBox(width: Constant.hPadding),
              Text(
                S.of(context).budgetsCategories,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10.0),
          ...<Map<String, dynamic>>[
            {'color': Colors.blue, 'header': 'Shopping', 'icon': '🛒'},
            {
              'color': Theme.of(context).primaryColor,
              'header': 'Health',
              'icon': '🏥'
            },
            {'color': Colors.yellow, 'header': 'Family', 'icon': '👪'},
          ].map((e) => BudgetItem(
                color: e['color'] as Color,
                header: e['header'].toString(),
                timeStart: Constant.timeNow,
                timeEnd: Constant.timeNow.add(const Duration(days: 1)),
                icon: e['icon'].toString(),
                expense: 10000,
                budget: 40000,
                viewDetail: (){},
              )),
        ],
      ),
    );
  }

  Stack _headerView(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: double.infinity,
          height: 170,
          child: Image.asset(ImageConst.budget, fit: BoxFit.cover),
        ),
        Container(
          width: double.infinity,
          height: 170,
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Theme.of(context).shadowColor.withOpacity(0.7),
              Theme.of(context).shadowColor.withOpacity(0.7),
              Theme.of(context).shadowColor.withOpacity(0.7),
            ],
          )),
        ),
        SizedBox(
          height: 170.0,
          child: _overviewField(context),
        ),
        Positioned(
          left: 30.0,
          top: 145.0,
          child: InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 50.0,
              height: 50.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.2),
                    blurRadius: 5.0,
                  )
                ],
              ),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }

  Row _overviewField(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
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
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10.0),
              RichText(
                text: TextSpan(
                  style: context.titleSmall.copyWith(
                    color: Colors.grey[300],
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
                  style: context.titleSmall.copyWith(
                    color: Colors.grey[300],
                  ),
                  children: [
                    TextSpan(text: S.of(context).spent),
                    TextSpan(
                      text: ' ${100000.price}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
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
