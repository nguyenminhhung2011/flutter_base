import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/double_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/widget_exetions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/ecommerce/product/product_config/product_config_style.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/progress_indicator/linear_percent_indicator.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/rating_custom.dart';

import '../../../../../../generated/l10n.dart';
import '../../../button_custom.dart';

mixin ProductMixin<T extends StatefulWidget> on State<T> {
  Widget ratting({required double ratingPercent}) {
    assert(
      ratingPercent >= 0.0 && ratingPercent <= 5.0,
      'Ratting must be in range [0.0 -  5.0]',
    );
    return RattingWidgetCustom(rating: ratingPercent, itemSize: 12.0);
  }

  Widget descriptionDisplay({
    required String description,
    TextStyle? descriptionStyle,
  }) {
    final style = descriptionStyle ??
        context.titleSmall.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: 12.0,
        );
    return Text(description, style: style);
  }

  Widget stockDisplay({
    required StockStyle stockStyle,
    required int boughtCount,
    required int stockCount,
  }) {
    bool checkStock = boughtCount < stockCount;
    final colorStock = checkStock ? Theme.of(context).primaryColor : Colors.red;
    if (stockStyle.isText) {
      return Text(
        checkStock ? S.of(context).intStock : S.of(context).outStock,
        style: context.titleSmall
            .copyWith(fontWeight: FontWeight.w600, color: colorStock),
      );
    }
    return LinearProgressIndicatorCustom(
      initData: stockCount.toDouble(),
      progressData: boughtCount.toDouble(),
      fillColor: colorStock.withOpacity(0.3),
      progressColor: colorStock,
      isAnimation: true,
      height: 8.0,
    );
  }

  Widget addToCartButton({Future Function()? onPress, double? radius}) {
    return ButtonCustom(
      onPress: onPress ?? () {},
      radius: radius,
      height: 27.0,
      child: Text(
        S.of(context).addToCart,
        style: context.titleSmall.copyWith(fontSize: 12.0, color: Colors.white),
      ),
    );
  }

  Widget priceDisplay({
    required double price,
    double? discount,
  }) {
    assert(
      discount.isNotNull ? (discount! >= 0.0 && discount <= 1.0) : true,
    );
    final mainPriceStyle = context.titleSmall.copyWith(
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    );
    if (discount.isNotNull) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            (price * discount!).toCurrency(),
            maxLines: 1,
            style: mainPriceStyle,
          ),
          const SizedBox(width: 5.0),
          Expanded(
            child: Text(
              (price).toCurrency(),
              maxLines: 1,
              style: context.titleSmall.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 10.0,
                overflow: TextOverflow.ellipsis,
                decoration: TextDecoration.lineThrough,
                color: Theme.of(context).dividerColor,
              ),
            ),
          )
        ],
      );
    }
    return Text((price).toCurrency(), style: mainPriceStyle);
  }

  Widget headerText({required String title}) => Text(title);
}
