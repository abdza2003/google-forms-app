import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DatabaseApp extends GetxController {
  var ListInf = {
    for (int i = 0; i < 20; i++)
      '$i': [
        {
          'icon': '',
          'title': TextEditingController(text: ''),
          'type': 'Short answer',
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
      ],
  };

  var answerInf = {
    for (int i = 0; i < 100; i++)
      '$i': [
        {
          'textAnswer': TextEditingController(text: ''),
          'radioButton': 0,
          'Multiple': '',
          'isClick': [false, false, false, false],
          'Checkboxes': {
            '0': '',
            '1': '',
            '2': '',
            '3': '',
          },
        }
      ],
  };
}
