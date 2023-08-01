import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';

import '../../../../core/components/widgets/money_minder/recent_activity.dart';
import '../../../../core/components/widgets/money_minder/recent_bill_item.dart';
import '../../../../generated/l10n.dart';

class BillScreen extends StatefulWidget {
  const BillScreen({super.key});

  @override
  State<BillScreen> createState() => _BillScreenState();
}

class _BillScreenState extends State<BillScreen> {
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    return Scaffold(
      backgroundColor: backgroundColor,
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
          S.of(context).bill,
          style: context.titleLarge.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: Column(children: [
        _viewBalance(context),
        Expanded(
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 10.0),
              _rowHeader(context,
                  header: S.of(context).recentBilling,
                  actionString: S.of(context).seeMore,
                  onActionPress: () {}),
              _recentBilling(context, backgroundColor),
              const SizedBox(height: 5.0),
              _rowHeader(context,
                  header: S.of(context).recentActivity,
                  actionString: S.of(context).viewAll,
                  onActionPress: () {}),
              ...<int>[0, 1, 2, 3]
                  .map<Widget>(
                    (e) => RecentActivity(
                        header: 'This is test',
                        timeCreated: DateTime.now(),
                        price: 1231000,
                        icon: Constant.icons[e]['icon'].toString(),
                        borderColor: Constant.icons[e]['color'] as Color),
                  )
                  .expand(
                    (element) => [element, const Divider(thickness: 0.6)],
                  ),
            ]
                .expand((element) => [element, const SizedBox(height: 10.0)])
                .toList(),
          ),
        )
      ]),
    );
  }

  HeaderTextCustom _rowHeader(
    BuildContext context, {
    required String header,
    required String actionString,
    required Function() onActionPress,
  }) {
    return HeaderTextCustom(
      headerText: header,
      textStyle: context.titleMedium.copyWith(
        fontWeight: FontWeight.w600,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      widget: InkWell(
        onTap: onActionPress,
        child: Text(
          actionString,
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 12.0,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _recentBilling(BuildContext context, Color backgroundColor) {
    return InkWell(
      onTap: () => context.openListPageWithRoute(Routes.billDetail),
      child: Row(
        children: [
          const SizedBox(width: 15.0),
          InkWell(
            onTap: () {},
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              height: 280.0,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                border:
                    Border.all(width: 1, color: Theme.of(context).primaryColor),
                color: backgroundColor,
              ),
              child: Center(
                child: RotatedBox(
                  quarterTurns: -1,
                  child: Text(
                    S.of(context).addNewBill,
                    style: context.titleMedium,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              height: 290.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  SizedBox(width: 10.0),
                  RecentBillItem(),
                  RecentBillItem(),
                  RecentBillItem(),
                ]
                    .expand((element) => [element, const SizedBox(width: 10.0)])
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _viewBalance(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 140.0,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(ImageConst.bill),
              )),
        ),
        Container(
          height: 140.0,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 15),
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  for (int i = 0; i < 3; i++)
                    Theme.of(context).shadowColor.withOpacity(0.7),
                ],
              ),
              borderRadius: BorderRadius.circular(10.0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                S.of(context).yourBalance,
                style: context.titleMedium.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 5.0),
              Text(
                1030000.price,
                style: context.titleLarge.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.0,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
