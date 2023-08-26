import 'package:flutter/material.dart';

import '../mixins/product_mixin.dart';
import '../index.dart' show AnimatedFavorite;

class ProductCardView extends StatefulWidget {
  const ProductCardView({super.key});

  @override
  State<ProductCardView> createState() => _ProductCardViewState();
}

class _ProductCardViewState extends State<ProductCardView> with ProductMixin {
  bool _check = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedFavorite(
          onPress: () async {
            // await Future.delayed(const Duration(seconds: 3));
            setState(() {
              _check = !_check;
            });
          },
          isLiked: _check,
        ),
      ],
    );
  }
}
