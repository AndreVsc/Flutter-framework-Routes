class Login {
  final String username;
  final String password;

  Login({required this.username, required this.password});

  bool isValid() {
    return username == "admin" && password == "1234";
  }
}
