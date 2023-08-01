import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/generated/l10n.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        toolbarHeight: 80.0,
        title: Text(
          S.of(context).planning,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: ListView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: BouncingScrollPhysics(),
        ),
        children: [
          ...<Map<String, dynamic>>[
            {
              'header': S.of(context).budget,
              'image': ImageConst.budget,
              'icon': ImageConst.budgetPng,
              'color': Colors.yellow,
              'slogan':
                  'A financial plan helps to balance income and expenses, set achievable goals, and improve overall financial well-being.',
            },
            {
              'header': S.of(context).event,
              'image': ImageConst.event,
              'icon': ImageConst.eventPng,
              'color': Colors.red,
              'slogan':
                  'Tracking your spending during an event helps you manage your finances',
            },
            {
              'header': S.of(context).bill,
              'image': ImageConst.bill,
              'icon': ImageConst.billPng,
              'color': Colors.green,
              'slogan':
                  'Monitoring your recurring bills, setting up automatic payments, and reviewing them regularly'
            },
            {
              'header': S.of(context).recurring,
              'image': ImageConst.recurring,
              'icon': ImageConst.recurringPng,
              'color': Colors.blue,
              'slogan':
                  'Automatically scheduling future transactions can help streamline your finances'
            },
          ].mapIndexed(
            (index, e) => _itemView(e, context, call: () {
              switch (index) {
                case 0:
                  context.openListPageWithRoute(Routes.budgets);
                case 1:
                  context.openListPageWithRoute(Routes.events);
                case 2:
                  context.openListPageWithRoute(Routes.bills);
              }
            }),
          ),
        ].expand((element) => [element, const SizedBox(height: 5.0)]).toList(),
      ),
    );
  }

  SizedBox _itemView(Map<String, dynamic> e, BuildContext context,
      {required Function() call}) {
    return SizedBox(
      width: double.infinity,
      height: 150,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(e['image'].toString(), fit: BoxFit.cover),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
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
            width: double.infinity,
            height: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
                vertical: 15.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Image.asset(
                            e['icon'].toString(),
                            width: 35,
                            height: 35,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          e['header'].toString(),
                          style: context.titleMedium.copyWith(
                            color: e['color'] as Color,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(width: 10.0),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          e['slogan'].toString(),
                          style: context.titleSmall.copyWith(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        ButtonCustom(
                          enableWidth: false,
                          onPress: call,
                          color: (e['color'] as Color).withOpacity(0.5),
                          height: 30.0,
                          radius: 5.0,
                          child: Text(
                            '${S.of(context).view} ${e['header']}',
                            style: context.titleSmall.copyWith(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
