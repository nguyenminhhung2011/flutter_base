import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/widget_exetions.dart';

import '../mixins/product_mixin.dart';
import '../index.dart' show AnimatedFavorite;
import '../product_config/product_config_style.dart';

class ProductCardView extends StatefulWidget {
  final ProductConfigStyle productConfigStyle;
  const ProductCardView({
    super.key,
    required this.productConfigStyle,
  });

  @override
  State<ProductCardView> createState() => _ProductCardViewState();
}

class _ProductCardViewState extends State<ProductCardView> with ProductMixin {
  //style get
  double get _width => widget.productConfigStyle.width;

  bool _check = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _width,
      child: Stack(
        children: [
          Container(
            width: _width,
            // decoration: BoxDecoration,
          ),
          if (widget.productConfigStyle.isLikedProduct.isNotNull)
            AnimatedFavorite(
              onPress: () async {
                setState(() {
                  _check = !_check;
                });
              },
              isLiked: _check,
            ),
          if (widget.productConfigStyle.ratting.isNotNull)
            ratting(ratingPercent: widget.productConfigStyle.ratting ?? 5.0)
        ],
      ),
    );
  }
}
