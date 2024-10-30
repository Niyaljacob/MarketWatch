
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:market_watch/view/bottom_nav/main_bottom.dart';

CurvedNavigationBar bottomNav(BuildContext context) {
  return CurvedNavigationBar(
    index: 0,
    height: 60.0,
    items: const <Widget>[
      Icon(Icons.home, size: 30, color: Colors.amber),
      Icon(Icons.notification_add, size: 30, color: Colors.amber),
    ],
    color: Theme.of(context).brightness == Brightness.light ? Colors.amber : Colors.amber,
    buttonBackgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
    backgroundColor: Theme.of(context).brightness == Brightness.light ? Colors.white : Colors.black,
    animationCurve: Curves.easeInOut,
    animationDuration: const Duration(milliseconds: 600),
    onTap: (index) {
      currentPage.value = index;
    },
  );
}