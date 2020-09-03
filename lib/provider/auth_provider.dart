import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:jain_namkin/model/http_exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  String _refreshToken;
  Timer _authTimer;
  String _first;
  String _last;
  String _mobile;
  String _email;

  bool get isAuth {
    return token == null;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get first {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _first != null) {
      return _first;
    }
    return null;
  }

  String get last {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _last != null) {
      return _last;
    }
    return null;
  }

  String get mobile {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _mobile != null) {
      return _mobile;
    }
    return null;
  }

  String get email {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _email != null) {
      return _email;
    }
    return null;
  }

  String get userId {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _userId != null) {
      return _userId;
    }
    return null;
  }

  Future<void> signup(String email, String password,String first,String last,String mobile) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=[Api_key]';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _refreshToken=responseData['refreshToken'];
      _tryAutoRefreshToken();
      notifyListeners();
      _first=first;
      _last=last;
      _email=email;
      _mobile=mobile;
      final res = await http.put('https://project_name.firebaseio.com/users/$_userId.json',body: json.encode({'first':first,'last':last,'mobile':mobile,'email':email}),);
      final prefs = await SharedPreferences.getInstance();
      final userData=json.encode({'token':_token,'userId':_userId,'expiryDate':_expiryDate.toIso8601String(),'refreshToken':_refreshToken,'first':_first,'last':_last,'mobile':_mobile,'email':email},);
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    var url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=[Api_key]';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {'email': email, 'password': password, 'returnSecureToken': true},
        ),
      );
      final responseData = json.decode(response.body);
//      print('error${responseData['error']}');
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      _refreshToken=responseData['refreshToken'];
      _tryAutoRefreshToken();
      final res = await http.get('https://project_name.firebaseio.com/users/$_userId.json');
      final fetchedData = json.decode(res.body) as Map<String, dynamic>;
      _first=fetchedData['first'];
      _last=fetchedData['last'];
      _mobile=fetchedData['mobile'];
      _email=fetchedData['email'];
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData=json.encode({'token':_token,'userId':_userId,'expiryDate':_expiryDate.toIso8601String(),'refreshToken':_refreshToken,'first':_first,'last':_last,'mobile':_mobile,'email':email},);
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<bool> autologin() async{
    final prefs = await SharedPreferences.getInstance();
//    print('here0');
    if(!prefs.containsKey('userData')){
//      print('here');
//      refreshIdToken().then((value) => true).catchError((onError){return false;});
      return false;
    }
    final extractedData = json.decode(prefs.getString('userData')) as Map<String,Object>;
    final expiryDate = DateTime.parse(extractedData['expiryDate']);
    if(expiryDate.isBefore(DateTime.now())){
      refreshIdToken().then((_) => true).catchError((_){return false;});
    }
    _token=extractedData['token'];
    _expiryDate=expiryDate;
    _userId=extractedData['userId'];
    _first=extractedData['first'];
    _last=extractedData['last'];
    _mobile=extractedData['mobile'];
    _email=extractedData['email'];
    notifyListeners();
    return true;
  }

  Future<void> refreshIdToken() async{
    var url = 'https://securetoken.googleapis.com/v1/token?key=[Api_key]';
    try{
      final prefs = await SharedPreferences.getInstance();
      final extractedData = json.decode(prefs.getString('userData')) as Map<String,Object>;
      print(_refreshToken);
      _refreshToken = extractedData['refreshToken'];
      print(_refreshToken);
      final response = await http.post(url,body: json.encode({'grant_type':'refresh_token','refresh_token':_refreshToken}));
      final responseData = json.decode(response.body);
//      print('error${responseData['error']}');
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      _token=responseData['id_token'];
      _userId=responseData['user_id'];
      _expiryDate= DateTime.now().add(Duration(seconds:int.parse(responseData['expires_in'])));
      _refreshToken=responseData['refresh_token'];
      notifyListeners();
      _tryAutoRefreshToken();
//      final prefs = await SharedPreferences.getInstance();
      final userData=json.encode({'token':_token,'userId':_userId,'expiryDate':_expiryDate.toIso8601String(),'refreshToken':_refreshToken,'first':_first,'last':_last,'mobile':_mobile,'email':_email},);
      prefs.setString('userData', userData);
    } catch(error){
      throw error;
    }
  }

  void _tryAutoRefreshToken(){
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), refreshIdToken);
  }

  Future<void> logout() async{
    _token = null;
    _userId = null;
    _expiryDate = null;
    _refreshToken =null;
    _first=null;
    _mobile=null;
    _last=null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }

}
