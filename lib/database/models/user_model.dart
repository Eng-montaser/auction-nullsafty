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
  String? phone;
  String? image;
  String? address;
  String? state;
  String? zip;
  String? city;
  User({required this.id ,
    this.email,
    this.phone,
    this.firstname,
    this.lastname,
    this.image,
    this.address,
    this.city,
    this.state,
    this.zip,

  });
  factory User.toObject(Map<String, dynamic> json) =>
      User(
          id: json['id'],
          firstname: json['firstname'],
          lastname: json['lastname'],
          email: json['email'],
          phone: json['phone'],
          image: json['image'],
        address: json['country'],
        city: json['city'] ,
        state:  json['state'],
          zip: json['zip']
      );
  Map<String, dynamic> toJson() => {
    "id" : id,
    "firstname" : firstname,
    "lastname" : lastname,
    "email" : email,
    "phone" : phone,
    "image" : image,
  };
}