


import 'package:beldapp/user_signup_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';



class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final _resetFormKey = GlobalKey<FormState>();
    Size size = MediaQuery
        .of(context)
        .size;
    double width = MediaQuery
        .of(context)
        .size
        .width;
    double height = MediaQuery
        .of(context)
        .size
        .height;
    return Scaffold(
      body: Container(
          color: Colors.white,
          width: double.infinity,
          height: size.height,
          child: ListView(children: <Widget>[
            SingleChildScrollView(
              child: Form(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: height * 0.3,
                    ),
                    Text("Reset Password", style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 8),
                      child: TextFormField(
                        validator: (val) {
                          if (!EmailValidator.validate(val!)) {
                            return 'Lütfen Geçerli bir adres giriniz';
                          } else {
                            return null;
                          }
                        },
                        onChanged: (value) {},
                        keyboardType: TextInputType.emailAddress,
                        controller: emailController,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            labelText: "Email",
                            hintText: "Email",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide:
                                BorderSide())),
                      ),
                    ),
                    Padding(
                      padding:
                      EdgeInsets.fromLTRB(width * 0.05, 8, width * 0.05, 8),
                      child: ElevatedButton(
                        onPressed: () {
                          // if (_resetFormKey.currentState!.validate()) {
                          //    FirebaseAuth.instance
                          //       .sendPasswordResetEmail(email: emailController.text);
                          //
                          //    _showMyDialog();
                          //
                          //
                          //   //_showMyDialog();
                          //
                          //   Navigator.pop(context);
                          // };

                          FirebaseAuth.instance
                              .sendPasswordResetEmail(
                              email: emailController.text)
                              .then((value) => SuccessMessage(context));
                        },
                        child: Text("Mail Gönder",style: TextStyle(color: Colors.black),),
                        style: ButtonStyle(
                            // backgroundColor:
                            // MaterialStateProperty.resolveWith((states) {
                            //   if (states.contains(MaterialState.pressed)) {
                            //     return Colors.black26;
                            //   }
                            //   return Colors.white;
                            // }),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                            )),
                      ),
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

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Password'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Please, control your email!'),
                Text('You can change your password with clicking to the link'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Okey'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  SuccessMessage(BuildContext context) {

    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => UserSignUpPage()));
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text("Submitted Successfully"),
      content: Text("An email has been sent. Please check your inbox"),
      actions: [
        okButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}



