import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:market_watch/bloc/bloc/local_stock_data_bloc.dart';
import 'package:market_watch/view/home/widget/custom_snack_bar.dart';
import 'package:market_watch/view/home/widget/snakbar.dart';

class ScreenWatchList extends StatelessWidget {
  const ScreenWatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Watchlist',
          style: TextStyle(color: Color(0xFF0C3452), fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => LocalStockDataBloc()..add(LoadLocalData()),
        child: BlocConsumer<LocalStockDataBloc, LocalStockDataState>(
          listener: (context, state) {
            if (state is LocalStockDataAdded) {
              context.read<LocalStockDataBloc>().add(LoadLocalData()); // Reload data after addition
            }
          },
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<LocalStockDataBloc>().add(LoadLocalData());
              },
              child: Builder(
                builder: (context) {
                  if (state is LocalStockDataLoaded) {
                    if (state.data.isEmpty) {
                      return Center(
                  child: Lottie.asset(
                'assets/stock_search.json',
                width: 300,
                height: 300,
                fit: BoxFit.fill
              ));
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
                                  icon: const Icon(Icons.delete, color: Color(0xFF0C3452)),
                                  onPressed: () {
                                    styleAlertDialog(
                                      context: context,
                                      title: 'Remove',
                                      message: 'Remove from watchlist',
                                      firstButtonAction: () => Navigator.pop(context),
                                      firstButtonText: 'Cancel',
                                      secondButtonAction: () {
                                        context.read<LocalStockDataBloc>().add(DeleteData(data.id!));
                                        customSnackbar(context, 'Removed from watchlist', 'The stock was removed from the watchlist', const Color(0xFF0C3452));
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
        ),
      ),
    );
  }
}
