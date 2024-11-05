import 'package:flutter/material.dart';
import 'package:market_watch/utils/constants.dart';
import 'package:market_watch/view/watch_list/widget/watch_list_gridview.dart';

class ScreenWatchList extends StatelessWidget {
  const ScreenWatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Watchlist',
          style: TextStyle(color: primary, fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body:const WatchlistWidget(),
    );
  }
}
