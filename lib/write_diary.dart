import 'dart:ffi';
import 'main.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyDiary extends StatefulWidget {
  MyDiary({Key? key}) : super(key: key);

  final valueList = ['가슴', '등', '하체', '어깨'];
  String dropdownValue = "가슴";

  @override
  _MyDiaryState createState() => _MyDiaryState();
}

class _MyDiaryState extends State<MyDiary> {
  late GlobalKey<FormState> _formKey1;
  late GlobalKey<FormState> _formKey2;
  late GlobalKey<FormState> _formKey3;
  late TextEditingController sportsNameController;
  late TextEditingController weightNameController;
  late TextEditingController countNameController;

  @override
  void initState() {
    super.initState();
    _formKey1 = GlobalKey<FormState>();
    _formKey2 = GlobalKey<FormState>();
    _formKey3 = GlobalKey<FormState>();
    sportsNameController = TextEditingController();
    weightNameController = TextEditingController();
    countNameController = TextEditingController();
  }

  @override
  void dispose() {
    sportsNameController.dispose();
    weightNameController.dispose();
    countNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Write Diary"),
      ),
      body: Column(
        children: [
          diaryDropButton("운동 부위 :"),
          diaryTextBox(
              '운동 이름 :',
              null,
              TextInputType.text,
              sportsNameController,
              _formKey1
          ),
          diaryTextBox(
              '무게 :',
              'Kg',
              TextInputType.number,
              weightNameController,
              _formKey2
          ),
          diaryTextBox(
              '횟수 :',
              '회',
              TextInputType.number,
              countNameController,
              _formKey3
          ),
          ElevatedButton(
            onPressed: () {
              // String sportsName = sportsNameController.text;
              // int? weightName;
              // if (weightNameController.text.isNotEmpty){
              //   weightName = int.parse(weightNameController.text);
              // }
              // int? countName;
              // if (countNameController.text.isNotEmpty){
              //   countName = int.parse(countNameController.text);
              // }
              //
              // if (sportsName.isNotEmpty){
              //   Navigator.pop(context, [widget.dropdownValue, sportsName, weightName, countName]);
              // }
              // else {
              //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              //     content: Text('똑바로 적어라 시키야'),
              //   ));
              // }

              _formKey1.currentState!.validate();
              _formKey2.currentState!.validate();
              _formKey3.currentState!.validate();

              String sportsName = sportsNameController.text;
              int weightName = int.parse(weightNameController.text);
              int countName = int.parse(countNameController.text);

              Navigator.pop(context, [widget.dropdownValue, sportsName, weightName, countName]);

            },
            child: Text('추가'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, '닫기');
            },
            child: Text('닫기'),
          ),
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
    );
  }

  Container diaryDropButton(String buttonName) {
    return Container(
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
              child: Text(
                '${buttonName}',
                textAlign: TextAlign.end,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            flex: 3,
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 130, 0),
              child: DropdownButton(
                value: widget.dropdownValue,
                items: widget.valueList.map((element) {
                  return buildDropdownMenuItem(element);
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    widget.dropdownValue = value.toString();
                  });
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  Container diaryTextBox(
      String buttonName, String? unit, TextInputType? type, controller, formKey) {
    return Container(
      height: 100,
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 30, 0),
            child: Text(
              '${buttonName}',
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          flex: 3,
        ),
        Expanded(
          flex: 5,
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 130, 0),
                  child: TextFormField(
                    validator: (value) {
                      if(value == null || value.isEmpty){
                        return '필수 작성!';
                      }
                      return null;
                    },
                    controller: controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '내용을 입력해주세요',
                        suffixText: unit),
                    keyboardType: type,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  DropdownMenuItem<String> buildDropdownMenuItem(String value) {
    return DropdownMenuItem(
      child: Container(
          width: 100,
          child: Text(
            value,
            textAlign: TextAlign.end,
          )),
      value: value,
    );
  }
}



