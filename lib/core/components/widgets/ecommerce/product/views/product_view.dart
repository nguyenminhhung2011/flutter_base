import 'package:flutter/material.dart';

import '../mixins/product_mixin.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> with ProductMixin {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
