import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/constant.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/handle_time.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/header_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/money_minder/category_icon.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
              ...<int>[0, 1, 2, 3].map<Widget>(
                (e) => Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: Constant.hPadding, vertical: 5.0),
                  child: Row(
                    children: [
                      CategoryIcon(
                        color: Constant.icons[e]['color'] as Color,
                        icon: Constant.icons[e]['icon'].toString(),
                        radius: 40.0,
                        iconSize: 16.0,
                      ),
                      const SizedBox(width: 20.0),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'This is test',
                              style: context.titleMedium.copyWith(
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${getYmdFormat(Constant.timeNow)} | ${getjmFormat(Constant.timeNow)}',
                              style: context.titleSmall.copyWith(
                                color: Theme.of(context).hintColor,
                                fontSize: 11.0,
                              ),
                            )
                          ],
                        ),
                      ),
                      Text(
                        1231000.price,
                        style: context.titleMedium.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
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
      padding: const EdgeInsets.symmetric(horizontal: Constant.hPadding),
      widget: InkWell(
        onTap: onActionPress,
        child: Text(
          actionString,
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  Row _recentBilling(BuildContext context, Color backgroundColor) {
    return Row(
      children: [
        const SizedBox(width: Constant.hPadding),
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
    );
  }

  Container _viewBalance(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: Constant.hPadding),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Theme.of(context).primaryColor,
        boxShadow: [
          BoxShadow(
            color: context.titleLarge.color!.withOpacity(0.3),
            blurRadius: 20.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
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
    );
  }
}

class RecentBillItem extends StatefulWidget {
  const RecentBillItem({
    super.key,
  });

  @override
  State<RecentBillItem> createState() => _RecentBillItemState();
}

class _RecentBillItemState extends State<RecentBillItem> {
  final ValueNotifier<double> _opacity = ValueNotifier<double>(1);

  void _updateOpacity(VisibilityInfo visibilityInfo) {
    var visiblePercentage = visibilityInfo.visibleFraction * 100;
    if (visiblePercentage >= 50.0) {
      if (_opacity.value != 1) {
        _opacity.value = 1;
      }
    } else {
      if (_opacity.value != 0.5) {
        _opacity.value = 0.5;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final headerStyle = context.titleMedium.copyWith(
      fontWeight: FontWeight.w600,
    );
    return VisibilityDetector(
      key: const Key('my-widget-key'),
      onVisibilityChanged: _updateOpacity,
      child: ValueListenableBuilder<double>(
        valueListenable: _opacity,
        builder: (_, opacity, __) {
          return Opacity(
            opacity: opacity,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              margin: const EdgeInsets.symmetric(vertical: 5.0),
              width: context.widthDevice * 0.62,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor.withOpacity(0.2),
                    blurRadius: 5.0,
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _nameBill(headerStyle),
                        const Divider(thickness: 1),
                        _totalBill(context, headerStyle),
                        _headerBill(context),
                        _peopleBill(context),
                      ]
                          .expand((element) =>
                              [element, const SizedBox(height: 10.0)])
                          .toList(),
                    ),
                  ),
                  _buttonBill(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  ButtonCustom _buttonBill(BuildContext context) {
    return ButtonCustom(
      onPress: () {},
      height: 38.0,
      radius: 7.0,
      child: Text(S.of(context).splitNow, style: context.titleSmall),
    );
  }

  Wrap _peopleBill(BuildContext context) {
    return Wrap(
      children: [
        ...<String>[for (int i = 0; i < 5; i++) ImageConst.baseAvatarImage].map(
          (e) => Container(
            width: 40.0,
            height: 40.0,
            margin: const EdgeInsets.only(bottom: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: NetworkImage(e),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(width: 1, color: Theme.of(context).primaryColor),
            ),
            child: Center(
              child: Icon(Icons.add, color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ]
          .expandIndexed((index, element) =>
              [element, if ((index + 1) / 5 != 0) const SizedBox(width: 6.0)])
          .toList(),
    );
  }

  Row _headerBill(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...<String>[S.of(context).splitWith, S.of(context).noPeoples(4)].map(
          (e) => Text(
            e,
            style: context.titleSmall.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12.0,
              color: Theme.of(context).hintColor,
            ),
          ),
        ),
      ],
    );
  }

  Row _totalBill(BuildContext context, TextStyle headerStyle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(S.of(context).totalBills, style: headerStyle),
        Expanded(
          child: Text(
            103000.price,
            textAlign: TextAlign.right,
            style: context.titleLarge.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Row _nameBill(TextStyle headerStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('This is bills', style: headerStyle),
        const CategoryIcon(color: Colors.green, icon: '🐼')
      ],
    );
  }
}
