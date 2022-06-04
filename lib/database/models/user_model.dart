import 'dart:convert';

FCIAuthUserModel userFromJson(String str) => FCIAuthUserModel.fromLoginJson(json.decode(str));

class FCIAuthUserModel {
  User user;
  String? token;

  FCIAuthUserModel({required this.user,required this.token});
  factory FCIAuthUserModel.fromLoginJson(Map<dynamic, dynamic> json) {
    return FCIAuthUserModel(
      user: User.toObject(json['user']),
      token: json['token']);
  }
  Map<String, dynamic> toJson() => {
    "user" : user.toJson(),
    "token" : token,
  };
}

class User{
  int id;
  String? firstname;
  String? lastname;
  String? email;
  String? image;
  User({required this.id ,
    this.email,
    this.firstname,
    this.lastname,
    this.image
  });
  factory User.toObject(Map<String, dynamic> json) =>
      User(
          id: json['id'],
          firstname: json['firstname'],
          lastname: json['lastname'],
          email: json['email'],
          image: json['image'],
      );
  Map<String, dynamic> toJson() => {
    "id" : id,
    "firstname" : firstname,
    "lastname" : lastname,
    "email" : email,
    "image" : image,
  };
}