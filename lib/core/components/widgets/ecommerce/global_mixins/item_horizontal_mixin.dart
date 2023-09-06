import 'package:flutter/material.dart';

mixin ItemHorizontalMixin<T extends StatefulWidget, I extends Widget>
    on State<T> {
  Widget displayItem<D>({
    required I Function(D data) itemBuilder,
    required double spacingFromHeader,
    required double spacingItem,
    required List<D> listItem,
  }) =>
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: <Widget>[
            SizedBox(width: spacingFromHeader),
            ...listItem
                .map((e) => itemBuilder(e))
                .expand((e) => [e, SizedBox(width: spacingItem)]),
          ],
        ),
      );

  Widget loadingRender({
    required bool typeOfBody,
    required double spacingItem,
  }) {
    if (typeOfBody) {}
    return const SizedBox();
  }
}
