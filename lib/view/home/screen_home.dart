import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_watch/bloc/bloc/get_server_data_bloc.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: AppBar(
          title: const Text(
                'Market Watch',
                style: TextStyle(
                  color: Color(0xFF0C3452),
                  fontSize: 29,
                  fontWeight: FontWeight.bold,
                ),
              ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: TextField(
                    onChanged: (value) => context.read<GetServerDataBloc>().add(LoadServerData(value)),
                    controller: _searchController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.search, color: Color(0xFF0C3452)),
                      hintText: 'Search stocks...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          
        ),
      ),
    );
  }
}
