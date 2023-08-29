class ProductData {
  /// [Required value]
  final String image;

  final String header;

  /// [Not required value]
  final String? description;

  final bool? isLikedProduct;

  final double? ratting;

  final double? discount;

  final double? price;

  final int? boughtCount;

  final int? stockCount;

  ProductData({
    this.price,
    this.ratting,
    this.discount,
    this.stockCount,
    this.description,
    this.boughtCount,
    this.isLikedProduct,
    required this.image,
    required this.header,
  });
}
