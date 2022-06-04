import 'package:auction/database/models/login_data.dart';
import 'package:auction/database/models/user_model.dart';
import 'package:auction/database/services/post_service.dart';

class FCIGetXApi{
  // static register(RegisterData signUpData)async{
    // await PostService().register(signUpData).then((response){
    //   if(response.statusCode==200 || response.statusCode==201){
    //     return userFromJson(response.body);
    //   }else
    //     return null;
    // });
  // }
  static login(LoginData loginData)async{
    await PostService().login(loginData).then((response){
      if(response.statusCode==200 || response.statusCode==201){
        return userFromJson(response.body);
      }else
        return null;
      });
  }
}