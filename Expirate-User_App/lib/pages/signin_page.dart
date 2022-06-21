import 'package:comp2/pages/forgot_password_page.dart';
import 'package:comp2/pages/home_page.dart';
import 'package:comp2/widgets/SignInSignUpButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../services/auth.dart';
import '../widgets/bottomNavigationBar.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final _signinFormKey = GlobalKey<FormState>();

  final _auth = FirebaseAuth.instance;
  var auth = AuthenticationService(FirebaseAuth.instance);

  String? errorMessage;
  String? text = "";
  TextEditingController controller = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          color: Colors.white,
          width: double.infinity,
          height: size.height,
          child: ListView(children: <Widget>[
            SingleChildScrollView(
              child: Form(
                key: _signinFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.1,
                    ),
                    //Text("LOGIN", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.05, 8, width * 0.05, 20),
                      child: TextFormField(
                        autofocus: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Please Enter Your Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Please Enter a valid email");
                          }
                          return null;
                        },

                        onSaved: (value) {
                          controller.text = value!;
                        },

                        textInputAction: TextInputAction.next,
                        onChanged: (value) {},
                        cursorColor: Colors.redAccent,
                        keyboardType: TextInputType.emailAddress,
                        controller: controller,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "Email",
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                BorderSide(color: Colors.redAccent))),
                      ),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.05, 8, width * 0.05, 20),
                      child: TextFormField(
                        autofocus: false,
                        onChanged: (value) {},
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{6,}$');
                          if (value!.isEmpty) {
                            return ("Password is required for login");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid Password(Min. 6 Character)");
                          }
                        },
                        onSaved: (value) {
                          passwordController.text = value!;
                        },
                        textInputAction: TextInputAction.done,
                        obscureText: _obscureText,
                        cursorColor: Colors.redAccent,
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        decoration: InputDecoration(
                            prefixIconColor: Colors.redAccent,
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: _obscureText
                                  ? Icon(Icons.visibility_off)
                                  : Icon(
                                Icons.visibility,
                              ),
                              onPressed: _toggle,
                            ),
                            labelText: "Password ",
                            hintText: "Password ",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                BorderSide(color: Colors.redAccent))),
                      ),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SingInSingUpButton(
                      context: context,
                      isLogin: true,
                      boyut: 0.8,
                      onTap: () async {
                        auth.signIn(controller.text, passwordController.text).then((uid) => {

                        });
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ForgotPasswordPage()));
                          });

                        },
                        child: Text("Forgot Password?"))
                  ],
                ),
              ),
            ),
          ])),
    );
  }



}
