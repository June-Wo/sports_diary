import 'dart:ffi';
import 'detail_diary.dart';
import 'package:flutter/material.dart';
import 'write_diary.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sports Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: '스포츠 다이어리'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  final List<Widget> myList = [
    ListItem(
        sportsName: '가슴',
        sportsKind: '벤치프레스',
        sportsTimes: 10,
        sportsWeight: 10
    ),
    ListItem(
        sportsName: '가슴',
        sportsKind: '벤치프레스',
        sportsTimes: 10,
        sportsWeight: 10
    ),
    ListItem(
        sportsName: '가슴',
        sportsKind: '벤치프레스',
        sportsTimes: 10,
        sportsWeight: 10
    ),

  ];

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      // body: ListView(children: widget.myList),
      body: ListView.builder(
          itemCount: widget.myList.length,
          itemBuilder: (BuildContext context, int index){
            return widget.myList[index];
            // return widget.myList[index];

      }),
      floatingActionButton: FloatingActionButton(
          onPressed: () async{
            final a = await Navigator.push(context, MaterialPageRoute(builder: (context) => MyDiary()));
            //final b = ListItem(a[0], a[1], a[3], a[2]);
            final getItem = ListItem(
                sportsName: a[0],
                sportsKind: a[1],
                sportsWeight: a[2],
                sportsTimes:  a[3]
            );
            setState(() {
              widget.myList.add(getItem);
            });
          },
          child: Icon(Icons.add,size: 30)),
    );
  }
}

class ListItem extends StatelessWidget {
  final String sportsName;

  final String sportsKind;

  /// 이것은 운동 횟수 입니다.
  final int sportsTimes;

  final int sportsWeight;

  const ListItem({required this.sportsName, required this.sportsKind, required this.sportsTimes, required this.sportsWeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => DetailDiary())
          );
        },
        child: sportsColumn(this.sportsName, this.sportsKind, this.sportsTimes, this.sportsWeight),
    );
  }

  Column sportsColumn(String sportsName, String sportsKind, int sportsTimes, int sportsWeight) {
    DateTime now =  DateTime.now();
    DateTime date =  DateTime(now.year, now.month, now.day);
    var weekday = ['월','화','수','목','금','토','일'];
    return Column(
    children: [
      Container(
        height: 100,
        width: double.infinity,
        child: Row(
          children: <Widget>[
            Expanded(
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    'https://mblogthumb-phinf.pstatic.net/20160627_36/algieba__1466988496606oAYqd_PNG/%B4%EB%C8%E4%B1%D9.png?type=w2'),
                radius: 45,
              ),
              flex: 2,
            ),
            Expanded(
              child: Column(
                children:  [
                  Text(
                    '${sportsName} - ${sportsKind}',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '${now.year}.${now.month}.${now.day}(${weekday[now.weekday-1]})',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.normal),
                  ),
                  Text(
                    '세트 수 : ${sportsTimes}회, 평균무게 : ${sportsWeight}kg',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              flex: 5,
            )
          ],
        ),
      ),
       Divider(
        thickness: 2,
        color: Colors.black26,
         endIndent: 25,
         indent: 25,
      ),
    ],
  );
  }

}
