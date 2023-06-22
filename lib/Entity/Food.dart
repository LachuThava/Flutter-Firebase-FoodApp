class Food {
  int id = 0;
  String name = "";
  int price = 0;
  int quantity = 0;

  @override
  Food(this.id, this.name, this.price, this.quantity);

  Food.withDefaultValues()
      : id = 0,
        name = "",
        price = 0,
        quantity = 0;

  int getId() {
    return this.id;
  }

  String getFoodName() {
    return this.name;
  }

  int getPrice() {
    return this.price;
  }

  int getQuantity() {
    return this.quantity;
  }

  void setId(int id) {
    this.id = id;
  }

  void setFoodName(String foodName) {
    this.name = foodName;
  }

  void setPrice(int price) {
    this.price = price;
  }

  void setQuantity(int quantity) {
    this.quantity = quantity;
  }

  String toString() {
    return "{" +
        "id=" +
        id.toString() +
        ", name='" +
        name +
        '\'' +
        ", price=" +
        price.toString() +
        ", quantity=" +
        quantity.toString();
  }
}
