import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'write_diary.dart';

class DetailDiary extends StatefulWidget {
  const DetailDiary({Key? key}) : super(key: key);

  @override
  _DetailDiaryState createState() => _DetailDiaryState();
}

class _DetailDiaryState extends State<DetailDiary> {
  final isSelected = [false, false, false, false];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('운동 정보'),
        ),
        body: Column(
          children: [
            Row(
              children: [
                topCircle('가슴', 0),
                topCircle('등', 1),
                topCircle('하체', 2),
                topCircle('어깨', 3)
              ],),
            Row(
              children: [
                bottomButton('벤치프레스'),
                bottomButton('딥스'),
                bottomButton('인클라인벤치'),
                bottomButton('푸쉬업')
                ],
              ),
            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: DataTable(
                  columns: <DataColumn>[
                    tableColumn('SET'),
                    tableColumn('무게'),
                    tableColumn('횟수')
                  ],
                  rows: <DataRow>[
                    tableRow(1,80,10),
                    tableRow(2,80,10),
                    tableRow(3,80,10),
                    tableRow(4,80,10),
                    tableRow(5,80,10),
                    tableRow(6,80,10),
                    tableRow(7,80,10),
                    tableRow(8,80,10),
                    tableRow(9,80,10),
                  ],
              ),
            ),
            DataTable(
                columns: <DataColumn>[
                  tableColumn('평균 무게'),
                  tableColumn('총 볼륨수')
                ], 
                rows: <DataRow>[
                  DataRow(cells: <DataCell>[
                    DataCell(Text('무게총합 / 세트수')),
                    DataCell(Text('세트당 무게x횟수 총 합'))
                  ])
                ]),
            ElevatedButton(onPressed: (){
              print(getSelectedIndex());
            }, child: Text('asdasd'))
          ],
        ));
  }

  DataRow tableRow(setNum,weightNum,playNum) {
    return DataRow(cells: <DataCell>[
                  DataCell(Text('SET${setNum}',style: TextStyle(fontSize: 16),)),
                  DataCell(Text('${weightNum} Kg',style: TextStyle(fontSize: 16))),
                  DataCell(Text('${playNum} 회',style: TextStyle(fontSize: 16)))
                ]);
  }

  DataColumn tableColumn(labelText) {
    return DataColumn(
                    label: Text('${labelText}',
                      style: TextStyle(
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                        fontSize: 22
                ),
                ));
  }

  Expanded bottomButton(sportsKind) {
    return Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: TextButton(
            style: TextButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.only(top: 0,bottom: 0)
                ),
            child: Text(
              '${sportsKind}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
               fontSize: 15,
               color: Colors.white),),
            onPressed: null,
      ),
        ));
  }

  Expanded topCircle(String sportsName, int index) {
    return Expanded(
      child: GestureDetector(
        onTap: (){
          setState(() {
            isSelected[index] = !isSelected[index];
            updateSelectState(index);
          });
        },
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
          child: Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected[index] ? Color(0xFF749AB3) : Color(0xFFE0E0E0),
            ),
            child: Center(
              child: Text(
                  "${sportsName}",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 클릭할때 하나만 선택되도록 만들어 주는 함수
  void updateSelectState(int index) {
    for (var i=0; i<4; ++i){
      if(i != index && isSelected[i] == true){
        isSelected[i] = false;
      }
    }
  }

  /// 현재 선택된 Top Circle 운동 부위의 인덱스 반환
  int getSelectedIndex() {
    for (var i=0; i<4; ++i){
      if(isSelected[i] == true){
        return i;
      }
    }
    return 0;
  }
}
