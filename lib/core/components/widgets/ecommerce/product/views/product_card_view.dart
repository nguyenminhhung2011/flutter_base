import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/widget_exetions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:super_banners/super_banners.dart';

import '../mixins/product_mixin.dart';
import '../product_config/product_config_style.dart';
import '../product_config/product_data.dart';
import '../index.dart' show AnimatedFavorite;

class ProductCardView extends StatefulWidget {
  ///[All setup style]
  final ProductConfigStyle productConfigStyle;

  ///[Data]
  final ProductData productData;

  ///[Function] call to parent widget
  final Future Function()? favoritePress;

  final Future Function()? addToCartPress;

  final Function()? productPress;

  const ProductCardView({
    Key? key,
    this.productPress,
    this.favoritePress,
    this.addToCartPress,
    required this.productConfigStyle,
    required this.productData,
  }) : super(key: key);

  @override
  State<ProductCardView> createState() => _ProductCardViewState();
}

class _ProductCardViewState extends State<ProductCardView> with ProductMixin {
  //style get
  double get _width => widget.productConfigStyle.width;

  double get _radius => widget.productConfigStyle.radius;

  double get _aspectRatio => widget.productConfigStyle.aspectRatio;

  double? get _rating => widget.productData.ratting;

  bool? get _isLiked => widget.productData.isLikedProduct;

  Color get _bColor =>
      widget.productConfigStyle.bannerColor ?? Theme.of(context).primaryColor;

  // Data
  double? get _discount => widget.productData.discount;

  double? get _price => widget.productData.price;

  double get _enableMarginHeight =>
      widget.productConfigStyle.enableMarginHeight ?? 0.0;

  StockStyle? get _stockStyle => widget.productConfigStyle.stockStyle;

  int? get _boughtCount => widget.productData.boughtCount;

  int? get _stockCount => widget.productData.stockCount;

  @override
  Widget build(BuildContext context) {
    assert(
      widget.productConfigStyle.elevationShadow >= 0.0 &&
          widget.productConfigStyle.elevationShadow <= 1.0,
      "ElevationShadow must be in range [0.0 - 1.0]",
    );

    assert(
      _stockStyle.isNotNull
          ? _boughtCount.isNotNull && _stockCount.isNotNull
              ? _boughtCount! <= _stockCount!
              : false
          : true,
      'The stock setup must be in the correct format.',
    );

    return GestureDetector(
      onTap: widget.productPress,
      child: SizedBox(
        width: _width,
        child: Stack(
          children: [
            Container(
              width: _width,
              margin: EdgeInsets.only(top: _enableMarginHeight),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(_radius),
                color: Theme.of(context).cardColor,
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context)
                        .shadowColor
                        .withOpacity(widget.productConfigStyle.elevationShadow),
                    blurRadius: widget.productConfigStyle.blurRadius,
                  )
                ],
              ),
              child: _renderBody(),
            ),
            if (_isLiked.isNotNull)
              Positioned(
                top: _enableMarginHeight,
                left: _width - (_isLiked ?? false ? 35 : 30),
                child: AnimatedFavorite(
                  radius: _radius,
                  onPress: widget.favoritePress ?? () async {},
                  isLiked: _isLiked ?? false,
                ),
              ),
            if (_discount.isNotNull && _discount! > 0)
              Positioned(
                top: _enableMarginHeight,
                child: CornerBanner(
                  bannerPosition:
                      widget.productConfigStyle.cornerBannerPosition ??
                          CornerBannerPosition.topLeft,
                  bannerColor: _bColor,
                  shadowColor: Colors.black.withOpacity(0.8),
                  elevation: widget.productConfigStyle.elevationBanner ?? 5.0,
                  child: Text(
                    '- ${(_discount! * 100)}%',
                    style: context.titleSmall.copyWith(
                      color: _bColor.fontColorByBackground,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Column _renderBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: _aspectRatio,
          child: ClipRRect(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(_radius),
              bottom: const Radius.circular(2.0),
            ),
            child: ImageCustom(
              imageUrl: widget.productData.image,
              isNetworkImage: true,
              width: double.infinity,
              height: double.infinity,
              isSkelton: true,
            ),
          ),
        ),
        Padding(
          padding: widget.productConfigStyle.padding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.productData.header,
                maxLines: widget.productConfigStyle.headerMaxLines,
                style: widget.productConfigStyle.headerStyle,
              ),
              if (_price.isNotNull)
                priceDisplay(price: _price ?? 0.0, discount: _discount),
              if (_rating.isNotNull)
                ratting(
                  ratingPercent: widget.productData.ratting ?? 5.0,
                ),
              if (_stockStyle.isNotNull)
                stockDisplay(
                  stockStyle: _stockStyle ?? StockStyle.text,
                  boughtCount: _boughtCount ?? 100,
                  stockCount: _stockCount ?? 100,
                ),
              if (widget.addToCartPress.isNotNull) ...<Widget>[
                const SizedBox(),
                addToCartButton(
                  onPress: widget.addToCartPress,
                  radius: _radius,
                ),
              ],
            ].expand((e) => [e, const SizedBox(height: 5.0)]).toList()
              ..removeLast(),
          ),
        )
      ],
    );
  }
}
