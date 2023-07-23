import 'package:flutter/material.dart';
import 'package:flutter_base_clean_architecture/clean_architectures/presentation/dashboard/bloc/dashboard_bloc.dart';
import 'package:flutter_base_clean_architecture/core/components/widgets/tab_bar/tab_bar_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/widgets/tab_bar/tab_bar_type.dart';
import '../../../../core/components/widgets/tab_bar/tabbar_custom.dart';

class DashboardSCreen extends StatefulWidget {
  const DashboardSCreen({super.key});

  @override
  State<DashboardSCreen> createState() => _DashboardSCreenState();
}

class _DashboardSCreenState extends State<DashboardSCreen> {
  DashboardMobileBloc get _bloc => context.read<DashboardMobileBloc>();
  List<TabBarModel> _tabs = <TabBarModel>[];
  @override
  void initState() {
    _tabs = _bloc.state.tabItems.map((e) => e).toList();

    super.initState();
  }

  void _onTabChange(int index) {
    if (_bloc.state.index != index) {
      _bloc.add(ChangeTabEvent(
        index,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardMobileBloc, DashboardMobileState>(
      builder: (context, state) {
        return Scaffold(
          extendBody: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          bottomNavigationBar: TabBarCustom(
            radius: 5.0,
            elevation: 0.1, // => elevation
            tabBarType: TabBarType
                .animationTabBar, //if you want display test change to textTabBar
            // tabBarColor: Colors.black,
            iconSize: 23.0,
            iconSelectedColor: Theme.of(context).primaryColor,
            duration: 200, // => set animation when change tab
            isSvgIcon: true,
            animatedTabStyle: const AnimatedTabStyle(posHeight: 5),
            items: <TabBarItemStyle>[
              ...state.tabItems.map(
                (e) => TabBarItemStyle(
                  title: e.title,
                  assetIcon: e.svgAsset,
                  iconData: e.iconData,
                  screen: e.screen,
                ),
              ),
            ],
            onChangeTab: _onTabChange,
          ),
          body: IndexedStack(
            index: state.index,
            sizing: StackFit.expand,
            children: _tabs.map((e) => e.screen).toList(),
          ),
        );
      },
    );
  }
}
