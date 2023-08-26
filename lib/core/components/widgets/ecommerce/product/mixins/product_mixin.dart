import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/rating_custom.dart';

mixin ProductMixin<T extends StatefulWidget> on State<T> {
  Widget ratting({required double ratingPercent}) {
    assert(
      ratingPercent >= 0.0 && ratingPercent <= 5.0,
      'Ratting must be in range [0.0 -  5.0]',
    );
    return RattingWidgetCustom(rating: ratingPercent);
  }

  Widget headerText({required String title}) => Text(title);
}
