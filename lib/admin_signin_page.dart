import 'package:beldapp/gelen_bildiriler.dart';
import 'package:beldapp/gelen_bildiriler_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SignInSignUpButton.dart';
import 'auth.dart';
import 'homepage2.dart';


class AdminSignIn extends StatefulWidget {
  const AdminSignIn({Key? key}) : super(key: key);

  @override
  State<AdminSignIn> createState() => _AdminSignInState();
}

class _AdminSignInState extends State<AdminSignIn> {
  bool _obscureText = true;
  var data;
  void initState() {
    super.initState();
    getImage();
  }

  getImage()async{
    data = FirebaseFirestore.instance.collection("Bildiriler").snapshots();
  }
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  final _signinFormKey = GlobalKey<FormState>();

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
    return  Scaffold(
      body: Container(
          color: Colors.white,
          width: double.infinity,
          height: size.height,
          child: ListView(children: <Widget>[
            SizedBox(height: 60,),
            Center(child: Text("Giriş Yap", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)),
            SingleChildScrollView(
              child: Form(
                key: _signinFormKey,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.07,
                    ),
                    //Text("LOGIN", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.05, 8, width * 0.05, 20),
                      child: TextFormField(
                        autofocus: false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ("Email");
                          }
                          // reg expression for email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                              .hasMatch(value)) {
                            return ("Geçerli bir email adresi giriniz");
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
                            return ("Şifre giriş için gereklidir!");
                          }
                          if (!regex.hasMatch(value)) {
                            return ("Geçerli bir şifre giriniz(Min. 6 Karakter)");
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
                        auth.signIn(controller.text, passwordController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BildiriGelen(data: data)));
                      },
                    ),
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                  ],
                ),
              ),
            ),
          ])),
    );
  }
}
