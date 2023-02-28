import 'dart:convert';

import 'package:auction/ui/authentication/googlefacebookLogin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../database/services/post_service.dart';
import '../../ui/main_view.dart';
import '../../ui/widgets/get_message.dart';
import 'auth_controller.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  TextEditingController emailController = new TextEditingController(text: '');
  TextEditingController passwordController = new TextEditingController(text: '');
  //GoogleDriveActions googleDriveActions=new GoogleDriveActions();
  LoginFocusNode? loginFocusNode;
  FocusNode focusNodeEmail = new FocusNode();
  FocusNode focusNodePassword = new FocusNode();
  getSignInBody() {
    // return {
    //   "app_secret": "app_secret",
    //   "name": nameController.text,
    //   "phone": phoneController.text,
    //   "email": emailController.text,
    //   "password": passwordController.text,
    // };
    return {
      "email": emailController.text,
      "password": passwordController.text,
      "is_social": "0",
    };
  }

  getFocusNode(context) {
    switch (loginFocusNode) {
      case LoginFocusNode.email:
        FocusScope.of(context).requestFocus(focusNodeEmail);
        break;
      case LoginFocusNode.password:
        FocusScope.of(context).requestFocus(focusNodePassword);
        break;
      case LoginFocusNode.success:
      case null:
        FocusScope.of(context).unfocus();
        break;
    }
  }

  setFocus(focus, context) {
    loginFocusNode = focus;
    getFocusNode(context);
    update();
  }

  setNextFocus(focus, context) {
    switch (focus) {
      case LoginFocusNode.email:
        loginFocusNode = LoginFocusNode.password;
        FocusScope.of(context).requestFocus(focusNodePassword);
        break;
      case LoginFocusNode.password:
      case null:
        loginFocusNode = LoginFocusNode.success;
        FocusScope.of(context).unfocus();
        break;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    if (emailController != null) emailController.dispose();
    if (passwordController != null) passwordController.dispose();
    super.dispose();
  }

  printData() {
    print(getSignInBody());
  }

  bool emailIsValid(String email) {
    return GetUtils.isEmail(email);
  }
// register()async{
//   if()
// }

  login(context) async {
    /// email empty validate
    if (emailController.text.isEmpty) {
      GetMessage('Login Error', "Please insert Email.");
      setFocus(LoginFocusNode.email, context);
      return false;
    }

    /// name Valid validate
    else if (!emailIsValid(emailController.text)) {
      setFocus(LoginFocusNode.email, context);
      GetMessage('Login Error', "Please insert a Valid Email.");
      return false;
    }

    /// password empty validate
    else if (passwordController.text.isEmpty) {
      setFocus(LoginFocusNode.password, context);
      GetMessage('Login Error', "Please insert Password.");
      return false;
    }

    /// password [6 characters] validate
    else if (passwordController.text.length < 6) {
      setFocus(LoginFocusNode.password, context);
      GetMessage(
          'Login Error', "The Password must be at least 6 characters.");
      return false;
    } else {
      // late FCIAuthUserModel fciAuthUserModel;
      isLoading.value = true;
      update();
      PostService _postService = new PostService();
      //print(getSignInBody());
      try {
        await _postService.login(getSignInBody()).then((response) async {
          print('res: ${response.body}');
          var data = jsonDecode(response.body);
          if (response.statusCode == 200){
            SharedPreferences shared_User = await SharedPreferences.getInstance();
            String token = data['token'];
            shared_User.setString('token', token);
            AuthenticationController _authController =
                Get.put(AuthenticationController());
             _authController.saveUserData(data).then((value) => Get.offAll(() => MainScreen(), arguments: {'title': 'Home Screen'}));

            isLoading.value = false;
            update();
          } else {
            print(response.statusCode);
            isLoading.value = false;
            update();
            GetMessage('Login Error', "email and password invalid");
          }
        });
      } catch (e) {
        isLoading.value = false;
        update();
        GetMessage('Login Error', "Connection Error");
      }
      update();
      // print('${fciAuthUserModel.user.email}');
    }
  }
////////////////////////
  Map<String, dynamic>? userData;
  AccessToken? accessToken;
  bool checking = true;
  Future<GoogleSignInAccount?>? performGoogleSignIn() {
    try {
      return GoogleSignIn().signIn();
    } catch (err, stk) {
      print(err.toString());
      print(stk.toString());

      return null;
    }
  }
  Future<void> _checkIfIsLogged() async {
    final accessToken1 = await FacebookAuth.instance.accessToken;
      checking = false;
    update();
    if (accessToken != null) {
       // now you can call to  FacebookAuth.instance.getUserData();
      final userData1 = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      accessToken = accessToken1;

        userData = userData1;
    update();
    }
  }

  void _printCredentials() {
    print(
      prettyPrint(accessToken!.toJson()),
    );
  }
  Future<void> facebookLogin() async {
    final LoginResult result = await FacebookAuth.instance.login(); // by default we request the email and the public profile

    // loginBehavior is only supported for Android devices, for ios it will be ignored
    // final result = await FacebookAuth.instance.login(
    //   permissions: ['email', 'public_profile', 'user_birthday', 'user_friends', 'user_gender', 'user_link'],
    //   loginBehavior: LoginBehavior
    //       .DIALOG_ONLY, // (only android) show an authentication dialog instead of redirecting to facebook app
    // );

    if (result.status == LoginStatus.success) {
      accessToken = result.accessToken;
      _printCredentials();
      // get the user data
      // by default we get the userId, email,name and picture
      final userData1 = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      userData = userData1;
      print('facebooksn: ${userData1['name']}');
      print('facebookse: ${userData1['email']}');
      isLoading.value = true;
      update();
      PostService _postService = new PostService();
      //print(getSignInBody());
      try {
        await _postService.login({
          "email": userData1['email'],
          "name": userData1['name'],
          "is_social": "1",
        }).then((response) async {
          print('resf: ${response.body}');
          var data = jsonDecode(response.body);
          if (response.statusCode == 200){
            AuthenticationController _authController =
            Get.put(AuthenticationController());
            await _authController.saveUserData(data);
            Get.offAll(() => MainScreen(), arguments: {'title': 'Home Screen'});
            isLoading.value = false;
            update();
          } else {
            print(response.statusCode);
            isLoading.value = false;
            update();
            GetMessage('Login Error', "email and password invalid");
          }
        });
      } catch (e) {
        isLoading.value = false;
        update();
        print('lloo $e');
        GetMessage('Login Error', "Connection Error");
      }
      update();
      // print('${fciAuthUserModel.user.email}');

    } else {
      print(result.status);
      print(result.message);
    }

    checking = false;
    update();
  }
  Future<void> googleLogin() async {
    GoogleSignInAccount? googleUser=await GoogleDriveActions().signIn();
    isLoading.value = true;
    update();
    PostService _postService = new PostService();
    //print(getSignInBody());
    try {
      await _postService.login({
        "email": '${googleUser?.email}',
        "name": '${googleUser?.displayName}',
        "is_social": "1",
      }).then((response) async {
        print('gresf: ${response.body}');
        var data = jsonDecode(response.body);
        if (response.statusCode == 200){
          AuthenticationController _authController =
          Get.put(AuthenticationController());
          await _authController.saveUserData(data);
          Get.offAll(() => MainScreen(), arguments: {'title': 'Home Screen'});
          isLoading.value = false;
          update();
        } else {
          print(response.statusCode);
          isLoading.value = false;
          update();
          GetMessage('Login Error', "email and password invalid");
        }
      });
    } catch (e) {
      isLoading.value = false;
      update();
      print('lloo $e');
      GetMessage('Login Error', "Connection Error");
    }
    update();
   update();
  }


  Future<void> facebookLogout() async {
    await FacebookAuth.instance.logOut();
    accessToken = null;
    userData = null;
  update();
  }
  String prettyPrint(Map json) {
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String pretty = encoder.convert(json);
    return pretty;
  }
}

enum LoginFocusNode {
  // image,
  email,
  // phone,
  password,
  success
}
