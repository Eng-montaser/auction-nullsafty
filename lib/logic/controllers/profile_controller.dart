import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:auction/database/services/post_service.dart';
import 'package:auction/ui/main_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/models/user_model.dart';
import '../../database/services/get_service.dart';
import '../../ui/widgets/get_message.dart';


class ProfileController extends GetxController {
  var sendDataLoading = false.obs;
  var getDataLoading = true.obs;
  FCIAuthUserModel? _userData;
  FCIAuthUserModel? get userData => _userData;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  getDetails()  async {
    getDataLoading.value=true;
      GetService _getService = new GetService();
      try {
        await _getService.getProfileDetails().then((response) async {
          if (response.statusCode == 200) {
            var data = jsonDecode(response.body);
            saveUserData(data);
            init();
            update();
          } else {
            init();
            update();
          }
        });
      } catch (e) {
        print(e);
        update();
      }
    getDataLoading.value=false;
      update();
    }
  saveUserData(json) async {
    SharedPreferences shared_User = await SharedPreferences.getInstance();
    String user = jsonEncode(json['user']);
    shared_User.setString('user', user);
    var tokenData = shared_User.getString('token');
    var userData = shared_User.getString('user');
    if (tokenData != null && userData != null) {
      Map userMap = {
        'token': tokenData,
        'user': jsonDecode(userData)
      };
      if (userMap.isNotEmpty) {
        _userData = FCIAuthUserModel.fromLoginJson(userMap);
      }
    }
    init();
    update();
  }
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  // late TextEditingController phoneController;
  late TextEditingController addressController;
  late TextEditingController stateController;
  late TextEditingController zipController;
  late TextEditingController cityController;

  File? imageData;
  init(){
      firstNameController=TextEditingController(text: _userData?.user.firstname??'');
      lastNameController=TextEditingController(text: _userData?.user.lastname??'');
      emailController=TextEditingController(text: _userData?.user.email??'');
      // phoneController=TextEditingController(text: _userData?.user.phone??'');
    addressController=TextEditingController(text: _userData?.user.address??'');
    stateController=TextEditingController(text: _userData?.user.state??'');
    zipController=TextEditingController(text: _userData?.user.zip??'');
    cityController=TextEditingController(text: _userData?.user.city??'');
  }
  FocusNode focusNodeFirstName = new FocusNode();
  FocusNode focusNodeLastName = new FocusNode();
  FocusNode focusNodeEmail = new FocusNode();
  FocusNode focusNodePhone = new FocusNode();
  FocusNode focusNodeAddress = new FocusNode();
  FocusNode focusNodeState = new FocusNode();
  FocusNode focusNodeZip = new FocusNode();
  FocusNode focusNodeCity = new FocusNode();
  ProfileFocusNode? profileFocusNode;
  getFocusNode(context) {
    switch (profileFocusNode) {
      case ProfileFocusNode.firstName:
        FocusScope.of(context).requestFocus(focusNodeFirstName);
        break;
      case ProfileFocusNode.lastName:
        FocusScope.of(context).requestFocus(focusNodeLastName);
        break;
      case ProfileFocusNode.address:
        FocusScope.of(context).requestFocus(focusNodeAddress);
        break;
      case ProfileFocusNode.state:
        FocusScope.of(context).requestFocus(focusNodeState );
        break;
      case ProfileFocusNode.zip:
        FocusScope.of(context).requestFocus(focusNodeZip);
        break;
      case ProfileFocusNode.city:
        FocusScope.of(context).requestFocus(focusNodeCity);
        break;
      case ProfileFocusNode.success:
      case null:
      FocusScope.of(context).unfocus();
        break;
    }
  }
  setFocus(focus, context) {
    profileFocusNode = focus;
    getFocusNode(context);
    update();
  }
  updateProfile(context) async {
    /// first name empty validate
    if (firstNameController.text.isEmpty) {
      GetMessage('Update Profile Error', "Please insert First Name.");
      setFocus(ProfileFocusNode.firstName, context);
      return false;
    }
    /// last name empty validate
    else if (lastNameController.text.isEmpty) {
      GetMessage('Update Profile Error', "Please insert Last Name.");
      setFocus(ProfileFocusNode.lastName, context);
      return false;
    }
    /// Address empty validate
    // else if (addressController.text.isEmpty) {
    //   GetMessage('Update Profile Error', "Please insert Address.");
    //   setFocus(ProfileFocusNode.address, context);
    //   return false;
    // }
    /// State empty validate
    else if (stateController.text.isEmpty) {
      GetMessage('Update Profile Error', "Please insert State.");
      setFocus(ProfileFocusNode.state, context);
      return false;
    }
    /// City empty validate
    else if (cityController.text.isEmpty) {
      GetMessage('Update Profile Error', "Please insert City.");
      setFocus(ProfileFocusNode.city, context);
      return false;
    }
    /// Zip empty validate
    else if (zipController.text.isEmpty) {
      GetMessage('Update Profile Error', "Please insert Zip");
      setFocus(ProfileFocusNode.zip, context);
      return false;
    }

     else {
      // late FCIAuthUserModel fciAuthUserModel;
      sendDataLoading.value = true;
      update();
      PostService _postService = new PostService();
      await _postService.updateProfileData(imageData,getUpdateDataBody()).then((response) async {
        print('Updateeeeeeeeeeeee${getUpdateDataBody()}');
        print(response.body);
        // var data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          GetMessage(
              'Profile', "The profile Data Changed Successfully.");
          Get.offAll(() => MainScreen(), arguments: {'title': 'Home Screen'});
          sendDataLoading.value = false;
          update();
        } else {
          print(response.body.toString());
          sendDataLoading.value = false;
          update();
          GetMessage('Profile', "Connection Error");
        }
      });
      // catch (e) {
      //   isLoading.value = false;
      //   update();
      //   GetMessage('Change Password', "Connection Error");
      // }
      // print('${fciAuthUserModel.user.email}');
    }
  }

  getUpdateDataBody() {
    return {
      "firstname": firstNameController.text,
      "lastname": lastNameController.text,
      "address": 'address',//addressController.text,
      "state":stateController.text,
      "zip": zipController.text,
      "city": cityController.text,
    };
  }
  testButtonLoading(){
    sendDataLoading.value=true;
    update();
    Timer(Duration(seconds: 3), () {
      print("Yeah, this line is printed after 3 seconds");
      sendDataLoading.value=false;
      update();
    });
  }
  pickImage(ImageSource imageSource) async {
    var image = await ImagePicker.platform.pickImage(source: imageSource);
    if(image!=null)
    imageData=File(image.path);
    update();
  }
  @override
  void dispose() {
    // if (currentPasswordController != null) currentPasswordController.dispose();
    // if (passwordController != null) passwordController.dispose();
    // if (passwordConfirmationController != null) passwordConfirmationController.dispose();
    super.dispose();
  }
  // printData() {
  //   print(getChangePasswordBody());
  // }
}
enum ProfileFocusNode {
  firstName,
  lastName,
  address,
  state,
  zip,
  city,
  success
}


/// Change Screen
/*
ProfileTextField(
                              hintText: "Confirm New Password",
                              obsecure: true,
                              controller: controller.passwordConfirmationController,
                              focusNode: controller.focusNodePasswordConfirmation,
                              onTap: () {
                                controller.setFocus(ChangePasswordFocusNode.passwordConfirmation, context);
                              },
                              onEditingComplete: () {
                                controller.setNextFocus(ChangePasswordFocusNode.passwordConfirmation, context);
                              },
                            ),
                            GreenButton(
                              title: "Save",
                              loading: controller.isLoading.value,
                              onTap: (){
                                controller.changePassword(context);
                              },
                            )
*/