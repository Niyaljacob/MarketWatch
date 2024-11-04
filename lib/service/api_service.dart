import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:market_watch/model/company_model.dart';

Future<List<Stock>> fetchStockData(searchKey) async {
  var apiKey = '7MFGL58YV0994AQK';
  var url = Uri.parse('https://www.alphavantage.co/query?function=SYMBOL_SEARCH&keywords=$searchKey&apikey=$apiKey');
  debugPrint('Search URL: $url');
  try {
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      var bestMatches = data['bestMatches'];

      if (bestMatches != null && bestMatches.isNotEmpty) {

        List<Stock> stocks = [];

        for (var match in bestMatches) {

          var symbol = match['1. symbol'];
          var companyName = match['2. name'];

          var stockData = await fetchStockPrice(symbol, companyName);

          if (stockData != null) {
            stocks.add(stockData);
          }
        }
        return stocks;
      } else {
        debugPrint('No matches found.');
        return [];
      }
    } else {
      debugPrint('Symbol search request failed with status: ${response.statusCode}.');
      return [];
    }
  } catch (err) {
    debugPrint('Error: $err');
    return [];
  }
}

Future<Stock?> fetchStockPrice(String symbol, String companyName) async {
  var apiKey = 'CQ0NX8WMV47CP8PA';
  var url = Uri.parse('https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol=$symbol&apikey=$apiKey');
  debugPrint(url.toString());

  try {
    var response = await http.get(url, headers: {'User-Agent': 'request'});

    if (response.statusCode == 200) {
      var data = json.decode(response.body);

      var timeSeries = data['Time Series (Daily)'];

      if (timeSeries != null && timeSeries.isNotEmpty) {
        var latestEntry = timeSeries.keys.first;
        var latestData = timeSeries[latestEntry];
        var stockPrice = latestData['4. close'];

        return Stock(
          companyName: companyName,
          stockSymbol: symbol,
          stockPrice: stockPrice,
        );
      } else {
        debugPrint('No daily time series data available for $symbol.');
        return null;
      }
    } else {
      debugPrint('Stock price request failed with status: ${response.statusCode} for $symbol.');
      return null;
    }
  } catch (err) {
    debugPrint('Error fetching stock price for $symbol: $err');
    return null;
  }
}
