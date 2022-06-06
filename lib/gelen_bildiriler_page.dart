import 'package:flutter/material.dart';


class GelenBildiriler extends StatefulWidget {
  @override
  _GelenBildirilerState createState() => _GelenBildirilerState();
}

class _GelenBildirilerState extends State<GelenBildiriler> {

// value set to false
  bool _value = true;

// App widget tree
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
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
        ), //AppBar
        body: SizedBox(
          width: 400,
          height: 400,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(//BoxDecoration
                children:[
                  CheckboxListTile(
                    title: const Text('1. Şikayet Başlığı',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15)),
                    subtitle: const Text('Tarih',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15)),
                    autofocus: false,
                    activeColor: Color(0xff22e3d7),
                    checkColor: Colors.white,
                    selected: _value,
                    value: _value,
                    onChanged: (value) {
                      if (value != null)
                        setState(() {
                          _value = value;
                        });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('2. Şikayet Başlığı',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15)),
                    subtitle: const Text('Tarih',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15),),
                    autofocus: false,
                    activeColor:Color(0xff22e3d7),
                    checkColor: Colors.white,
                    selected: _value,
                    value: _value,
                    onChanged: (bool? value) {
                      if (value != null)
                        setState(() {
                          _value = value;
                        });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('3. Şikayet Başlığı',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15),),
                    subtitle: const Text('Tarih',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15),),
                    autofocus: false,
                    activeColor: Color(0xff22e3d7),
                    checkColor: Colors.white,
                    selected: _value,
                    value: _value,
                    onChanged: (bool? value) {
                      if (value != null)
                        setState(() {
                          _value = value;
                        });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('4. Şikayet Başlığı',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15),),
                    subtitle: const Text('Tarih',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15),),
                    autofocus: false,
                    activeColor: Color(0xff22e3d7),
                    checkColor: Colors.white,
                    selected: _value,
                    value: _value,
                    onChanged: (bool? value) {
                      if (value != null)
                        setState(() {
                          _value = value;
                        });
                    },
                  ),
                  CheckboxListTile(
                    title: const Text('5. Şikayet Başlığı',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15),),
                    subtitle: const Text('Tarih',style:TextStyle(
                        color:Colors.black,
                        fontWeight:FontWeight.w400,
                        fontFamily:"OpenSans",
                        fontSize: 15),),
                    autofocus: false,
                    activeColor: Color(0xff22e3d7),
                    checkColor: Colors.white,
                    selected: _value,
                    value: _value,
                    onChanged: (value) {
                      if (value != null)
                        setState(() {
                          _value = value;
                        });
                    },
                  ),
                ], //CheckboxListTile
              ), //Container
            ), //Padding
          ), //Center
        ), //SizedBox
      ), //Scaffold
    ); //MaterialApp
  }
}
