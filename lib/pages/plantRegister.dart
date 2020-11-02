import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jackpot/pages/plantRegister2.dart';
import 'package:jackpot/service/plantInfo.dart';
import 'package:jackpot/style.dart' as style;
import 'package:flappy_search_bar/flappy_search_bar.dart';

class PlantRegister extends StatefulWidget {
  @override
  _PlantRegisterState createState() => _PlantRegisterState();
}

class _PlantRegisterState extends State<PlantRegister> {
  List<PlantInfo> plantList = List<PlantInfo>();
  TextEditingController controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = new TextEditingController();
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
      drawer: Drawer(),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(children: [
              Padding(
                padding: EdgeInsets.only(top: 20,bottom: 10),
                child: Text(
                  '식물 등록',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
            ]),
            Container(
              height: 300,
              child: SearchBar<PlantInfo>(
                cancellationWidget: Icon(Icons.close),
                  onSearch: searchPlantList,
                  searchBarStyle: SearchBarStyle(
                    backgroundColor: Colors.white,
                  ),
                  iconActiveColor: style.mainBlue,
                  hintText: '식물 이름을 입력해 주세요',
                  placeHolder: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('images/plants.png', width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                          Text('식물 관리를 위해서 내 식물을 등록해 주세요!')
                        ],
                      ),
                    ),
                  ),
                  minimumChars: 1,
                  onItemFound: (PlantInfo plant, int index) {
                    return ListTile(
                      title: Text(plant.plantName),
                      subtitle: Text(plant.plantCode),
                      leading: Image.network(
                        'http://www.nongsaro.go.kr/' +
                            plant.rtnFileCours +
                            "/" +
                            plant.rtnStreFileNm,
                        width: 80,
                        height: 80,
                      ),
                      onTap: (){
                        Navigator.pushNamed(context, '/select',arguments: plant);
                      },
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

}
