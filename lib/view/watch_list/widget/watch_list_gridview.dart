
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:market_watch/bloc/bloc/local_stock_data_bloc.dart';
import 'package:market_watch/utils/constants.dart';
import 'package:market_watch/view/home/widget/custom_snack_bar.dart';
import 'package:market_watch/view/home/widget/snakbar.dart';

class WatchlistWidget extends StatelessWidget {
  const WatchlistWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalStockDataBloc, LocalStockDataState>(
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            context.read<LocalStockDataBloc>().add(LoadLocalData());
          },
          child: Builder(
            builder: (context) {
              if (state is LocalStockDataLoaded) {
                if (state.data.isEmpty) {
                  return searchLottie;
                }
                return GridView.builder(
                  itemCount: state.data.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Two items per row
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    childAspectRatio: 1.2, // Card proportions
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
                              icon: const Icon(Icons.delete, color: primary),
                              onPressed: () {
                                styleAlertDialog(
                                  context: context,
                                  title: 'Remove',
                                  message: 'Remove from watchlist',
                                  firstButtonAction: () => Navigator.pop(context),
                                  firstButtonText: 'Cancel',
                                  secondButtonAction: () {
                                    context.read<LocalStockDataBloc>().add(DeleteData(data.id!));
                                    customSnackbar(context, 'Removed from watchlist', 'The stock was removed from the watchlist', primary);
                                    context.read<LocalStockDataBloc>().add(LoadLocalData());
                                    Navigator.pop(context);
                                  },
                                  secondButtonText: 'Remove',
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else if (state is LocalStockDataLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is LocalStockDataFailed) {
                return const Center(
                  child: Text('Failed to load data'),
                );
              }
              return const Center(
                child: Text('An error occurred'),
              );
            },
          ),
        );
      },
    );
  }
}
