import 'package:flutter/material.dart';
import 'package:market_watch/view/home/widget/appbar.dart';
import 'package:market_watch/view/home/widget/grid_view.dart';


class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, _searchController),
      body: SafeArea(
          child: StockGridView(searchController: _searchController),
      ),
    );
  }
}
