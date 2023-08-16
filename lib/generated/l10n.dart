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

  /// `Budget categories`
  String get budgetsCategories {
    return Intl.message(
      'Budget categories',
      name: 'budgetsCategories',
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

  /// `Recent billing`
  String get recentBilling {
    return Intl.message(
      'Recent billing',
      name: 'recentBilling',
      desc: '',
      args: [],
    );
  }

  /// `Recent activity`
  String get recentActivity {
    return Intl.message(
      'Recent activity',
      name: 'recentActivity',
      desc: '',
      args: [],
    );
  }

  /// `Add new bill`
  String get addNewBill {
    return Intl.message(
      'Add new bill',
      name: 'addNewBill',
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

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Bill Detail`
  String get billDetail {
    return Intl.message(
      'Bill Detail',
      name: 'billDetail',
      desc: '',
      args: [],
    );
  }

  /// `Split now`
  String get splitNow {
    return Intl.message(
      'Split now',
      name: 'splitNow',
      desc: '',
      args: [],
    );
  }

  /// `Send Bill`
  String get sendBill {
    return Intl.message(
      'Send Bill',
      name: 'sendBill',
      desc: '',
      args: [],
    );
  }

  /// `add`
  String get add {
    return Intl.message(
      'add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `End`
  String get end {
    return Intl.message(
      'End',
      name: 'end',
      desc: '',
      args: [],
    );
  }

  /// `Add transaction`
  String get addTransactions {
    return Intl.message(
      'Add transaction',
      name: 'addTransactions',
      desc: '',
      args: [],
    );
  }

  /// `Nearest transactions`
  String get nearestTransaction {
    return Intl.message(
      'Nearest transactions',
      name: 'nearestTransaction',
      desc: '',
      args: [],
    );
  }

  /// `select`
  String get select {
    return Intl.message(
      'select',
      name: 'select',
      desc: '',
      args: [],
    );
  }

  /// `Discover Awesome Events!`
  String get discoverEvents {
    return Intl.message(
      'Discover Awesome Events!',
      name: 'discoverEvents',
      desc: '',
      args: [],
    );
  }

  /// `People`
  String get people {
    return Intl.message(
      'People',
      name: 'people',
      desc: '',
      args: [],
    );
  }

  /// `Current events`
  String get currentEvent {
    return Intl.message(
      'Current events',
      name: 'currentEvent',
      desc: '',
      args: [],
    );
  }

  /// `Total bills`
  String get totalBills {
    return Intl.message(
      'Total bills',
      name: 'totalBills',
      desc: '',
      args: [],
    );
  }

  /// `Empty`
  String get empty {
    return Intl.message(
      'Empty',
      name: 'empty',
      desc: '',
      args: [],
    );
  }

  /// `Event detail`
  String get eventDetail {
    return Intl.message(
      'Event detail',
      name: 'eventDetail',
      desc: '',
      args: [],
    );
  }

  /// `Split with`
  String get splitWith {
    return Intl.message(
      'Split with',
      name: 'splitWith',
      desc: '',
      args: [],
    );
  }

  /// `{no} peoples`
  String noPeoples(Object no) {
    return Intl.message(
      '$no peoples',
      name: 'noPeoples',
      desc: '',
      args: [no],
    );
  }

  /// `Budget limit`
  String get limit {
    return Intl.message(
      'Budget limit',
      name: 'limit',
      desc: '',
      args: [],
    );
  }

  /// `Budget detail`
  String get budgetDetail {
    return Intl.message(
      'Budget detail',
      name: 'budgetDetail',
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

  /// `Description`
  String get description {
    return Intl.message(
      'Description',
      name: 'description',
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

  /// `Transactions`
  String get transactions {
    return Intl.message(
      'Transactions',
      name: 'transactions',
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

  /// `Split Bill`
  String get splitBill {
    return Intl.message(
      'Split Bill',
      name: 'splitBill',
      desc: '',
      args: [],
    );
  }

  /// `Split Detail`
  String get splitDetail {
    return Intl.message(
      'Split Detail',
      name: 'splitDetail',
      desc: '',
      args: [],
    );
  }

  /// `View all`
  String get viewAll {
    return Intl.message(
      'View all',
      name: 'viewAll',
      desc: '',
      args: [],
    );
  }

  /// `Spent`
  String get spent {
    return Intl.message(
      'Spent',
      name: 'spent',
      desc: '',
      args: [],
    );
  }

  /// `Spent per day`
  String get spentPerDate {
    return Intl.message(
      'Spent per day',
      name: 'spentPerDate',
      desc: '',
      args: [],
    );
  }

  /// `Your Balance`
  String get yourBalance {
    return Intl.message(
      'Your Balance',
      name: 'yourBalance',
      desc: '',
      args: [],
    );
  }

  /// `of`
  String get of1 {
    return Intl.message(
      'of',
      name: 'of1',
      desc: '',
      args: [],
    );
  }

  /// `Remaining at this month`
  String get remainingAtThisMonth {
    return Intl.message(
      'Remaining at this month',
      name: 'remainingAtThisMonth',
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

  /// `Sort By`
  String get sortBy {
    return Intl.message(
      'Sort By',
      name: 'sortBy',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Languages`
  String get languages {
    return Intl.message(
      'Languages',
      name: 'languages',
      desc: '',
      args: [],
    );
  }

  /// `Currencies`
  String get currencies {
    return Intl.message(
      'Currencies',
      name: 'currencies',
      desc: '',
      args: [],
    );
  }

  /// `Appearance`
  String get appearance {
    return Intl.message(
      'Appearance',
      name: 'appearance',
      desc: '',
      args: [],
    );
  }

  /// `Log in`
  String get logIn {
    return Intl.message(
      'Log in',
      name: 'logIn',
      desc: '',
      args: [],
    );
  }

  /// `Log out`
  String get logOut {
    return Intl.message(
      'Log out',
      name: 'logOut',
      desc: '',
      args: [],
    );
  }

  /// `Dark theme`
  String get darkTheme {
    return Intl.message(
      'Dark theme',
      name: 'darkTheme',
      desc: '',
      args: [],
    );
  }

  /// `Light theme`
  String get lightTheme {
    return Intl.message(
      'Light theme',
      name: 'lightTheme',
      desc: '',
      args: [],
    );
  }

  /// `Notifications`
  String get notifications {
    return Intl.message(
      'Notifications',
      name: 'notifications',
      desc: '',
      args: [],
    );
  }

  /// `Code and fingerprint`
  String get codeAndFingerPrints {
    return Intl.message(
      'Code and fingerprint',
      name: 'codeAndFingerPrints',
      desc: '',
      args: [],
    );
  }

  /// `Lock and Security`
  String get lockAndSecurity {
    return Intl.message(
      'Lock and Security',
      name: 'lockAndSecurity',
      desc: '',
      args: [],
    );
  }

  /// `General settings`
  String get generalSettings {
    return Intl.message(
      'General settings',
      name: 'generalSettings',
      desc: '',
      args: [],
    );
  }

  /// `By Price`
  String get byPrice {
    return Intl.message(
      'By Price',
      name: 'byPrice',
      desc: '',
      args: [],
    );
  }

  /// `Enter code`
  String get enterCode {
    return Intl.message(
      'Enter code',
      name: 'enterCode',
      desc: '',
      args: [],
    );
  }

  /// `Error code`
  String get errorCode {
    return Intl.message(
      'Error code',
      name: 'errorCode',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about {
    return Intl.message(
      'About',
      name: 'about',
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
      Locale.fromSubtags(languageCode: 'vi'),
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
