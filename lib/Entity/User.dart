class User {
  String email = "";
  String password = "";
  String imgPath = "";
  String cardNumber = "";

  User(String email, String password);

  String getEmail() {
    return this.email;
  }

  void setEmail(String email) {
    this.email = email;
  }

  String getPassword() {
    return this.password;
  }

  void setPassword(String password) {
    this.password = password;
  }

  String getImgPath() {
    return this.imgPath;
  }

  void setImgPath(String imgPath) {
    this.imgPath = imgPath;
  }

  String getCardNumber() {
    return this.cardNumber;
  }

  void setCardNumber(String cardNumber) {
    this.cardNumber = cardNumber;
  }
}
