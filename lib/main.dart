
import 'dart:io';

import 'package:beldapp/page.dart';
import 'package:beldapp/splash_screen.dart';
import 'package:beldapp/user_model.dart';
import 'package:beldapp/user_type_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'auth.dart';
import 'botnav.dart';
import 'home_page.dart';
import 'location_service.dart';

Future<void> main() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp(),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initializtion = Firebase.initializeApp();
  @override
  Widget build(BuildContext context){

    return StreamProvider(
      create: (context) => LocationService().locationStream, initialData: null,
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider<AuthenticationService>(create: (BuildContext context)=> AuthenticationService(FirebaseAuth.instance)),
          ChangeNotifierProvider<SLpage>(create: (BuildContext context) => SLpage()),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Color(0xff22e3d7),
                primarySwatch: Colors.pink,

                buttonColor: Color(0xfff20c60),
                accentColor: Color(0xfff20c60),
                cursorColor:Color(0xfff20c60),
                highlightColor: Color(0xfff20c60),
                scaffoldBackgroundColor: Color(0xffededed)
            ),
            home: FutureBuilder(
              future:  _initializtion,
              builder: (context, snapshot){
                if(snapshot.hasError){
                  return Center(child: Text("Error"),);
                }
                else if(snapshot.hasData){
                  return StreamBuilder<User?>(
                    stream: AuthenticationService(FirebaseAuth.instance).authService,
                    builder: (context, snapshot) {
                      Widget returnedChild;
                      if(snapshot.connectionState == ConnectionState.waiting){
                        returnedChild = CircularProgressIndicator();
                      }else{
                        if (snapshot.data == null) {
                          returnedChild = CommonPage();
                        }else{
                          returnedChild = UserSignInBotNav();
                        }
                      }
                      return returnedChild;
                    },

                  );
                }
                else{
                  return Center(child: CircularProgressIndicator(),);
                }
              },
            )
        ),
      ),
    );
  }
}


class CommonPage extends StatefulWidget {
  const CommonPage({Key? key}) : super(key: key);

  @override
  _CommonPageState createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(

      body: Provider.of<SLpage>(context).Login,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: height * 0.2,
        centerTitle: true,
        title: SwitchListTile(
          activeColor: Colors.blueGrey,
          autofocus: false,
          title: Provider.of<SLpage>(context).isLogin?
          Text("Giriş Yap", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),):
          Text("Kaydol",  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          onChanged: (_){
            Provider.of<SLpage>(context, listen: false).toggleLogin();
          },
          value: Provider.of<SLpage>(context).isLogin,
        ),
      ),

    );

  }
}

