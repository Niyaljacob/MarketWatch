import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_watch/bloc/get_server_data/get_server_data_bloc.dart';
import 'package:market_watch/utils/constants.dart';
import 'package:market_watch/view/home/widget/custom_snack_bar.dart';
import 'package:market_watch/bloc/bloc/local_stock_data_bloc.dart';
import 'package:market_watch/view/home/widget/snakbar.dart';

class StockGridView extends StatelessWidget {
  final TextEditingController searchController;

  const StockGridView({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GetServerDataBloc, GetServerDataState>(
      listener: (context, state) {
        // Handle any state-specific side effects here if needed
      },
      builder: (context, state) {
        if (state is GetServerDataLoaded) {
          if (searchController.text.isEmpty) {
            return searchLottie;
          }
          return GridView.builder(
            itemCount: state.data.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 1.2,
            ),
            padding: const EdgeInsets.all(8),
            itemBuilder: (context, index) {
              final data = state.data[index];
              return Container(
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: greyOpacity,
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
                          color: black87,
                        ),
                      ),
                    ),
                    Text(
                      'Stock rate: ₹${data.stockPrice}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: blueGrey,
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
                        icon: const Icon(Icons.library_add_check, color: primary),
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
                                primary,
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
          return Center(child: Text(state.errorMsg));
        } else if (state is GetServerDataLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetServerDataInitial) {
          return searchLottie;
        }
        return searchLottie;
      },
    );
  }
}
