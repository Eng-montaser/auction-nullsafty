import 'dart:io';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;



class GoogleDriveActions {
  bool _loginStatus = false;
  String msg = '';
  String size = '';
  final googleSignIn = GoogleSignIn.standard(scopes: [

  ]);

  Future<GoogleSignInAccount?> signIn() async {
    final googleUser = await googleSignIn.signIn();

    try {
      if (googleUser != null) {
        print('googles: ${googleUser.displayName}:${googleUser.email}');
        final googleAuth = await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential loginUser =
            await FirebaseAuth.instance.signInWithCredential(credential);

        assert(loginUser.user?.uid == FirebaseAuth.instance.currentUser?.uid);
      }
    } catch (e) {
      print(e);
    }
    return googleUser;
  }

  Future<GoogleSignInAccount?> reset() async {
    return await googleSignIn.signIn();
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }


  showLoaderDialog(BuildContext context, String text) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.all(7), child: Text(text)),
        ],
      ),
    );
    showCupertinoDialog(
      barrierDismissible: false,
      context: context,
      builder: (_) {
        return alert;
      },
    );
  }







}

class GoogleAuthClient extends http.BaseClient {
  final Map<String, String> _headers;
  final _client = new http.Client();

  GoogleAuthClient(this._headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return _client.send(request);
  }
}
