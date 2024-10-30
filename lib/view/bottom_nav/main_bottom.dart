
import 'package:flutter/material.dart';
import 'package:market_watch/view/bottom_nav/widget/bottomnav.dart';
import 'package:market_watch/view/home/screen_home.dart';
import 'package:market_watch/view/watch_list/screen_watch_list.dart';

final ValueNotifier<int> currentPage = ValueNotifier(0);
class BottomNavFirstPage extends StatelessWidget {
   BottomNavFirstPage({super.key});

  final List<Widget>pages=[
    const ScreenHome(),
     const ScreenWatchList(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => IndexedStack(
          index: value,
          children: pages,
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<int>(
        valueListenable: currentPage,
        builder: (context, value, child) => bottomNav(context),
      ),
    );
  }
}