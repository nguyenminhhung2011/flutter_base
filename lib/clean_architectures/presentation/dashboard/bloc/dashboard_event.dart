part of 'dashboard_bloc.dart';

@immutable
abstract class DashBoarMobileEvent {
  const DashBoarMobileEvent();
}

class ChangeTabEvent extends DashBoarMobileEvent {
  final int index;
  const ChangeTabEvent(this.index);
}

class ChangeShowMenuEvent extends DashBoarMobileEvent {
  const ChangeShowMenuEvent();
}
