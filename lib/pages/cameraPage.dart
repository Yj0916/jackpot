import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:jackpot/service/data.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:jackpot/style.dart' as style;

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  final picker = ImagePicker();

  Future getImage(int imageNumber) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
      } else {
        print('No image selected.');
      }
    });
    saveImage(imageNumber, pickedFile.path);
  }

  void saveImage(int photoNumber,String path) async{
    final databaseReference = Firestore.instance;
    await databaseReference.collection("PlantData")
        .document("PlantImage").updateData({
      'path'+photoNumber.toString():path,
    });
    setState(() {
      print('saved Image');
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FutureBuilder(
                future: imageLinkRetrieve(1),
                builder:(BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.hasData == false){
                print('now loading!');
                return GestureDetector(
                  onTap: (){
                    getImage(1);
                  },
                  child: Container(
                    padding: EdgeInsets.only(top: 170,bottom: 170),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Center(child: Text('갤러리에서 이미지를 선택해 주세요.')),
                  ),
                );
              }
              else if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: TextStyle(fontSize: 15),
                  ),
                );
              }
              else{
                return GestureDetector(
                  onLongPress: (){
                    setState(() {
                      Alert(context: context,title: '삭제',desc: '이미지를 삭제하시겠습니까?',buttons: [
                        DialogButton(
                          child: Text(
                            "삭제",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () {
                            setState(() {
                              RemoveImage(1);
                              Navigator.pop(context);
                            });
                          },
                          color: Colors.red[300] ,
                        ),
                        DialogButton(
                          child: Text(
                            "아니요",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          onPressed: () => Navigator.pop(context),
                          color: style.buttonColor,
                        )
                      ]).show();
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 2), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Image.file(File(snapshot.data)),
                  ),
                );
              }
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder(
                    future: imageLinkRetrieve(2),
                    builder:(BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.hasData == false){
                        print('now loading!');
                        return GestureDetector(
                          onTap: (){
                            getImage(2);
                          },
                          child: Container(
                            padding: EdgeInsets.all(80),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(child: Icon(Icons.add)),
                          ),
                        );
                      }
                      else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }
                      else{
                        return GestureDetector(
                          onLongPress: (){
                            setState(() {
                              Alert(context: context,title: '삭제',desc: '이미지를 삭제하시겠습니까?',buttons: [
                                DialogButton(
                                  child: Text(
                                    "삭제",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      RemoveImage(2);
                                      Navigator.pop(context);
                                    });
                                  },
                                  color: Colors.red[300] ,
                                ),
                                DialogButton(
                                  child: Text(
                                    "아니요",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  color: style.buttonColor,
                                )
                              ]).show();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.file(File(snapshot.data),width: 170),
                          ),
                        );
                      }
                    }),
                FutureBuilder(
                    future: imageLinkRetrieve(3),
                    builder:(BuildContext context, AsyncSnapshot snapshot){
                      if(snapshot.hasData == false){
                        print('now loading!');
                        return GestureDetector(
                          onTap: (){
                            getImage(3);
                          },
                          child: Container(
                            padding: EdgeInsets.all(80),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(child: Icon(Icons.add)),
                          ),
                        );
                      }
                      else if (snapshot.hasError) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Error: ${snapshot.error}',
                            style: TextStyle(fontSize: 15),
                          ),
                        );
                      }
                      else{
                        return GestureDetector(
                          onLongPress: (){
                            setState(() {
                              Alert(context: context,title: '삭제',desc: '이미지를 삭제하시겠습니까?',buttons: [
                                DialogButton(
                                  child: Text(
                                    "삭제",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      RemoveImage(3);
                                      Navigator.pop(context);
                                    });
                                  },
                                  color: Colors.red[300] ,
                                ),
                                DialogButton(
                                  child: Text(
                                    "아니요",
                                    style: TextStyle(color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () => Navigator.pop(context),
                                  color: style.buttonColor,
                                )
                              ]).show();
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 1,
                                  offset: Offset(0, 2), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Image.file(File(snapshot.data),width: 170,),
                          ),
                        );
                      }
                    }),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                imageContainer(Icon(Icons.add)),
                imageContainer(Icon(Icons.add)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget imageContainer(Widget widget){
  return GestureDetector(
    onTap: null,
    child: Container(
      padding: EdgeInsets.all(80),
      margin: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 1,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: widget,
    ),
  );
}

