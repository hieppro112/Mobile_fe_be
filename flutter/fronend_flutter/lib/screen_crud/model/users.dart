class Users {
  final int? userId;
  final String name;
  final String address;

  Users({required this.userId, required this.name, required this.address});

  //lay du lieu json
  factory Users.fromJson(Map<String, dynamic> json) => Users(
    userId: json["userID"],
    name: json["userName"],
    address: json["address"],
  );
  //up dl json
  Map<String, dynamic> toJson() => {
    "userID": userId,
    "userName": name,
    "address": address,
  };
}
