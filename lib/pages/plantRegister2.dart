import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/service/plantInfo.dart';
import 'package:jackpot/style.dart' as style;

class SelectedWidget extends StatefulWidget {
  @override
  _SelectedWidgetState createState() => _SelectedWidgetState();
}

class _SelectedWidgetState extends State<SelectedWidget> {
  @override
  Widget build(BuildContext context) {
    final PlantInfo args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jackpot',
          style: style.titleStyle,
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black26),
        centerTitle: true,
      ),
      bottomNavigationBar:  BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: style.mainBlue,
          unselectedItemColor: Colors.black26,
          onTap: null,
          currentIndex: 2,
          items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 30,),
                title: Text('')
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.photo_camera,size: 30,),
                title: Text('')
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.add_box,size: 30,),
                title: Text('')
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.insert_chart,size: 30,),
                title: Text('')
            ),
            new BottomNavigationBarItem(
                icon: Icon(Icons.settings,size: 30,),
                title: Text('')
            )
          ]),
      drawer: Drawer(),
      body: FutureBuilder(
        future : getPlantDetail(args),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if(snapshot.hasData == false){
            return Text('now loading');
          }
          else{
            return Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20,bottom: 10,left: 20,),
                        child: Text(
                          '식물 등록',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                    ]),
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Image.network(
                        'http://www.nongsaro.go.kr/' +
                            snapshot.data.rtnFileCours +
                            "/" +
                            snapshot.data.rtnStreFileNm,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text('정보',style: style.blueText,),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(snapshot.data.fncltyInfo,style: style.infoText,),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(bottom: 30),
                      color: Color(0xfff0f8ff),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text('water',style: TextStyle(color: style.buttonColor,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.bubble_chart,color: style.mainBlue,),
                                  Icon(Icons.bubble_chart,color: style.mainBlue,),
                                  Icon(Icons.bubble_chart,color: style.mainBlue,),
                                  Icon(Icons.bubble_chart,color: style.lightBlue,),
                                  Icon(Icons.bubble_chart,color: style.lightBlue,)
                                ],
                              )
                            ],
                          ),
                          Column(
                            children: [
                              Text('light',style: TextStyle(color: style.buttonColor,fontWeight: FontWeight.bold),),
                              SizedBox(height: 10,),
                              Row(
                                children: [
                                  Icon(Icons.wb_sunny,color: style.mainBlue,),
                                  Icon(Icons.wb_sunny,color: style.mainBlue,),
                                  Icon(Icons.wb_sunny,color: style.mainBlue,),
                                  Icon(Icons.wb_sunny,color: style.lightBlue,),
                                  Icon(Icons.wb_sunny,color: style.lightBlue,)
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.only(top:15,bottom:15,right: 50,left: 50),
                            decoration: BoxDecoration(
                              color: style.buttonColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text('취소',style: style.settingButtonTextStyle,textAlign: TextAlign.center,),
                          ),
                        ),
                        GestureDetector(
                          onTap: null,
                          child: Container(
                            padding: EdgeInsets.only(top:15,bottom:15,right: 50,left: 50),
                            decoration: BoxDecoration(
                              color: style.buttonColor,
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: Text('등록완료',style: style.settingButtonTextStyle,textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
