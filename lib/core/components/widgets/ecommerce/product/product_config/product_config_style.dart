import 'package:flutter/material.dart';
import 'package:super_banners/super_banners.dart';

enum StockStyle { text, linearPercent }

extension StockStyleExtensions on StockStyle {
  bool get isText => this == StockStyle.text;
}

class ProductConfigStyle {
  /// [Support default value]
  final double radius;

  final double width;

  final double elevationShadow;

  final double blurRadius;

  final EdgeInsets padding;

  final double aspectRatio;

  ///[Not required but update later]
  final TextStyle? headerStyle;

  final double? enableMarginHeight;

  ///[banner style] Set up banner style here

  final Color? bannerColor;

  final double? elevationBanner;

  final StockStyle? stockStyle;

  final CornerBannerPosition? cornerBannerPosition;

  late int headerMaxLines;

  ProductConfigStyle({
    this.stockStyle,
    this.bannerColor,
    this.headerStyle,
    this.elevationBanner,
    this.enableMarginHeight, 
    this.cornerBannerPosition,
    this.radius = 5.0,
    this.width = 150.0,
    this.blurRadius = 10.0,
    this.headerMaxLines = 2,
    this.aspectRatio = 7 / 10,
    this.elevationShadow = 0.0,
    this.padding = const EdgeInsets.all(5.0),
  });

  // void copyWith({
  //   double? radius,
  //   double? width,
  //   double? elevationShadow,
  //   TextStyle? headerStyle,
  //   double? aspectRatio,
  // }) {
  //   if (radius != null) {
  //     this.radius = radius;
  //   }
  //   if (width != null) {
  //     this.width = width;
  //   }
  //   if (elevationShadow != null) {
  //     this.elevationShadow = elevationShadow;
  //   }
  //   if (headerStyle != null) {
  //     this.headerStyle = headerStyle;
  //   }
  //   if (aspectRatio != null) {
  //     this.aspectRatio = aspectRatio;
  //   }
  // }
}
