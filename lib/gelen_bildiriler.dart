import 'package:beldapp/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class BildiriGelen extends StatefulWidget {


  BildiriGelen({Key? key, required this.data}) : super(key: key);

  var data;
  @override
  State<BildiriGelen> createState() => _BildiriGelenState();
}

class _BildiriGelenState extends State<BildiriGelen> {

  var currentItem = itemList.getData;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  var info;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Gelen Bildiriler',style:TextStyle(
              color:Colors.white,
              fontWeight:FontWeight.w400,
              fontFamily:"OpenSans",
              fontSize: 18),),
          toolbarHeight: 80,
          backgroundColor:Color(0xfff20c60),
          shape: RoundedRectangleBorder(

              borderRadius:  BorderRadius.only(

                  bottomRight: Radius.circular(70),

                  bottomLeft: Radius.circular(70))

          ),
          elevation: 14,
          leading: IconButton(
            icon: Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {},
          ), //IconButton
        ),
        body: Container(
          child: StreamBuilder<QuerySnapshot>(
            stream: widget.data,
            builder: (context, snapshot){
              if(snapshot.hasError){
                return Text("Bir şeyler yanlış gidiyor");
              }
              if(snapshot.connectionState == ConnectionState.waiting){
                return Center(
                  child: SizedBox(
                      height: 30,
                      width: 30,
                      child: CircularProgressIndicator()
                  ),
                );
              }
              else{
                final data = snapshot.requireData;
                return ListView.builder(
                  itemCount: currentItem.length,
                  itemBuilder: (context, index){
                    var description = data.docs[index]["description"];
                    var image = data.docs[index]["image"];
                    var title = data.docs[index]["title"];
                    var type = data.docs[index]["type"];
                    return ListTile(
                      trailing: Text(type),
                      leading: CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(image),
                      ),
                      title: Text(title, style: TextStyle(color: Colors.black),),
                      subtitle: Text(description),
                    );
                  },

                );
              }

            },
          ),
        )


    );
  }


}

class itemList {
  static final getData = [

    {
      'title': 'jhjknk',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': 'lmlşö',
      'type': 'jklmlk',
    },
    {
      'title': 'jhjknk',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': 'lmlşö',
      'type': 'jklmlk',
    },
    {
      'title': 'jhjknk',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': 'lmlşö',
      'type': 'jklmlk',
    },
    {
      'title': 'jhjknk',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': 'lmlşö',
      'type': 'jklmlk',
    },
    {
      'title': 'jhjknk',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': 'lmlşö',
      'type': 'jklmlk',
    },
    {
      'title': 'jhjknk',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': 'lmlşö',
      'type': 'jklmlk',
    },


  ];
}