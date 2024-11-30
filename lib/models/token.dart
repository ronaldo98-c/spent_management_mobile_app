class Token {
  String? token;

  Token({this.token});

  Token.fromJson(String json) {
    token = json;
  }
}