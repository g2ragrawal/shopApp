import 'package:flutter/material.dart';
import 'package:jain_namkin/model/home_model.dart';
import 'package:jain_namkin/model/http_exception.dart';
import 'package:jain_namkin/provider/auth_provider.dart';
import 'package:jain_namkin/widgets/button_widget.dart';
import 'package:jain_namkin/widgets/textfied_wigdet.dart';
import 'package:provider/provider.dart';

enum AuthMode { login, signUp }

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    var model=Provider.of<HomeModel>(context);
    return Scaffold(
      body: AuthCard(model: model,),
    );
  }
}

class AuthCard extends StatefulWidget {
  final HomeModel model;

  AuthCard({this.model});

  @override
  _AuthCardState createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard> {
  var _authModel = AuthMode.login;
  bool _isLoading = false;
  Map<String, String> _authData = {'email': '', 'password': ''};
  Map<String,String> _userData = {'first':'','last':'','mobile':''};
  final GlobalKey<FormState> _form = GlobalKey();
  final _passwordController = TextEditingController();

  void _changeState() {
    if (_authModel == AuthMode.login) {
      setState(() {
        _authModel = AuthMode.signUp;
      });
    } else {
      setState(() {
        _authModel = AuthMode.login;
      });
    }
  }



  void _errorOccured(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Some Error Occured',
          ),
          content: Text(message),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('okay'),
            )
          ],
        ));
  }

  Future<void> _submit() async {
    if (!_form.currentState.validate()) {
      return;
    }
    _form.currentState.save();
    setState(() {
      _isLoading = true;
    });
    try {
      if (_authModel == AuthMode.login) {
        await Provider.of<Auth>(context, listen: false)
            .login(_authData['email'], _authData['password']);
      } else {
        await Provider.of<Auth>(context, listen: false)
            .signup(_authData['email'], _authData['password'],_userData['first'],_userData['last'],_userData['mobile'],);
      }
    } on HttpException catch (error) {
      print(1);
      var errorMessage = 'Authentication Failed';
      if (error.toString().contains('EMAIL_EXISTS')) {
        errorMessage = 'Account Already Exists With Email';
      }
      else if (error.toString().contains('INVALID_EMAIL')) {
        errorMessage = 'Invalid Email';
      }
      else if (error.toString().contains('WEAK_PASSWORD')) {
        errorMessage = 'Password is too weak try with another password';
      }
      else if (error.toString().contains('EMAIL_NOT_FOUND')) {
        errorMessage = 'Can\'t find person with email';
      }
      else if (error.toString().contains('INVALID_PASSWORD')) {
        errorMessage = 'oops! Password is wrong.';
      }
      _errorOccured(errorMessage);
    } catch (error) {
      print(error);
      final errorMessage = 'Unable to login this time. plz try after some time';
      _errorOccured(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _form,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(height: MediaQuery.of(context).size.height/5,child: _authModel==AuthMode.login?Center(child: Text('Login',style: TextStyle(color: Colors.redAccent,fontSize: 22),)):Center(child: Text('Sign Up',style: TextStyle(color: Colors.redAccent,fontSize: 22),)),),
              TextFieldWidget(
                text: 'Email',
                isObscuredText: false,
                icon: Icons.email,
                preIcon: widget.model.isValid ? Icons.check : Icons.error,
                onChanged: (value) {
                  widget.model.isCorrectEmail(value);
                },
                validator: (value) {
                  RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                      .hasMatch(value)
                      ? widget.model.isValid = true
                      : widget.model.isValid = false;
                },
                onSaved: (value) {
                  _authData['email'] = value;
                },
              ),
              SizedBox(
                height: 18,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  TextFieldWidget(
                    text: 'Password',
                    isObscuredText: widget.model.isVisible ? false : true,
                    icon: Icons.lock,
                    controller: _passwordController,
                    preIcon: widget.model.isVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onChanged: (value) {
                      widget.model.isCorrectPassword(value);
                    },
                    onTapIcon: () {
                      widget.model.isVisible = !widget.model.isVisible;
                    },
                    onSaved: (value) {
                      _authData['password'] = value;
                    },
                  ),
                  SizedBox(
                    height: _authModel == AuthMode.login ? 5 : 18,
                  ),
                  _authModel == AuthMode.login
                      ? FlatButton(
                    onPressed: (){},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  )
                      : TextFieldWidget(
                    text: 'Confirm Password',
                    isObscuredText:
                    widget.model.isConfirmVisible ? false : true,
                    icon: Icons.lock,
                    preIcon: widget.model.isConfirmVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    onTapIcon: () {
                      widget.model.isConfirmVisible =
                      !widget.model.isConfirmVisible;
                    },
                    validator: (value) {
                      if (_passwordController.text != value) {
                        print(_passwordController.text);
                        print(value);
                        return 'Password doesn\'t match';
                      }
                      return null;
                    },
                  ),
                  if(_authModel == AuthMode.signUp)
                    Wrap(children: <Widget>[Column(children: <Widget>[SizedBox(height: 18,),Row(children: <Widget>[Expanded(child: TextFieldWidget(text: 'First',isObscuredText: false,onSaved: (value){_userData['first']=value;},validator: (value){if(value==null||value.length==0){return 'please enter';}return null;},)),SizedBox(width: 8,),Expanded(child: TextFieldWidget(text: 'Last',isObscuredText: false,onSaved: (value){_userData['last']=value;},validator: (value){if(value==null||value.length==0){return 'please enter';}return null;},)),],),SizedBox(height: 18,),TextFieldWidget(text: 'Mobile no.',isObscuredText: false,onSaved: (value){_userData['mobile']=value;},validator: (value){if(value==null||value.length==0){return 'please enter';}return null;},)],)], ),
                ],
              ),
              SizedBox(
                height: 18,
              ),
              Builder(
                builder: (context) => _isLoading
                    ? CircularProgressIndicator()
                    : ButtonWidget(
                  text: _authModel == AuthMode.login ? 'Login' : 'SignUP',
                  hasBorder: false,
                  clickFunction: _submit,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ButtonWidget(
                text: _authModel == AuthMode.login ? 'Sign Up' : 'Login',
                hasBorder: true,
                clickFunction: _changeState,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
