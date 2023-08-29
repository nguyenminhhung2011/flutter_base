import 'package:expansion_widget/expansion_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/color_extension.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/widget_exetions.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/ecommerce/product/mixins/product_mixin.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/image_custom.dart';
import 'package:super_banners/super_banners.dart';

import '../index.dart' show AnimatedFavorite;
import '../product_config/product_config_style.dart';
import '../product_config/product_data.dart';

class ProductHorizontalCard<T> extends StatefulWidget {
  ///[All setup style]
  final ProductConfigStyle productConfigStyle;

  ///[Data]
  final ProductData productData;

  ///[Function] call to parent widget
  final Future Function()? favoritePress;

  final Future Function()? addToCartPress;

  final Function()? productPress;

  final Widget Function(T?)? bottomItem;

  final Future<T?> Function()? getBottomItem;

  const ProductHorizontalCard({
    super.key,
    this.bottomItem,
    this.productPress,
    this.getBottomItem,
    this.favoritePress,
    this.addToCartPress,
    required this.productData,
    required this.productConfigStyle,
  });

  @override
  State<ProductHorizontalCard<T>> createState() =>
      _ProductHorizontalCardState<T>();
}

class _ProductHorizontalCardState<T> extends State<ProductHorizontalCard<T>>
    with ProductMixin {
  final _globalKey = GlobalKey();

  bool _loading = false;

  T? _data;

  double _positionedWidth = 0;

  double _positionedTop = 0;

  bool get _isRightImage => widget.productConfigStyle.isRightImage;

  double get _radius => widget.productConfigStyle.radius;

  double get _aspectRatio => widget.productConfigStyle.aspectRatio;

  double? get _rating => widget.productData.ratting;

  bool? get _isLiked => widget.productData.isLikedProduct;

  Color get _bColor =>
      widget.productConfigStyle.bannerColor ?? Theme.of(context).primaryColor;

  // Data
  double? get _discount => widget.productData.discount;

  double? get _price => widget.productData.price;

  // double get _enableMarginHeight =>
  //     widget.productConfigStyle.enableMarginHeight ?? 0.0;

  StockStyle? get _stockStyle => widget.productConfigStyle.stockStyle;

  int? get _boughtCount => widget.productData.boughtCount;

  int? get _stockCount => widget.productData.stockCount;

  String? get _description => widget.productData.description;

  ///[Function support for show [another result, show shop]]

  void _onGetBottomItem(
      dynamic Function({bool animated}) toggleFunction, bool isExpand) async {
    if (_loading) {
      return;
    }
    if (widget.getBottomItem.isNotNull) {
      toggleFunction(animated: true);
      if (isExpand) {
        return;
      }
      _loading = true;
      setState(() {});
      _data = await widget.getBottomItem!.call();
      _loading = false;
      if (!mounted) return;
      setState(() {});
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _positionedWidth = _globalKey.currentContext?.size?.width ?? 100.0;
        _positionedTop = _globalKey.currentContext?.size?.height ?? 100.0;
      });
    });
    super.initState();
  }

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
    final listWidgetShow = <Widget>[
      _renderImage(),
      const SizedBox(width: 5.0),
      _renderBody()
    ];
    if (_isRightImage) {
      listWidgetShow.reversed;
    }
    return GestureDetector(
      onTap: widget.productPress,
      behavior: HitTestBehavior.opaque,
      child: ExpansionWidget(
        initiallyExpanded: false,
        content: _renderBottomItem(),
        titleBuilder: (double animationValue, double easeInValue,
            bool isExpanded, toggleFunction) {
          return Stack(
            children: [
              Container(
                key: _globalKey,
                width: context.widthDevice,
                padding: widget.productConfigStyle.padding,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(_radius),
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor.withOpacity(
                          widget.productConfigStyle.elevationShadow),
                      blurRadius: widget.productConfigStyle.blurRadius,
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[...listWidgetShow],
                ),
              ),
              if (_isLiked.isNotNull)
                Positioned(
                  left: _positionedWidth - (_isLiked ?? false ? 33 : 30),
                  child: AnimatedFavorite(
                    radius: _radius,
                    onPress: widget.favoritePress ?? () async {},
                    isLiked: _isLiked ?? false,
                  ),
                ),
              if (_discount.isNotNull && _discount! > 0)
                CornerBanner(
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
              if (widget.getBottomItem.isNotNull)
                Positioned(
                  top: _positionedTop - 20.0,
                  child: GestureDetector(
                    onTap: () => _onGetBottomItem(toggleFunction, isExpanded),
                    child: Container(
                      height: 20.0,
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Theme.of(context).hintColor.withOpacity(0.3),
                              Theme.of(context).hintColor.withOpacity(0.4),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(_radius),
                            topRight: const Radius.circular(5.0),
                          )),
                      child: Center(
                        child: Text(
                          widget.productConfigStyle.showBottomText,
                          style: context.titleSmall.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 12.0,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _renderBottomItem() => _loading
      ? const Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: CircularProgressIndicator())
      : widget.bottomItem?.call(_data) ?? const SizedBox();

  Expanded _renderImage() {
    return Expanded(
      flex: 3,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(_radius)),
        child: AspectRatio(
          aspectRatio: _aspectRatio,
          child: ImageCustom(
            imageUrl: widget.productData.image,
            isNetworkImage: true,
            isSkelton: true,
            width: double.infinity,
            height: 100.0,
          ),
        ),
      ),
    );
  }

  Expanded _renderBody() {
    return Expanded(
      flex: 6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.productData.header,
            maxLines: widget.productConfigStyle.headerMaxLines,
            style: widget.productConfigStyle.headerStyle,
          ),
          if (_description?.isNotEmpty ?? false)
            descriptionDisplay(
              description: _description ?? '',
              descriptionStyle: widget.productConfigStyle.descriptionStyle,
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
    );
  }
}
