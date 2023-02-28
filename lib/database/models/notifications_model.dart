import 'package:auction/database/models/user_model.dart';
import 'package:auction/logic/controllers/auth_controller.dart';
import 'package:get/get.dart';

import '../../logic/controllers/live_controller.dart';

class NotificationsModel {
  int id;
  String title;
  String desc;
  DateTime? date;
  NotificationsModel(
      {required this.date,
      required this.id,
      required this.title,
      required this.desc,});
  factory NotificationsModel.fromJosn(Map<String, dynamic> json) {
    return NotificationsModel(
        id: int.parse('${json['id']}'),
      date: json['date']!=null || json['date']!='' ?
      DateTime.tryParse(json['date']): DateTime.now() ,
      title: json['title'] ?? '',
        desc: json['description'] ?? '',
    );
  }
}

