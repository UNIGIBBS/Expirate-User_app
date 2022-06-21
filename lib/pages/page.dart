
import 'package:comp2/pages/signin_page.dart';
import 'package:comp2/pages/signup_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget signupPage = SignUpPage();
Widget signinPage = SignInPage();

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