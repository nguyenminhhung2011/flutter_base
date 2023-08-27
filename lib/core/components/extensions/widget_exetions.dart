import 'package:flutter/material.dart';

extension WidgetExtension on Object? {
  bool get isNotNull => this != null;

  Widget? renderWidgetNull(Widget init) => isNotNull ? init : null;

  Widget? renderWidgetSizedBox(Widget init) =>
      isNotNull ? init : const SizedBox();
}
