import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:machine_test/features/auth/models/user_model.dart';
import 'package:machine_test/features/auth/screens/login.dart';
import 'package:machine_test/features/home/screens/home_screen.dart';
import 'package:machine_test/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  UserModel? userModel;

  putLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  putUserModel(UserModel model) {
    userModel = model;
    notifyListeners();
  }

  login(BuildContext context, {required String username, required String password}) async {
    putLoading(true);
    var data = await ApiServices().login(username, password);
    print(data);
    try {
      userModel = UserModel.fromJson(data);
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString('token', jsonEncode(data));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Login success"),
        backgroundColor: Colors.green,
      ));
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => HomeScreen()), (route) => false);
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error"), backgroundColor: Colors.red));
    }
    putLoading(false);
  }

  logout(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.clear();
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Login()), (route) => false);
  }
}
