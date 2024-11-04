class Stock {
  final String companyName;
  String stockPrice; // Changed to String
  final String stockSymbol;

  Stock({
    required this.companyName,
    required this.stockPrice,
    required this.stockSymbol,
  });

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        companyName: json['companyName'],
        stockSymbol: json['stockSymbol'],
        stockPrice: json['stockPrice'], // Correctly map price
      );
}
