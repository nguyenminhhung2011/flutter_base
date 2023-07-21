part of 'dashboard_bloc.dart';

abstract class DashboardMobileState extends Equatable {
  final List<TabBarModel> tabItems;
  final int index;
  final bool isShowMenu;

  const DashboardMobileState(
    this.tabItems,
    this.index,
    this.isShowMenu,
  );
}

class DashboardInitial extends DashboardMobileState {
  const DashboardInitial(
    List<TabBarModel> tabItems,
    int index,
    bool isShowMenu,
  ) : super(tabItems, index, isShowMenu);

  @override
  List<Object?> get props => [tabItems];
}

class ChangeTab extends DashboardInitial {
  const ChangeTab(super.tabItems, super.index, super.isShowMenu);

  @override
  List<Object?> get props => [index, isShowMenu];
}

class ChangeShowMenu extends DashboardInitial {
  const ChangeShowMenu(super.tabItems, super.index, super.isShowMenu);
  @override
  List<Object?> get props => [index, isShowMenu];
}
