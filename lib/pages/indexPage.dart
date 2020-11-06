import 'package:flutter/material.dart';
import 'package:jackpot/pages/graphPage.dart';
import 'package:jackpot/style.dart' as style;
import 'mainPage.dart';
import 'plantRegister.dart';
import 'cameraPage.dart';
import 'graphPage.dart';
import 'settingPage.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  final List<Widget> _children = [MainPage(), CameraPage(),PlantRegister(),GraphPage(),SettingPage()];
  Widget build(BuildContext context) {
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
        backgroundColor: style.backgroundSkyBlue,
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: style.mainBlue,
            unselectedItemColor: Colors.black26,
            onTap: _onTap,
            currentIndex: _currentIndex,
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
            ])
    );
  }
}
