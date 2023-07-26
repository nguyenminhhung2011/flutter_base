// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `update`
  String get update {
    return Intl.message(
      'update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `See more`
  String get seeMore {
    return Intl.message(
      'See more',
      name: 'seeMore',
      desc: '',
      args: [],
    );
  }

  /// `Today`
  String get today {
    return Intl.message(
      'Today',
      name: 'today',
      desc: '',
      args: [],
    );
  }

  /// `Tomorrow`
  String get tomorrow {
    return Intl.message(
      'Tomorrow',
      name: 'tomorrow',
      desc: '',
      args: [],
    );
  }

  /// `Recent spend`
  String get recentSpend {
    return Intl.message(
      'Recent spend',
      name: 'recentSpend',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories {
    return Intl.message(
      'Categories',
      name: 'categories',
      desc: '',
      args: [],
    );
  }

  /// `Overview`
  String get overView {
    return Intl.message(
      'Overview',
      name: 'overView',
      desc: '',
      args: [],
    );
  }

  /// `Reports`
  String get reports {
    return Intl.message(
      'Reports',
      name: 'reports',
      desc: '',
      args: [],
    );
  }

  /// `This month`
  String get thisMonth {
    return Intl.message(
      'This month',
      name: 'thisMonth',
      desc: '',
      args: [],
    );
  }

  /// `Next month`
  String get nextMonth {
    return Intl.message(
      'Next month',
      name: 'nextMonth',
      desc: '',
      args: [],
    );
  }

  /// `This year`
  String get thisYear {
    return Intl.message(
      'This year',
      name: 'thisYear',
      desc: '',
      args: [],
    );
  }

  /// `Next year`
  String get nextYear {
    return Intl.message(
      'Next year',
      name: 'nextYear',
      desc: '',
      args: [],
    );
  }

  /// `Income money`
  String get incomeMoney {
    return Intl.message(
      'Income money',
      name: 'incomeMoney',
      desc: '',
      args: [],
    );
  }

  /// `Expense money`
  String get expenseMoney {
    return Intl.message(
      'Expense money',
      name: 'expenseMoney',
      desc: '',
      args: [],
    );
  }

  /// `Budgets`
  String get budgets {
    return Intl.message(
      'Budgets',
      name: 'budgets',
      desc: '',
      args: [],
    );
  }

  /// `InFlow`
  String get inFlow {
    return Intl.message(
      'InFlow',
      name: 'inFlow',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summary {
    return Intl.message(
      'Summary',
      name: 'summary',
      desc: '',
      args: [],
    );
  }

  /// `OutFlow`
  String get outFlow {
    return Intl.message(
      'OutFlow',
      name: 'outFlow',
      desc: '',
      args: [],
    );
  }

  /// `All`
  String get all {
    return Intl.message(
      'All',
      name: 'all',
      desc: '',
      args: [],
    );
  }

  /// `Events`
  String get event {
    return Intl.message(
      'Events',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Recurring`
  String get recurring {
    return Intl.message(
      'Recurring',
      name: 'recurring',
      desc: '',
      args: [],
    );
  }

  /// `Bills`
  String get bill {
    return Intl.message(
      'Bills',
      name: 'bill',
      desc: '',
      args: [],
    );
  }

  /// `View`
  String get view {
    return Intl.message(
      'View',
      name: 'view',
      desc: '',
      args: [],
    );
  }

  /// `Budgets`
  String get budget {
    return Intl.message(
      'Budgets',
      name: 'budget',
      desc: '',
      args: [],
    );
  }

  /// `Planning`
  String get planning {
    return Intl.message(
      'Planning',
      name: 'planning',
      desc: '',
      args: [],
    );
  }

  /// `View report`
  String get viewReport {
    return Intl.message(
      'View report',
      name: 'viewReport',
      desc: '',
      args: [],
    );
  }

  /// `Lend & loan`
  String get lendLoan {
    return Intl.message(
      'Lend & loan',
      name: 'lendLoan',
      desc: '',
      args: [],
    );
  }

  /// `Another features`
  String get anotherFeature {
    return Intl.message(
      'Another features',
      name: 'anotherFeature',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
