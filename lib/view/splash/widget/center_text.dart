import 'package:flutter/material.dart';
import 'package:market_watch/utils/constants.dart';

class CenterText extends StatelessWidget {
  const CenterText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Market Watch', style: TextStyle(color: primary, fontSize: 29, fontWeight: FontWeight.bold),));
  }
}
