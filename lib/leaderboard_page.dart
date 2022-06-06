import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'belediye_model.dart';


class ProfileList extends StatefulWidget {
  const ProfileList({Key? key}) : super(key: key);

  @override
  State<ProfileList> createState() => _ProfileListState();
}

class _ProfileListState extends State<ProfileList> {

  List<Patient> items = [
    Patient("İzmir Büyükşehir Belediyesi","11293", 'assets/images/izmir.jpg', "İzmir" ),
    Patient("Kartal Belediyesi","2330", 'assets/images/kartal.png', "İstanbul" ),
    Patient("Kayseri Büyükşehir Belediyesi", '2245','assets/images/kayseri.png', "Kayseri" ),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(

            borderRadius:  BorderRadius.only(

                bottomRight: Radius.circular(70),

                bottomLeft: Radius.circular(70))

        ),
        elevation: 14,
        backgroundColor:Color(0xfff20c60),
        toolbarHeight: 80,
        centerTitle: true,
        title: Text("Lider Tablosu", style: TextStyle(color: Colors.white),),
        actions: [
          Padding(
            padding: EdgeInsets.all(20.0),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index){
          final item = items[index];
          return ListTile(
            trailing: Text('${item.score!}'),
            leading: CircleAvatar(
              radius: 28,
              backgroundImage: AssetImage(item.image),
            ),
            title: Text('${item.name!}', style: TextStyle(color: Colors.black),),
            subtitle: Text('${item.sehir!}' ),
          );
        },

      ),
    );
  }


}