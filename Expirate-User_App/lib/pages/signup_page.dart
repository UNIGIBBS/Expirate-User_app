import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comp2/pages/home_page.dart';
import 'package:comp2/pages/signin_page.dart';
import 'package:comp2/widgets/SignInSignUpButton.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user_model.dart';
import '../services/auth.dart';
import '../widgets/bottomNavigationBar.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _auth = FirebaseAuth.instance;
  String? errorMessage;
  var auth = AuthenticationService(FirebaseAuth.instance);
  bool _obscureText = true;

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  String? text = "";
  final _registerFormKey = GlobalKey<FormState>();

  TextEditingController controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordController2 = TextEditingController();
  TextEditingController addressController = TextEditingController();


  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
          color: Colors.white,
          width: width,
          height: size.height,
          child: ListView(children: <Widget>[
            SingleChildScrollView(
              child: Form(
                key: _registerFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.03,
                    ),
                    // Text("SIGNUP", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 8),
                      child: TextFormField(
                        autofocus: false,
                        cursorColor: Colors.redAccent,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          RegExp regex = new RegExp(r'^.{3,}$');
                          if (value!.isEmpty) {
                            return ("User Name cannot be Empty");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Enter Valid name(Min. 3 Character)");
                          }
                          return null;
                        },
                        controller: controller,
                        onChanged: (value) {},
                        onSaved: (value){
                          controller.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            labelText: "User Name",
                            hintText: "User Name",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                BorderSide(color: Colors.redAccent))),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 8),
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
                          emailController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        onChanged: (value) {},
                        cursorColor: Colors.redAccent,
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: "Email",
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                BorderSide(color: Colors.redAccent))),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 8),
                      child: TextFormField(
                        autofocus: false,
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
                        textInputAction: TextInputAction.next,
                        obscureText: _obscureText,
                        onChanged: (value) {},
                        cursorColor: Colors.redAccent,
                        keyboardType: TextInputType.text,
                        controller: passwordController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: _obscureText
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: _toggle,
                            ),
                            labelText: "Password",
                            hintText: "Password",
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
                        validator: (value) {
                          if (passwordController2.text !=
                              passwordController2.text) {
                            return "Password don't match";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordController2.text = value!;
                        },
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {},
                        cursorColor: Colors.redAccent,
                        obscureText: _obscureText,
                        keyboardType: TextInputType.text,
                        controller: passwordController2,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: _obscureText
                                  ? Icon(Icons.visibility_off)
                                  : Icon(Icons.visibility),
                              onPressed: _toggle,
                            ),
                            labelText: "Confirm Password",
                            hintText: "Confirm Password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                    color: Colors.redAccent,
                                    style: BorderStyle.solid))),
                      ),
                    ),
                    SingInSingUpButton(
                      context: context,
                      isLogin: false,
                      boyut: 0.8,
                      onTap: () async {
                        auth.signUp(emailController.text, passwordController.text).then((value)async{

                          await FirebaseFirestore.instance.collection("users").doc("${FirebaseAuth.instance.currentUser?.uid}").set({
                            "username": controller.text,
                            "email": emailController.text,



                          });

                        });
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.0001,
                    ),
                  ],
                ),
              ),
            ),
          ])),
    );
  }



}
