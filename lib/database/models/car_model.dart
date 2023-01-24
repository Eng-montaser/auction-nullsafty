import 'package:auction/database/models/user_model.dart';

class CarModel {
  int id;
  List<String> images;
  String title;
  String desc;
  String bid_price;
  String start_date;
  String end_date;
  bool isFinished;
  int? members;
  int? auction_num;
  String miles;

  CarModel(
      {required this.miles,
      required this.id,
      required this.images,
      required this.title,
      required this.desc,
       this.members,
       this.auction_num,
      required this.bid_price,
      required this.start_date,
      required this.end_date,
      required this.isFinished});
  factory CarModel.fromJosn(Map<String, dynamic> json) {
    List<String> imags = [];
    if (json['images'] != null) if (json['images'].length > 0) {
      for (var im in json['images']) imags.add(im);
    }
    String bidPrice = '';
    int membersCount = 0;
    if (json['bidding_history'] != null) if (json['bidding_history'].length >
        0) {
      List<int> memList = [json['bidding_history'][0]['user_id']];
      double price = double.parse(json['bidding_history'][0]['bid_amount']);
      for (int i = 1; i < json['bidding_history'].length; i++) {
        print(memList.contains(json['bidding_history'][i]['user_id']));
        if (!memList.contains(json['bidding_history'][i]['user_id'])) {
          memList.add(json['bidding_history'][i]['user_id']);
        }
        if (double.parse(json['bidding_history'][i]['bid_amount']) > price) {
          price = double.parse(json['bidding_history'][i]['bid_amount']);
        }
      }
      bidPrice = price.round().toString();
      membersCount = memList.length;
    } else
      bidPrice = '${json['min_bid_price']}';
    print('mmen: ${json['bidding_history'].length}');
    return CarModel(
        id: int.parse('${json['id']}'),
        images: imags,
        title: json['name'] ?? '',
        miles: json['mileage'] ?? '',
        bid_price: bidPrice,
        start_date: json['start_date'] ?? '',
        end_date: json['end_date'] ?? '',
        desc: json['description'] ?? '',
        isFinished: int.parse('${json['bid_complete']}') == 1,
        members: membersCount,
      auction_num:json['bidding_history']!=null?json['bidding_history'].length:0 // json['mileage'],
        );
  }
}

class CarDetails {
  String? start_date;
  String? end_date;
  String? make;
  String? model;
  String? year;
  double? min_bid_price;
  double? shipping_cost;
  String? delivery_time;
  String? body_type;
  String? engine_size;
  String? service_pack;
  String? service_hstory;
  String? warranty;
  String? specification;
  String? transmission;
  String? mortgage;
  String? number_of_keys;
  String? tyres;
  String? steering_engine;
  String? gearbox;
  String? dash_lights;
  String? electric;
  String? ac_and_heating;
  String? components;
  String? breaks;
  String? suspension;
  String? exhaust;
  String? clutch;
  String? windows_sunroof;
  String? central_locking;
  String? horn_light_radio;
  String? engine;
  String? engine_condition;
  String? transmission_condition;
  String? axle;
  String? air_conditioning;
  String? brakes;
  String? suspension_condition;
  String? tires;
  String? tires_date;
  String? front_bumper;
  String? bonnet;
  String? roof;
  String? boot_trunk;
  String? rear_bumper;
  String? wing_driver;
  String? front_door;
  String? rear_door;
  String? rear_quarter;
  String? passenger_front_wing;
  String? number_of_cylinders;
  String? passenger_front_door;
  String? passenger_side_rear_door;
  String? passenger_rear_quarter;
  String? driver_front_tyre;
  String? driver_rear_tyre_passenger;
  String? front_tyre_passenger;
  String? rear_tyre;
  String? interior_type;
  String? interior_comment;
  String? navigation;
  String? sun_roof;
  String? interior_omment;
  List<BidUser>? bidUsers;
  CarDetails(
      {this.start_date,
      this.end_date,
      this.make,
      this.model,
      this.year,
      this.bidUsers,
      this.min_bid_price,
      this.shipping_cost,
      this.delivery_time,
      this.body_type,
      this.engine_size,
      this.service_pack,
      this.service_hstory,
      this.warranty,
      this.specification,
      this.transmission,
      this.mortgage,
      this.number_of_keys,
      this.tyres,
      this.steering_engine,
      this.gearbox,
      this.dash_lights,
      this.electric,
      this.ac_and_heating,
      this.components,
      this.breaks,
      this.suspension,
      this.exhaust,
      this.clutch,
      this.windows_sunroof,
      this.central_locking,
      this.horn_light_radio,
      this.engine,
      this.engine_condition,
      this.transmission_condition,
      this.axle,
      this.air_conditioning,
      this.brakes,
      this.suspension_condition,
      this.tires,
      this.tires_date,
      this.front_bumper,
      this.bonnet,
      this.roof,
      this.boot_trunk,
      this.rear_bumper,
      this.wing_driver,
      this.front_door,
      this.rear_door,
      this.rear_quarter,
      this.passenger_front_wing,
      this.number_of_cylinders,
      this.passenger_front_door,
      this.passenger_side_rear_door,
      this.passenger_rear_quarter,
      this.driver_front_tyre,
      this.driver_rear_tyre_passenger,
      this.front_tyre_passenger,
      this.rear_tyre,
      this.interior_type,
      this.interior_comment,
      this.navigation,
      this.sun_roof,
      this.interior_omment});

  factory CarDetails.fromJosn(Map<String, dynamic> json) {
    List<BidUser> bidUsers = [];
    if (json['bidding_history'].length > 0) {
      for (var im in json['bidding_history'])
        bidUsers.add(BidUser.fromJosn(im));
    }

    return CarDetails(
      start_date: json['start_date'],
      end_date: json['end_date'],
      make: json['make'],
      model: json['model'],
      year: json['year'],
      bidUsers: bidUsers,
      min_bid_price: double.parse(json['min_bid_price'].toString()),
      shipping_cost: double.parse(json['shipping_cost'].toString()),
      delivery_time: json['delivery_time'],
      body_type: json['body_type'],
      engine_size: json['engine_size'],
      service_pack: json['service_pack'],
      service_hstory: json['service_hstory'],
      warranty: json['warranty'],
      specification: json['specification'],
      transmission: json['transmission'],
      mortgage: json['mortgage'],
      number_of_keys: json['number_of_keys'],
      tyres: json['tyres'],
      steering_engine: json['steering_engine'],
      gearbox: json['gearbox'],
      dash_lights: json['dash_lights'],
      electric: json['electric'],
      ac_and_heating: json['ac_and_heating'],
      components: json['components'],
      breaks: json['breaks'],
      suspension: json['suspension'],
      exhaust: json['exhaust'],
      clutch: json['clutch'],
      windows_sunroof: json['windows_sunroof'],
      central_locking: json['central_locking'],
      horn_light_radio: json['horn_light_radio'],
      engine: json['engine'],
      engine_condition: json['engine_condition'],
      transmission_condition: json['transmission_condition'],
      axle: json['axle'],
      air_conditioning: json['air_conditioning'],
      brakes: json['brakes'],
      suspension_condition: json['suspension_condition'],
      tires: json['tires'],
      tires_date: json['tires_date'],
      number_of_cylinders: json['number_of_cylinders'],

      front_bumper: json['front_bumper'],

      /// frontBumper,
      bonnet: json['bonnet'],

      /// bonnet,
      roof: json['roof'],

      /// roof,
      boot_trunk: json['boot_trunk'],

      /// bootTrunk,
      rear_bumper: json['rear_bumper'],

      /// rearBumper,
      wing_driver: json['wing_driver'],

      /// driverSideFrontWing,
      front_door: json['front_door'],

      /// driverSideFrontDoor,
      rear_door: json['rear_door'],

      /// driverSideRearDoor,
      rear_quarter: json['rear_quarter'],

      /// driverSideRearQuarter,
      passenger_front_wing: json['passenger_front_wing'],

      ///  passengerSideFrontWing,
      passenger_front_door: json['passenger_front_door'],

      /// passengerSideFrontDoor,
      passenger_side_rear_door: json['passenger_side_rear_door'],

      /// passengerSideRearDoor,
      passenger_rear_quarter: json['passenger_rear_quarter'],

      /// passengerSideRearQuarter,
      driver_front_tyre: json['driver_front_tyre'],

      /// driverSideFrontTyre,
      driver_rear_tyre_passenger: json['driver_rear_tyre_passenger'],

      /// driverSideRearTyre,
      front_tyre_passenger: json['front_tyre_passenger'],

      ///  passengerSideFrontTyre,
      rear_tyre: json['rear_tyre'],

      ///  passengerSideRearTyre

      interior_type: json['interior_type'],
      interior_comment: json['interior_comment'],
      navigation: json['navigation'],
      sun_roof: json['sun_roof'],
      interior_omment: json['interior_omment'],
    );
  }
}

class BidUser {
  int id;
  int product_id;
  int user_id;
  double bid_amount;
  double shipping_cost;
  double total_amount;
  String? updated_at;
  User user;
  BidUser(
      {required this.id,
      required this.product_id,
      required this.user_id,
      required this.bid_amount,
      required this.shipping_cost,
      required this.total_amount,
      this.updated_at,
      required this.user});

  factory BidUser.fromJosn(Map<String, dynamic> json) {
    return BidUser(
      id: int.parse('${json['id']}'),
      user_id: int.parse('${json['user_id']}'),
      product_id: int.parse('${json['product_id']}'),
      bid_amount: double.parse('${json['bid_amount']}'),
      shipping_cost: double.parse('${json['shipping_cost']}'),
      total_amount: double.parse('${json['total_amount']}'),
      user: User.toObject(json['user']),
      updated_at: json['updated_at'],
    );
  }
}

class MyBids {
  int id;
  int product_id;
  double bid_amount;
  double shipping_cost;
  double total_amount;
  MyBids(
      {required this.id,
      required this.bid_amount,
      required this.shipping_cost,
      required this.product_id,
      required this.total_amount});
  factory MyBids.toObject(Map<String, dynamic> json) => MyBids(
        id: int.parse('${json['id']}'),
        product_id: int.parse('${json['product']['id']}'),
        bid_amount: double.parse('${json['bid_amount']}'),
        shipping_cost: double.parse('${json['shipping_cost']}'),
        total_amount: double.parse('${json['total_amount']}'),
      );
}
