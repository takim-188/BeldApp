import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



class AuthenticationService with ChangeNotifier{

  AuthenticationService(this.firebaseAuth);

  final FirebaseAuth firebaseAuth;

  TextEditingController controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? errorMessage;
  String? errorMessage2;

  Stream<User?> get authService => firebaseAuth.authStateChanges();

  Future<String> signIn(String? email, String? password) async{
    try{
      await firebaseAuth.signInWithEmailAndPassword(email: email!, password: password!);
      print("Signed in");
      return "Signed in";
    }on FirebaseAuthException catch(e){
      return e.message!;
    }
  }

  // postDetailsToFirestore() async {
  //
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = firebaseAuth.currentUser;
  //
  //   UserModel userModel = UserModel();
  //
  //   userModel.email = user!.email;
  //   userModel.uid = user.uid;
  //   userModel.name = controller.text;
  //   userModel.address = addressController.text;
  //
  //   await firebaseFirestore
  //       .collection("users")
  //       .doc(user.uid)
  //       .set(userModel.toMap());
  //   Fluttertoast.showToast(msg: "Account created successfully :) ");
  //
  // }

  // postDetailsToFirestoreAdmin() async {
  //
  //   FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  //   User? user = firebaseAuth.currentUser;
  //
  //   UserModel userModel = UserModel();
  //
  //   userModel.email = user!.email;
  //   userModel.uid = user.uid;
  //   userModel.name = controller.text;
  //   userModel.address = addressController.text;
  //
  //   await firebaseFirestore
  //       .collection("admins")
  //       .doc(user.uid)
  //       .set(userModel.toMap());
  //   Fluttertoast.showToast(msg: "Account created successfully :) ");
  //
  // }

  Future<String> signUp({String? email, String? password}) async{
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
      print("Signed up");
      return "Signed Up";
    }on FirebaseAuthException catch(e){
      return e.message!;
    }
  }
  Future<String> signUpAdmin(String? email, String? password) async{
    try{
      await firebaseAuth.createUserWithEmailAndPassword(email: email!, password: password!);
      print("Signed up");
      return "Signed Up";
    }on FirebaseAuthException catch(e){
      return e.message!;
    }
  }


  // Future<String?> signUpAdmin(String? email, String? password) async{
  //   try {
  //     await firebaseAuth
  //         .createUserWithEmailAndPassword(email: email!, password: password!)
  //         .then((value) => {postDetailsToFirestoreAdmin()})
  //         .catchError((e) {
  //       Fluttertoast.showToast(msg: e!.message);
  //     });
  //   } on FirebaseAuthException catch (error) {
  //     switch (error.code) {
  //       case "invalid-email":
  //         errorMessage2 = "Your email address appears to be malformed.";
  //         break;
  //       case "wrong-password":
  //         errorMessage2 = "Your password is wrong.";
  //         break;
  //       case "user-not-found":
  //         errorMessage2 = "User with this email doesn't exist.";
  //         break;
  //       case "user-disabled":
  //         errorMessage2 = "User with this email has been disabled.";
  //         break;
  //       case "too-many-requests":
  //         errorMessage2 = "Too many requests";
  //         break;
  //       case "operation-not-allowed":
  //         errorMessage2 = "Signing in with Email and Password is not enabled.";
  //         break;
  //       default:
  //         errorMessage2 = "An undefined Error happened.";
  //     }
  //     Fluttertoast.showToast(msg: errorMessage2!);
  //     print(error.code);
  //   }
  // }

  Future<String> signOut() async{
    try{
      await firebaseAuth.signOut();
      print("Signed out");
      return "Signed out";
    }on FirebaseAuthException catch(e){
      return e.message!;
    }
  }
}