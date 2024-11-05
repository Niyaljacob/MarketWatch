// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:market_watch/model/company_model.dart';
import 'package:market_watch/model/data_model.dart';

import '../../data/repository/watch_list_fun.dart';

part 'local_stock_data_event.dart';
part 'local_stock_data_state.dart';

class LocalStockDataBloc extends Bloc<LocalStockDataEvent, LocalStockDataState> {
  LocalStockDataBloc() : super(LocalStockDataInitial()) {
    on<LoadLocalData>(_onLoadLocalData);
    on<DeleteData>(_onDeleteData);
    on<AddData>(_onAddData);
  }

  // Load local data event handler
  void _onLoadLocalData(LoadLocalData event, Emitter<LocalStockDataState> emit) async {
    try {
      emit(LocalStockDataLoading());
      List<LocalStock> data = await getAllLocalData();
      emit(LocalStockDataLoaded(data));
    } catch (e) {
      emit(LocalStockDataFailed());
      debugPrint("Failed to load data: ${e.toString()}");
    }
  }

  // Add data event handler
  void _onAddData(AddData event, Emitter<LocalStockDataState> emit) async {
    try {
      // Convert the stock price to double to ensure data type compatibility
      final double stockPrice = double.tryParse(event.data.stockPrice.toString()) ?? 0.0;
      final data = LocalStock(
        companyName: event.data.companyName,
        stockPrice: stockPrice,
      );
      await addData(data);

      // Emit LocalStockDataAdded to notify successful addition
      emit(const LocalStockDataAdded());
      // Reload the data to refresh the list in UI
      List<LocalStock> updatedData = await getAllLocalData();
      emit(LocalStockDataLoaded(updatedData));
    } catch (e) {
      emit(LocalStockDataFailed());
      debugPrint("Failed to add data: ${e.toString()}");
    }
  }

  // Delete data event handler
  void _onDeleteData(DeleteData event, Emitter<LocalStockDataState> emit) async {
    try {
      await deleteData(event.id);

      // Reload the data after deletion
      List<LocalStock> updatedData = await getAllLocalData();
      emit(LocalStockDataLoaded(updatedData));
    } catch (e) {
      emit(LocalStockDataFailed());
      debugPrint("Failed to delete data: ${e.toString()}");
    }
  }
}
