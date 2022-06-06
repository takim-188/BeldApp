
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'SignInSignUpButton.dart';
import 'auth.dart';
import 'forgot_password_page.dart';



class UserSignInPage extends StatefulWidget {
  const UserSignInPage({Key? key}) : super(key: key);

  @override
  _UserSignInPageState createState() => _UserSignInPageState();
}

class _UserSignInPageState extends State<UserSignInPage> {
  bool _obscureText = true;

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
                          width * 0.05, 4, width * 0.05, 20),
                      child: SizedBox(
                        height: 50,
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
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.05, 4, width * 0.05, 20),
                      child: SizedBox(
                        height: 50,
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
                        child: Text("Şifremi Unuttum?"))
                  ],
                ),
              ),
            ),
          ])),
    );
  }



}
