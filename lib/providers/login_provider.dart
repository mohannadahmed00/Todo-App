import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier{
  var formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String responseCode="";

  void setEmail(String email) {
    this.email = email;
  }

  void setPassword(String password) {
    this.password = password;
  }

  void login({required Function onSuccess}) async{
    print("email=> $email");
    print("password=> $password");
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      responseCode = "200";
      onSuccess();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        responseCode = e.code;
        notifyListeners();
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        responseCode = e.code;
        notifyListeners();
        print('Wrong password provided for that user.');
      }
    }
  }

}