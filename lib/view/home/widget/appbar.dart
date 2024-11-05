import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_watch/bloc/get_server_data/get_server_data_bloc.dart';
import 'package:market_watch/utils/constants.dart';

PreferredSize buildAppBar(BuildContext context, TextEditingController searchController) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(140),
    child: AppBar(
      title: const Text(
        'Market Watch',
        style: TextStyle(
          color: primary,
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
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: grey300),
                boxShadow: [
                  BoxShadow(
                    color: greyOpacity,
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextField(
                onChanged: (value) => context
                    .read<GetServerDataBloc>()
                    .add(LoadServerData(value)),
                controller: searchController,
                decoration: const InputDecoration(
                  icon: Icon(Icons.search, color: primary),
                  hintText: 'Search stocks...',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );
}
