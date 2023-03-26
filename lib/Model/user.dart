class User {
  String username;
  String password;
  String address;
  String phoneNumber;
  String firstName;
  String lastName;
  String email;

  User(this.username, this.password, this.address,
      [this.firstName = "",
      this.lastName = "",
      this.phoneNumber = "",
      this.email = ""]);

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      json['username'],
      json['password'],
      json['address'],
      json['first'],
      json['last'],
      json['phone_num'],
      json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
        "address": address,
        "phoneNumber": phoneNumber,
        "firstName": firstName,
        "lastName": lastName,
        "email": email
      };

  bool matches(String username, String password) {
    return username == this.username && password == this.password;
  }
}
