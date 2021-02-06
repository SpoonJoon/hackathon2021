import 'package:flutter/material.dart';

class LoginState extends ChangeNotifier{
  bool _returningUser = false;

  bool get returningUser => _returningUser;

  void toggle(){
    _returningUser = !_returningUser;
    notifyListeners();
  }
}