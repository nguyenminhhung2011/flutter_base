import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/app_coordinator.dart';
import 'package:flutter_base_clean_architecture/core/components/constant/image_const.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/int_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/button_custom.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/money_minder/category_icon.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../generated/l10n.dart';

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
      onPress: () => context.openListPageWithRoute(Routes.billDetail),
      height: 38.0,
      radius: 7.0,
      child: Text(
        S.of(context).splitNow,
        style: context.titleSmall.copyWith(color: Colors.white),
      ),
    );
  }

  Wrap _peopleBill(BuildContext context) {
    return Wrap(
      children: [
        ...<String>[for (int i = 0; i < 5; i++) ImageConst.bill].map(
          (e) => Container(
            width: 40.0,
            height: 40.0,
            margin: const EdgeInsets.only(bottom: 5.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(e),
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
