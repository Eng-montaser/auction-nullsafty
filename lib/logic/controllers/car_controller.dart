import 'dart:async';
import 'package:auction/database/models/car_model.dart';
import 'package:get/get.dart';
import '../../database/getxApi/get_api.dart';
import '../../utils/utils.dart';
class CarsController extends GetxController {
  bool allCarsLoading = true;
  List<CarModel>  allCars = [];
  StreamController<List<CarModel>> streamController = StreamController();
  void startTimer() async{
    Timer.periodic(Duration(seconds: 3), (timer)async {
      try {
        await FCIGetDataXApi().getAllCars().then((value) async{
          if (value != null) {
            allCars = value;
            streamController.sink.add(  allCars);
            allCarsLoading = false;
            update();
          }
        });
      } catch (e) {
        update();
      }
    });
  }
  void endTimer() async{
    streamController.close();
  }
  List<CarModel>getData(CarsStatus carStatus) {
    switch (carStatus) {
      case CarsStatus.live:
        return allCars.where((element) => Utils().getTypeOfAuction(start_date:  element.start_date ,end_date:  element.end_date)
            .index==CarsStatus.live.index).toList();
        break;
      default :
        return allCars;
        break;
    }
  }
  Duration calActual({start_date, end_date,   isRunning}){
    Duration actual = new Duration();
    actual=isRunning?Utils().getLiveDuration(end_date):
    Utils().getUpcomingDuration(start_date);
    return actual;
  }
  @override
  void onInit() async{
    super.onInit();
    startTimer();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}
enum CarsStatus { all, upComing, live, expired }