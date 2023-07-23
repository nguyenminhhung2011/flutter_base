import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/core/components/extensions/context_extensions.dart';

import '../../../../generated/l10n.dart';

class HeaderTextCustom extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final String headerText;
  final TextStyle? textStyle;
  final Widget? widget;
  final bool isShowSeeMore;
  final Function()? onPress;
  const HeaderTextCustom({
    super.key,
    this.padding,
    this.textStyle,
    this.isShowSeeMore = false,
    required this.headerText,
    this.onPress,
    this.widget,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 15.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              headerText,
              style: textStyle ??
                  context.titleLarge.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
          if (widget != null) widget!,
          if (isShowSeeMore)
            TextButton(
              onPressed: onPress ?? () {},
              child: Text(
                S.of(context).seeMore,
                style: context.titleSmall.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
        ],
      ),
    );
  }
}
