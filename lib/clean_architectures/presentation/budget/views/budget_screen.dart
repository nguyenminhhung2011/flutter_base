import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(
          S.of(context).budget,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10.0),
          PieChartVIew(
            sum: 100,
            data: const [
              {'data': 24, 'icon': 0, 'title': ''},
              {'data': 36, 'icon': 2, 'title': ''},
              {'data': 40, 'icon': 3, 'title': ''}
            ],
          ),
        ],
      ),
    );
  }
}
