import 'dart:ui';

class ProductConfigStyle {
  /// [Required value]
  final String image;

  final String header;

  /// [Support default value]
  final double radius;

  final double width;

  final double elevationShadow;

  ///[Not required but update later]
  final TextStyle? headerStyle;

  /// [Not required value]
  final bool? isLikedProduct;

  final double? ratting;
  ProductConfigStyle({
    this.radius = 5.0,
    this.width = 150.0,
    this.elevationShadow = 0.0,
    this.ratting,
    this.headerStyle,
    this.isLikedProduct,
    required this.image,
    required this.header,
  });
}
