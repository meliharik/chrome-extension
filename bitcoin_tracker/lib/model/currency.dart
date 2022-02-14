class Currency {
  final String id;
  final String name;
  final String currency;
  final String logoUrl;
  final double price;
  final double oneDayChange;
  final double marketCap;
  final int rank;

  Currency({
    required this.id,
    required this.name,
    required this.currency,
    required this.logoUrl,
    required this.price,
    required this.oneDayChange,
    required this.marketCap,
    required this.rank,
  });

  factory Currency.fromJson(Map<String, dynamic> json) {
    return Currency(
      id: json['id'],
      name: json['name'],
      currency: json['currency'],
      logoUrl: json['logo_url'],
      price: double.parse(json['price']),
      oneDayChange: double.parse(json['1d']['price_change_pct']),
      marketCap: double.parse(json['market_cap']),
      rank: int.parse(json['rank']),
    );
  }
}
