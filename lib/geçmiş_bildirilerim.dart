import 'package:flutter/material.dart';

class LastNotification extends StatefulWidget {
  const LastNotification({Key? key}) : super(key: key);

  @override
  State<LastNotification> createState() => _LastNotificationState();
}

class _LastNotificationState extends State<LastNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geçmiş Bildirilerim'),
        toolbarHeight: 80,
        backgroundColor:Color(0xfff20c60),
        shape: RoundedRectangleBorder(

            borderRadius:  BorderRadius.only(

                bottomRight: Radius.circular(70),

                bottomLeft: Radius.circular(70))

        ),
        elevation: 14,
        actions: [

          Row(

            children: [

              SizedBox(width: 10,),
              Container(

                height: 40,width: 40,

                alignment: Alignment.center,

                decoration: BoxDecoration(

                    boxShadow: [

                      BoxShadow(blurRadius: 7,spreadRadius: 3,

                          color: Color(0xfff20c60)

                      )

                    ],

                    shape: BoxShape.circle,

                    color: Colors.pink.shade400

                ),

                child: Icon(Icons.logout,size: 20,

                ),

              ),

              SizedBox(width: 26,)

            ],

          )

        ],
      ),
      body: FittedBox(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            children: const [
              Align(
                alignment: Alignment.centerRight,
                child: Text('GG/AA/YYYY SS:DD'),
              ),
              SizedBox(height: 16 ),

              Text(
                'Bildirim Detayı',
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold) ,
              ),
              //SizedBox(height: 16.0,)
              // Image(image: AssetImage(assetName))  // Bildirim detayı resim olacaksa aktif edin
              SizedBox(height: 16.0),
              Text(
                "Bildirim Açıklama Alanı",
                style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}