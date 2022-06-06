
import 'package:beldapp/user_signin_page.dart';
import 'package:beldapp/user_signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget signupPage = UserSignUpPage();
Widget signinPage = UserSignInPage();

class SLpage with ChangeNotifier{

  bool _isLogin = false;

  bool get isLogin => _isLogin;
  Widget get Login{
    return _isLogin? signinPage : signupPage;
  }
  void toggleLogin(){
    _isLogin = !_isLogin;
    notifyListeners();
  }


}