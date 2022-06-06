import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  @override
  _HelpPageState createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {

// value set to false
  bool _value = true;

// App widget tree
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yardım',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Yardım'),
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
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                ExpansionTile(
                  trailing: Icon(Icons.arrow_drop_down_circle,color: Color(0xfff20c60)),
                  title: Text("Bu uygulamada hangi işlemleri gerçekleştirebilirim?",style:TextStyle(
                      color:Colors.black,
                      fontWeight:FontWeight.w500,
                      fontFamily:"OpenSans",
                      fontSize: 15),),
                  children: [
                    Text("Anasayfanızdan belediyenin mevcut etkinliklerini görüntüleyebilir,"+"\n"
                        "Haritada belediye çalışanlarının konumunu görebilir,"+"\n"
                        "Bildir sayfasından öneri/istek/şikayet 'inizi gönderebilir,"+"\n"
                        "Bildiriniz gönderildikten sonra gelişimini takip edebilirsiniz."
                        ,style:TextStyle(
                            color:Colors.black,
                            fontWeight:FontWeight.w400,
                            fontFamily:"OpenSans",
                            fontSize: 13), textAlign: TextAlign.center),
                  ],
                ),
                ExpansionTile(

                  trailing: Icon(Icons.arrow_drop_down_circle,color: Color(0xfff20c60)),
                  title: Text("Nasıl kullanırım?",style:TextStyle(
                      color:Colors.black,
                      fontWeight:FontWeight.w500,
                      fontFamily:"OpenSans",
                      fontSize: 15),),
                  children: [
                    Text("Gerekli bilgilerle uygulamaya kayıt olduktan sonra giriş yapıp uygulamayı kullanmaya başlayabilirsiniz."+" \n"+
                        "Bildir sayfasına girdiğinizde bildirinizi, konumunuzu ve bildirinizin kategorisini seçip açıklamanızı yazarak gönderebilirsiniz."
                        ,style:TextStyle(
                            color:Colors.black,
                            fontWeight:FontWeight.w400,
                            fontFamily:"OpenSans",
                            fontSize: 13),  textAlign: TextAlign.center),
                  ],
                ),
                ExpansionTile(
                  trailing: Icon(Icons.arrow_drop_down_circle,color: Color(0xfff20c60)),
                  title: Text("Size nasıl güvenebilirim?",
                    style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w500,
                        fontFamily:"OpenSans",
                        fontSize: 15),),
                  children: [
                    Text("Kullanıcılarımızın haklarını önemsiyoruz ve Gizlilik Politikasında da belirtildiği şekilde verilerinizi özenle işliyoruz.",
                        style:TextStyle(
                            color:Colors.black,
                            fontWeight:FontWeight.w400,
                            fontFamily:"OpenSans",
                            fontSize: 13),  textAlign: TextAlign.center),
                  ],
                ),
                ExpansionTile(
                  trailing: Icon(Icons.arrow_drop_down_circle,color: Color(0xfff20c60)),
                  title: Text("Geçmiş bildirilerime ulaşabiliyor muyum?",style:TextStyle(
                      color:Colors.black,
                      fontWeight:FontWeight.w500,
                      fontFamily:"OpenSans",
                      fontSize: 15),),
                  children: [
                    Text("Profilinizde geçmiş bildirilerim bölümünden kontrol edebilirsiniz.",
                        style:TextStyle(
                            color:Colors.black,
                            fontWeight:FontWeight.w400,
                            fontFamily:"OpenSans",
                            fontSize: 13),textAlign: TextAlign.center),
                  ],
                ),
                ExpansionTile(
                  trailing: Icon(Icons.arrow_drop_down_circle,color: Color(0xfff20c60)),
                  title: Text("Uygulamanın konumuma erişmesi için izin vermemi isteyen bir istem aldım. Bunu neden görüyorum?",
                    style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w500,
                        fontFamily:"OpenSans",
                        fontSize: 15),),
                  children: [
                    Text("Mevcut konumunuza göre çevrenizdeki belediye çalışanı bildiriniz için harekete geçecektir."
                        ,style:TextStyle(
                            color:Colors.black,
                            fontWeight:FontWeight.w400,
                            fontFamily:"OpenSans",
                            fontSize: 13),  textAlign: TextAlign.center),
                  ],
                ),
              ],
            )
        ),
      ),
    );
  }
}
