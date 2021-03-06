import 'package:flutter/material.dart';
import 'package:jackpot/pages/graphPage.dart';
import 'package:jackpot/pages/indexPage.dart';
import 'package:jackpot/pages/plantRegister.dart';
import 'package:jackpot/pages/plantRegister2.dart';
import 'package:jackpot/pages/settingPage.dart';
import 'pages/mainPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'jackPot',
        debugShowCheckedModeBanner: false,
      home: IndexPage(),
      routes: {
        '/search' : (context)=>PlantRegister(),
        '/select': (context) => SelectedWidget(),
        '/index': (context) => IndexPage(),
      },
    );
  }
}
