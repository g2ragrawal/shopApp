import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeModel extends ChangeNotifier{

  get isVisible => _isVisible;
  bool _isVisible = false;
  set isVisible(value){
    _isVisible = value;
    notifyListeners();

  }

  get isConfirmVisible => _isConfirmVisible;
  bool _isConfirmVisible = false;
  set isConfirmVisible(value){
    _isConfirmVisible=value;
    notifyListeners();
  }

  get isValid => _isValid;
  bool _isValid = false;
  set isValid(value){
    _isValid=value;
    notifyListeners();
  }

  get isCorrect => _isCorrect ;
  bool _isCorrect = false;
  void isCorrectEmail(String input){
    input == 'example@email.com' ? _isCorrect = true : _isCorrect = false;
  }

  get isCorrectPwd => _isCorrectPwd ;
  bool _isCorrectPwd = false;
  void isCorrectPassword(String input){
    input == 'example@123' ? _isCorrectPwd = true : _isCorrectPwd = false;
  }
}