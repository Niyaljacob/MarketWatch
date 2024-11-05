
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


//colors
const primary = Color(0xFF0C3452);
const white = Colors.white;
var grey300= Colors.grey.shade300;
var greyOpacity = Colors.grey.withOpacity(0.2);
const black87 = Colors.black87;
const blueGrey = Colors.blueGrey;


//lottie

var searchLottie= Center(
                  child: Lottie.asset(
                'assets/stock_search.json',
                width: 300,
                height: 300,
                fit: BoxFit.fill
              ));