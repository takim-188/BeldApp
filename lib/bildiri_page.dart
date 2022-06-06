import 'dart:io';
import 'dart:ui';

import 'package:beldapp/user_location_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';



class BildiriPage extends StatefulWidget {
  @override
  State<BildiriPage> createState() => _BildiriPageState();
}

class _BildiriPageState extends State<BildiriPage> {
  late String text = '';
  TextEditingController controller = TextEditingController();
  String? selectedType;
  SharedPreferences? prefs;
  static const String SELECTED_TYPE = "SELECTED_TYPE";
  static const String TEXT = "TEXT";

  String value = "";
  var _imageUrl;
  MapController mapController = MapController();
  late TextEditingController _controller;
  double zoomValue = 15;

  @override
  void initState() {
    getSharedPrefs();
    _controller = TextEditingController();
  }

  getSharedPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedType = prefs!.getString(SELECTED_TYPE);
      text = prefs!.getString(TEXT) ?? '';
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  var _picker = ImagePicker();

  String dropdownValue = 'Diğer';
  List<String> types = [
    'Park ve Yeşil Alan Bakım ve Onarım',
    'Kaldırım İşgali',
    'Temizlik Faaliyetleri',
    'Çöp Toplama Hizmeti',
    'Aydınlatma',
    'Kanalizasyon ve Altyapı Hizmetleri',
    'Diğer'
        'TEXT'
        'SELECTED_TYPE'
  ];

  List<LatLng> listOfCoordinates = [
    LatLng(38.9637, 35.2433),
    LatLng(38.9, 35.243)
  ];

  TextEditingController titleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var userLocation = Provider.of<UserLocation?>(context);
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: ListView(
        children: [
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: EdgeInsets.only(top: 0,left: 20,right: 20),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () async {
                    return await showDialog(
                        context: context,
                        builder: (BuildContext context) => SimpleDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0))),
                          title: Text("Fotoğraf ekle",

                          ),
                          children: [
                            SimpleDialogOption(
                              onPressed: () async {
                                Navigator.pop(context);

                                final pickedFile =
                                await _picker.pickImage(
                                  source: ImageSource.camera,
                                  imageQuality: 10,
                                );

                                File file = File(pickedFile!.path);

                                print(file.toString());

                                String videoId = "${Uuid().v1()}";

                                print(videoId);

                                final ref = FirebaseStorage.instance
                                    .ref()
                                    .child("Product pictures")
                                    .child(videoId);

                                await ref.putFile(file);

                                String link = await ref.getDownloadURL();

                                setState(() {
                                  _imageUrl = link;
                                });

                                print(_imageUrl);
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.camera_alt_outlined,
                                  size: 30,
                                ),
                                title: Text(
                                  "Kamera",

                                ),
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: () async {
                                Navigator.pop(context);
                                final pickedFile =
                                await _picker.pickImage(
                                    source: ImageSource.gallery,
                                    imageQuality: 10);
                                File file = File(pickedFile!.path);
                                final ref = FirebaseStorage.instance
                                    .ref()
                                    .child("Product pictures")
                                    .child("${Uuid().v1()}");
                                await ref.putFile(file);
                                String link = await ref.getDownloadURL();
                                print(link);
                              },
                              child: ListTile(
                                leading: Icon(
                                  Icons.image_outlined,
                                  size: 30,
                                ),
                                title: Text("Galeri",),
                              ),
                            )
                          ],
                        ));
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      height: 100,
                      width: 100,
                      decoration: _imageUrl == null
                          ? BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        //color: Colors.grey[300],
                      )
                          : BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[300],
                          image: DecorationImage(
                              image: NetworkImage(_imageUrl),
                              fit: BoxFit.cover)),
                      child: _imageUrl == null
                          ? Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: width / 7,
                      )
                          : Container(),
                    ),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 20, top:10,right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: height * 0.1,
                        width: width * 0.45,
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            //border:InputBorder.none,
                            label: Text("Bildiri Başlığı",),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      SingleChildScrollView(
                        child:Container(
                          height: 50,
                          width: 201,
                          alignment: Alignment.topLeft,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              //side: BorderSide(width: 0.1, style: BorderStyle.solid),
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                          ),
                          child: SingleChildScrollView(
                            child:
                            DropdownButton<String>(
                              itemHeight: null,
                              isExpanded:true,
                              value: dropdownValue,
                              icon: Icon(Icons.arrow_drop_down, color: Color(0xfff20c60),),
                              elevation: 16,
                              underline: Container(
                                alignment: Alignment.centerLeft,
                                decoration: ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(width: 1.0, style: BorderStyle.solid),
                                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                  ),
                                ),
                                height: 2,
                              ),
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                });
                              },
                              items: <String>[
                                'Park ve Yeşil Alan Bakım ve Onarım',
                                'Kaldırım İşgali',
                                'Temizlik Faaliyetleri',
                                'Çöp Toplama Hizmeti',
                                'Aydınlatma',
                                'Kanalizasyon ve Altyapı Hizmetleri',
                                'Diğer'
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                    value: value,
                                    child: Container(
                                      alignment: Alignment.centerLeft,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          //side: BorderSide(width: 1.0, style: BorderStyle.solid),
                                          borderRadius: BorderRadius.all(Radius.circular(15)),
                                        ),
                                      ),
                                      padding: const EdgeInsets.all(8.0),
                                      child:Text(value,),
                                    ));
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: height * 0.01,
              ),
              Padding(
                padding: EdgeInsets.only(top: 5,left: 20,right: 20),
                child: Flexible(
                  flex: 1,
                  child:TextField(
                    maxLines: 3,
                    minLines: 1,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      label: Text("Bildiri Açıklaması"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                              style: BorderStyle.solid)),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height*0.01,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top:10,left: 15, right: 15),
            child: Card(
              shape: RoundedRectangleBorder(
                //side: BorderSide(style: BorderStyle.solid, width: 1),
                borderRadius:BorderRadius.circular(20),
              ),
              elevation: 10,
              child: SizedBox(
                height: width / 2,
                width: width * 0.6,
                child: Card(
                  shape: RoundedRectangleBorder(
                    //side: BorderSide(style: BorderStyle.solid, width: 1),
                    borderRadius:BorderRadius.circular(20),
                  ),
                  elevation: 10,
                  child: userLocation != null
                      ? FlutterMap(
                    mapController: mapController,
                    options: MapOptions(
                        center: LatLng(userLocation.latitude!,
                            userLocation.longitude!),
                        zoom: zoomValue),
                    layers: [
                      TileLayerOptions(
                        urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                        subdomains: ['a', 'b', 'c'],
                      ),
                      MarkerLayerOptions(markers: [
                        Marker(
                            point: LatLng(userLocation.latitude!,
                                userLocation.longitude!),
                            builder: (context) => IconButton(
                              icon:
                              Icon(Icons.person_pin_circle_sharp),
                              iconSize: height * 0.03,
                              color: Color(0xfff20c60),
                              onPressed: () {},
                            )),
                        Marker(
                            point: listOfCoordinates[1],
                            builder: (context) => IconButton(
                              icon:
                              Icon(Icons.person_pin_circle_sharp),
                              iconSize: height * 0.03,
                              color: Colors.blue,
                              onPressed: () {},
                            )),
                      ])
                    ],
                  )
                      : Container(),
                ),
              ),
            ),
          ),
          SizedBox(
            height: height * 0.01,
          ),
          // Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //   children: [
          //     Text("Enlem: ${userLocation!.latitude}",
          //       style: style_arguments(
          //           Colors.black.withOpacity(1),
          //           FontWeight.w400,
          //           15,
          //           'OpenSans'),),
          //     Text("Boylam: ${userLocation!.longitude}",
          //       style: style_arguments(
          //           Colors.black.withOpacity(1),
          //           FontWeight.w400,
          //           15,
          //           'OpenSans'),),
          //   ],
          // ),
          Padding(
            padding: EdgeInsets.only(left: 2,top: 30,right: 2),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width:120,
                height: 35,
                margin: const EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                child: ElevatedButton(
                  style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.resolveWith((states){
                    //   if(states.contains(MaterialState.pressed)){
                    //     return Colors.black26;
                    //   }
                    //   return Colors.white;
                    // }),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      )
                  ),
                  onPressed: () async {
                    // titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && dropdownValue.isNotEmpty && _imageUrl != null ? await FirebaseFirestore.instance.collection("users").doc("${FirebaseAuth.instance.currentUser?.uid}").collection("bildiriler").add({
                    //   "title": titleController.text,
                    //   "type": dropdownValue,
                    //   "description": descriptionController.text,
                    //   "user": FirebaseAuth.instance.currentUser?.uid,
                    //   "image": _imageUrl,
                    //
                    // }) :
                    titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && _imageUrl != null ? await FirebaseFirestore.instance.collection("Bildiriler").add({
                      "title": titleController.text,
                      "description": descriptionController.text,
                      "type": dropdownValue,
                      "user": FirebaseAuth.instance.currentUser?.uid,
                      "image": _imageUrl,

                    }) : print("Fill the gaps");

                  },
                  child: Text('Bildir'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
