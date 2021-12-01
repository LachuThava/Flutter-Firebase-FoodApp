class Products {
  Products({required this.name, required this.price, required this.count});

  String name;
  String price;
  String count;

  Map<String, dynamic> toJson() =>
      {"name": name, "price": price, "count": count};
}
