import 'package:beldapp/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  void initState() {
    super.initState();
    getImage();
  }


  getImage()async{
    var data = FirebaseFirestore.instance.collection("Bildiriler").snapshots();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        title: Text("Gelen Bildiriler", style: TextStyle(color: Colors.black),),
        actions: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(DateFormat('yyyy-mm-dd \n KK:mm:ss').format(DateTime.now()), style: TextStyle(color: Colors.black),),
          ),
        ],
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: widget.data,
          builder: (context, snapshot){
            if(snapshot.hasError){
              return Text("something went wrong");
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
                  var user = data.docs[index]["user"];
                  return ListTile(
                    trailing: Text(title),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundImage: NetworkImage(image),
                    ),
                    title: Text(type, style: TextStyle(color: Colors.black),),
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
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },
    {
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },
    {
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },
    {
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },
    {
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },
    {
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },
    {
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },
    {
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },
    {
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },
    {
      'title': '',
      'image':
      'https://migros-dali-storage-prod.global.ssl.fastly.net/sanalmarket/product/11010010/11010010-1ae231-1650x1650.jpg',
      'description': '',
      'type': '',
    },


  ];
}
