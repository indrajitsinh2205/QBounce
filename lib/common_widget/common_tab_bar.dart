import 'package:flutter/material.dart';

import '../constant/app_color.dart';


class CommonTabBar extends StatefulWidget {
  final int initialIndex;
  final List<String> tabTitles;
  final bool Box;
  final TabController controller;  // The controller is passed here

  const CommonTabBar({
    super.key,
    required this.initialIndex,
    required this.tabTitles,
    required this.Box,
    required this.controller,  // Pass TabController from the parent widget
  });

  @override
  _CommonTabBarState createState() => _CommonTabBarState();
}

class _CommonTabBarState extends State<CommonTabBar> {
  @override
  void initState() {
    super.initState();
    // No need to initialize tabController anymore because it's passed from parent
    widget.controller.addListener(() {
      if (widget.controller.indexIsChanging) {
        FocusScope.of(context).requestFocus(FocusNode());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          padding: EdgeInsets.all(1),
          controller: widget.controller,
          splashFactory: NoSplash.splashFactory,
          indicatorColor: AppColors.appColor,
          indicator: widget.Box
              ? BoxDecoration(
            color: AppColors.appColor,
            borderRadius: BorderRadius.circular(10),
          )
              : null,
          // // indicatorPadding: EdgeInsets.zero,
          dividerColor: Colors.transparent,
          indicatorWeight: 3.0,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: AppColors.whiteColor,
          unselectedLabelColor: Colors.white,
          labelStyle: TextStyle(
            fontSize: 11.0,
            fontWeight: FontWeight.w600,
          ),
          tabs: widget.tabTitles
              .map((title) => Tab(text: title))
              .toList(),
        ),
      ],
    );
  }

  @override
  void dispose() {
    // Do not dispose of the TabController here, as it's passed from the parent
    super.dispose();
  }
}
