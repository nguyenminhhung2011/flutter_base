import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/home/views/home_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/overview/view/overview_screen.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/plan/views/plan_screen.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/components/constant/image_const.dart';

part 'dashboard_state.dart';

part 'dashboard_event.dart';

@injectable
class DashboardMobileBloc
    extends Bloc<DashBoarMobileEvent, DashboardMobileState> {
  DashboardMobileBloc()
      : super(
          DashboardInitial(<TabBarModel>[
            TabBarModel(
              svgAsset: ImageConst.homeIcon,
              title: 'Home',
              screen: const HomeScreen(),
            ),
            TabBarModel(
              svgAsset: ImageConst.searchIcon,
              title: 'Search',
              screen: const OverviewScreen(),
            ),
            TabBarModel(
              svgAsset: ImageConst.documentIcon,
              title: 'Plan',
              screen: const PlanScreen(),
            ),
            TabBarModel(svgAsset: ImageConst.personIcon, title: 'Profile')
          ], 0, true),
        ) {
    on<ChangeTabEvent>(_onChangeTab);
    on<ChangeShowMenuEvent>(_onChangeShoeMenu);
  }

  FutureOr<void> _onChangeTab(
    ChangeTabEvent event,
    Emitter<DashboardMobileState> emit,
  ) {
    emit(ChangeTab(state.tabItems, event.index, state.isShowMenu));
  }

  FutureOr<void> _onChangeShoeMenu(
    ChangeShowMenuEvent event,
    Emitter<DashboardMobileState> emit,
  ) {
    emit(ChangeShowMenu(state.tabItems, state.index, !state.isShowMenu));
  }
}
