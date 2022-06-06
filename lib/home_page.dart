import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DataFromAPI(),
    );
  }
}

class DataFromAPI extends StatefulWidget{
  @override
  _DataFromAPIState createState() => _DataFromAPIState();

}

class _DataFromAPIState extends State<DataFromAPI>{
  getUserData()async{
    var response=await http.get(Uri.parse('https://openapi.izmir.bel.tr/api/ibb/kultursanat/etkinlikler'));
    var jsonData=jsonDecode(response.body);
    List<Userr> users=[];
    for(var u in jsonData){
      Userr user=Userr(u["KucukAfis"],u["KisaAciklama"],u["Adi"],u["Resim"],u["Tur"],u["EtkinlikMerkezi"],u["EtkinlikBaslamaTarihi"]);
      users.add(user);
    }
    print(users.length);
    return users;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Anasayfa'),
        centerTitle: true,
        toolbarHeight: 80,
        backgroundColor:Color(0xfff20c60),
        shape: RoundedRectangleBorder(

            borderRadius:  BorderRadius.only(

                bottomRight: Radius.circular(70),

                bottomLeft: Radius.circular(70))

        ),
        elevation: 14,
      ),
      body: Container(
        color: Colors.white,
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        width: 400,
        height: 530,
        child:FutureBuilder(
          future: getUserData(),
          builder: (context,AsyncSnapshot snapshot){
            if (snapshot.hasError) {

              return Text("${snapshot.error}");

            } else if(snapshot.hasData){
              return PageView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context,i){
                    return Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color:Color(0xfff20c60)),
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          alignment: Alignment.bottomCenter,
                          image: NetworkImage(snapshot.data[i].kucukAfis),
                          fit: BoxFit.contain,
                        ),
                      ),
                      child:ListTile(
                        title:Text(snapshot.data[i].Adi+"\n",style:TextStyle(
                            color:Colors.black,
                            fontWeight:FontWeight.w400,
                            fontFamily:"OpenSans",
                            fontSize: 18)),
                        subtitle:Text(snapshot.data[i].KisaAciklama+ "\n\n"
                            +"Etkinlik Merkezi:" + "\n" +snapshot.data[i].EtkinlikMerkezi+ "\n\n"
                            "Etkinlik Başlama Tarihi"+ "\n"+snapshot.data[i].EtkinlikBaslamaTarihi
                            ,style:TextStyle(
                                color:Colors.black,
                                fontWeight:FontWeight.w400,
                                fontFamily:"OpenSans",
                                fontSize: 12)),

                      ),
                    );
                  });
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
class Userr{
  final String kucukAfis,KisaAciklama,Adi,resim,Tur,EtkinlikMerkezi,EtkinlikBaslamaTarihi;
  Userr(this.kucukAfis,this.KisaAciklama,this.Adi,this.resim,this.Tur,this.EtkinlikMerkezi,this.EtkinlikBaslamaTarihi);
}