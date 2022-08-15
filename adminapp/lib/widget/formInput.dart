import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/Themes/Themes.dart';

class formInput extends StatefulWidget {
  int index;
  TextEditingController? textEditingController;
  String title;
  int? maxLength;
  int? maxLines;
  Widget? suffixIcon;
  formInput({
    required this.index,
    required this.title,
    this.maxLength,
    this.maxLines,
    this.textEditingController,
    this.suffixIcon,
  });

  @override
  State<formInput> createState() => _formInputState();
}

class _formInputState extends State<formInput> {
  DatabaseApp s1 = Get.find();
  List<String> queType = ['Short answer', 'Multiple choice', 'Checkboxes'];
  String getQue = 'Short answer';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${widget.title}',
            style: Themes().headLine3.copyWith(
                  fontSize: MediaQuery.of(context).size.width / (16.6),
                ),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            controller: s1.ListInf['${widget.index}']![0]['title']
                as TextEditingController,
            readOnly: widget.suffixIcon == null ? false : true,
            maxLength: widget.maxLength,
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Untitled Question',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 0, 112, 123),
                ),
              ),
              suffixIcon: widget.suffixIcon,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Question Type',
            style: Themes().headLine3.copyWith(
                  fontSize: MediaQuery.of(context).size.width / (16.6),
                ),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: MediaQuery.of(context).size.width / 1.5,
            // alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black54, width: 1),
            ),
            child: DropdownButton(
              iconSize: 30,
              icon: Icon(Icons.arrow_drop_down, color: Colors.black),
              isExpanded: true,
              value: s1.ListInf['${widget.index}']![0]['type'] as String,
              items: queType
                  .map(
                    (val) => DropdownMenuItem(
                      child: Text('${val}'),
                      value: val,
                    ),
                  )
                  .toList(),
              onChanged: (String? val) {
                setState(() {
                  s1.ListInf['${widget.index}'] = [
                    {
                      'icon': '',
                      'title': new TextEditingController(
                          text: (s1.ListInf['${widget.index}']![0]['title']
                                  as TextEditingController)
                              .text),
                      'type': '$val',
                      'optionsIndexCheckboxs': 1,
                      'optionsIndexMultiple': 1,
                      'answers': {
                        'Multiple': {
                          '0': TextEditingController(text: ''),
                          '1': TextEditingController(text: ''),
                          '2': TextEditingController(text: ''),
                          '3': TextEditingController(text: ''),
                        },
                        'Checkboxes': {
                          '0': TextEditingController(text: ''),
                          '1': TextEditingController(text: ''),
                          '2': TextEditingController(text: ''),
                          '3': TextEditingController(text: ''),
                        },
                      }
                    }
                  ];
                  print('==========$val');
                  s1.ListInf['${widget.index}']![0]['type'] = val as String;
                });
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          getAnswerType(),
        ],
      ),
    );
  }

  getAnswerType() {
    if (s1.ListInf['${widget.index}']![0]['type'] == 'Short answer') {
      return Container(
        padding: EdgeInsets.only(left: 10),
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              '#Short answer text',
              style: TextStyle(
                fontSize: 22,
                color: ThemeController().themeApp == ThemeMode.light
                    ? Colors.black.withOpacity(.6)
                    : Colors.white.withOpacity(.6),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.4,
              child: Divider(
                color: Colors.black45,
                thickness: 1.5,
              ),
            ),
          ],
        ),
      );
    } else if (s1.ListInf['${widget.index}']![0]['type'] == 'Multiple choice') {
      return Container(
        padding: EdgeInsets.only(left: 10),
        width: MediaQuery.of(context).size.width / 1.2,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                for (int i = 0;
                    i <
                        (s1.ListInf['${widget.index}']![0]
                            ['optionsIndexMultiple'] as num);
                    i++)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.grey[500],
                        radius: 10,
                        child: CircleAvatar(
                          backgroundColor: Color.fromARGB(255, 223, 226, 228),
                          radius: 6,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          controller: (s1.ListInf['${widget.index}']![0]
                                  ['answers'] as dynamic)['Multiple']['$i']
                              as TextEditingController,
                          readOnly: widget.suffixIcon == null ? false : true,
                          maxLength: widget.maxLength,
                          maxLines: widget.maxLines,
                          decoration: InputDecoration(
                            hintText: 'Option ${i + 1}',
                            suffixIcon: widget.suffixIcon,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height / 15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if ((s1.ListInf['${widget.index}']![0]['optionsIndexMultiple']
                          as num) <
                      4)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          s1.ListInf['${widget.index}']![0]
                                  ['optionsIndexMultiple'] =
                              (s1.ListInf['${widget.index}']![0]
                                      ['optionsIndexMultiple'] as num) +
                                  1;
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                  SizedBox(
                    width: 5,
                  ),
                  if ((s1.ListInf['${widget.index}']![0]['optionsIndexMultiple']
                          as num) >
                      1)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          (s1.ListInf['${widget.index}']![0]['answers']
                                      as dynamic)['Multiple'][
                                  '${(s1.ListInf['${widget.index}']![0]['optionsIndexMultiple'] as num) - 1}'] =
                              TextEditingController(text: '');
                          s1.ListInf['${widget.index}']![0]
                                  ['optionsIndexMultiple'] =
                              (s1.ListInf['${widget.index}']![0]
                                      ['optionsIndexMultiple'] as num) -
                                  1;
                        });
                      },
                      child: Icon(Icons.delete),
                    ),
                ],
              ),
            )
          ],
        ),
      );
    } else {
      return Container(
        padding: EdgeInsets.only(left: 10),
        width: MediaQuery.of(context).size.width / 1.2,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                for (int i = 0;
                    i <
                        (s1.ListInf['${widget.index}']![0]
                            ['optionsIndexCheckboxs'] as num);
                    i++)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_box,
                        color: Colors.grey,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextField(
                          controller: (s1.ListInf['${widget.index}']![0]
                                  ['answers'] as dynamic)['Checkboxes']['$i']
                              as TextEditingController,
                          readOnly: widget.suffixIcon == null ? false : true,
                          maxLength: widget.maxLength,
                          maxLines: widget.maxLines,
                          decoration: InputDecoration(
                            hintText: 'Option ${i + 1}',
                            suffixIcon: widget.suffixIcon,
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            Container(
              // color: Colors.red,
              height: MediaQuery.of(context).size.height / 15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if ((s1.ListInf['${widget.index}']![0]
                          ['optionsIndexCheckboxs'] as num) <
                      4)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          s1.ListInf['${widget.index}']![0]
                                  ['optionsIndexCheckboxs'] =
                              (s1.ListInf['${widget.index}']![0]
                                      ['optionsIndexCheckboxs'] as num) +
                                  1;
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                  SizedBox(
                    width: 5,
                  ),
                  if ((s1.ListInf['${widget.index}']![0]
                          ['optionsIndexCheckboxs'] as num) >
                      1)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          (s1.ListInf['${widget.index}']![0]['answers']
                                      as dynamic)['Checkboxes'][
                                  '${(s1.ListInf['${widget.index}']![0]['optionsIndexCheckboxs'] as num) - 1}'] =
                              TextEditingController(text: '');
                          s1.ListInf['${widget.index}']![0]
                                  ['optionsIndexCheckboxs'] =
                              (s1.ListInf['${widget.index}']![0]
                                      ['optionsIndexCheckboxs'] as num) -
                                  1;
                        });
                      },
                      child: Icon(Icons.delete),
                    ),
                ],
              ),
            )
          ],
        ),
      );
    }
  }

  getSnackBar(String title) {
    Get.snackbar(
      'wrong entry',
      '$title',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.cyan[800],
      colorText: Colors.white,
      icon: Icon(Icons.error),
      margin: EdgeInsets.all(15),
    );
  }
}
