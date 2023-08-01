import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/bill/views/bills_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/bill_detail/view/bill_detail_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/budget_detail/views/budget_detail.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/events/views/events_screen.dart';
import 'package:flutter_base_clean_architecture/routes/routes.dart';

import '../clean_architectures/presentation/budget/views/budget_screen.dart';
import '../clean_architectures/presentation/dashboard/views/dashboard_screen.dart';
import '../clean_architectures/presentation/tes_ui/views/test_ui.dart';

class MainRoutes {
  static Map<String, WidgetBuilder> getRoutesWithSettings() {
    final routes = {Routes.auth: (context) => const SizedBox()};
    return routes;
  }

  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.auth:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const SizedBox();
          },
        );
      case Routes.budgets:
        return _createRoute(const BudgetScreen(), curvesIn: Curves.linear);
      case Routes.bills:
        return _createRoute(const BillScreen(), curvesIn: Curves.linear);
      case Routes.billDetail:
        return _createRoute(const BillDetailScreen(), curvesIn: Curves.linear);
      case Routes.events:
        return _createRoute(const EventsSCreen(), curvesIn: Curves.linear);
      case Routes.budgetDetail:
        final arguments = settings.arguments;
        return _createRoute(
          arguments is int
              ? BudgetDetail(heroIndex: arguments)
              : const SizedBox(),
          curvesIn: Curves.linear,
          // begin: const Offset(0, 1.0),
        );
      case Routes.testUi:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const TestUi();
          },
        );
      case Routes.dashboard:
        return MaterialPageRoute(
          settings: settings,
          builder: (_) {
            return const DashboardSCreen();
          },
        );

      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute([String message = 'Page not founds']) {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: Center(
            child: Text(message),
          ),
        );
      },
    );
  }
}

Route _createRoute(
  Widget widget, {
  Curve curvesIn = Curves.linear,
  Tween? tweenC,
  Offset begin = const Offset(1.0, 0.0),
  Offset end = Offset.zero,
}) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 400),
    reverseTransitionDuration: const Duration(milliseconds: 400),
    pageBuilder: (context, animation, secondaryAnimation) => widget,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curve = curvesIn;

      var tween = tweenC?.chain(CurveTween(curve: curve)) ??
          Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween as Animatable<Offset>),
        child: child,
      );
    },
  );
}
