import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier {
  String? name;
  String? email;

  Future fetchNameAndEmail() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    name = preferences.getString('name')!;
    email = preferences.getString('email')!;

    notifyListeners();
  }
}
