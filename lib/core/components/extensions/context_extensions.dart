import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  double get widthDevice => MediaQuery.of(this).size.width;
  double get heightDevice => MediaQuery.of(this).size.height;
  //bool
  bool get canPop => Navigator.maybeOf(this)?.canPop() ?? false;

  // text

  TextStyle get headerStyle => Theme.of(this).textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
      );
  TextStyle get timeStyle => Theme.of(this).textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
      );
  TextStyle get textStyle => Theme.of(this).textTheme.titleMedium!.copyWith(
        fontWeight: FontWeight.w600,
        color: Theme.of(this).primaryColor,
        fontFamily: 'Montserrat',
      );
  TextStyle get subTextStyle => textStyle.copyWith(
        fontWeight: FontWeight.w400,
        fontFamily: 'Montserrat',
      );

  TextStyle get primaryMediumText =>
      Theme.of(this).textTheme.titleMedium!.copyWith(
            color: Theme.of(this).primaryColor,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w600,
          );

  TextStyle get headlineMedium =>
      Theme.of(this).textTheme.headlineMedium!.copyWith(
            fontFamily: 'Montserrat',
          );
  TextStyle get headlineLarge =>
      Theme.of(this).textTheme.headlineLarge!.copyWith(
            fontFamily: 'Montserrat',
          );
  TextStyle get headlineSmall =>
      Theme.of(this).textTheme.headlineSmall!.copyWith(
            fontFamily: 'Montserrat',
          );

  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!.copyWith(
        fontFamily: 'Montserrat',
      );
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!.copyWith(
        fontFamily: 'Montserrat',
      );
  TextStyle get titleLarge => Theme.of(this).textTheme.titleLarge!.copyWith(
        fontFamily: 'Montserrat',
      );

  TextStyle get headerAppBarTextStyle =>
      Theme.of(this).textTheme.titleMedium!.copyWith(
            fontWeight: FontWeight.bold,
            color: Theme.of(this).scaffoldBackgroundColor,
            fontFamily: 'Montserrat',
          );

  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!.copyWith(
        fontFamily: 'Montserrat',
      );
}
