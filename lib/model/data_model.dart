class LocalStock {
  int? id;
  String companyName;
  double stockPrice;

  LocalStock({this.id, required this.companyName, required this.stockPrice});

  // Convert LocalStock to Map for SQLite storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'companyName': companyName,
      'stockPrice': stockPrice,
    };
  }

  // Convert Map from SQLite to LocalStock
  factory LocalStock.fromMap(Map<String, dynamic> json) => LocalStock(
        id: json['id'],
        companyName: json['companyName'],
        stockPrice: json['stockPrice'],
      );
}
