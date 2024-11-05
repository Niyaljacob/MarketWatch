import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:market_watch/bloc/bloc/local_stock_data_bloc.dart';
import 'package:market_watch/bloc/get_server_data/get_server_data_bloc.dart';
import 'package:market_watch/utils/colors.dart';
import 'package:market_watch/view/home/widget/custom_snack_bar.dart';
import 'package:market_watch/view/home/widget/snakbar.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});

  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
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
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
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
                    controller: _searchController,
                    decoration: const InputDecoration(
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
          child: BlocConsumer<GetServerDataBloc, GetServerDataState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is GetServerDataLoaded) {
            if (_searchController.text.isEmpty) {
              return Center(
                  child: Lottie.asset(
                'assets/stock_search.json',
                width: 300,
                height: 300,
                fit: BoxFit.fill
              ));
            }
            return _searchController.text.isEmpty
                ? Center(
                  child: Lottie.asset(
                'assets/stock_search.json',
                width: 300,
                height: 300,
                fit: BoxFit.fill
              ))
                : GridView.builder(
                    itemCount: state.data.length,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // Adjust to have two items per row
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio:
                          1.2, // Adjust to control card proportions
                    ),
                    padding: const EdgeInsets.all(8),
                    itemBuilder: (context, index) {
                      final data = state.data[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                data.companyName,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            Text(
                              'Stock rate: ₹${data.stockPrice}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blueGrey,
                              ),
                            ),
                            const Divider(
                              height: 10,
                              thickness: 1,
                              indent: 20,
                              endIndent: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: IconButton(
                                icon: const Icon(Icons.library_add_check,
                                    color: Color(0xFF0C3452)),
                                onPressed: () {
                                  styleAlertDialog(
                                    context: context, 
                                    title: 'Add',
                              message: 'Add to watchlist',
                              firstButtonAction: () => Navigator.pop(context),
                              firstButtonText: 'Cancel',
                              secondButtonAction: () {
                                context.read<LocalStockDataBloc>().add(AddData(data));
                                customSnackbar(
                                  context,
                                  'Added to watchlist',
                                  'The stock added in watchlist',
                                  Colors.green,
                                );
                                Navigator.pop(context);
                              },
                              secondButtonText: 'Add',
                                    );
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
          } else if (state is GetServerDataFailed) {
            return Center(
              child: Text(state.errorMsg),
            );
          } else if (state is GetServerDataLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GetServerDataInitial) {
            return Center(
                  child: Lottie.asset(
                'assets/stock_search.json',
                width: 300,
                height: 300,
                fit: BoxFit.fill
              ));
          }
          return Center(
                  child: Lottie.asset(
                'assets/stock_search.json',
                width: 300,
                height: 300,
                fit: BoxFit.fill
              ));
        },
      )),
    );
  }
}
