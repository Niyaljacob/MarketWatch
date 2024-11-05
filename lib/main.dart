import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_watch/bloc/bloc/local_stock_data_bloc.dart';
import 'package:market_watch/bloc/get_server_data/get_server_data_bloc.dart';
import 'package:market_watch/view/splash/screen_splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetServerDataBloc(),
        ),
        BlocProvider(
          create: (context) => LocalStockDataBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         
        ),
        home: const SplashScreen()
      ),
    );
  }
}

