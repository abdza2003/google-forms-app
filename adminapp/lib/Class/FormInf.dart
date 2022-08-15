// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class FormInf {
  late String formTitle;
  late String formDecs;
  late String formType;
  late String formIcon;
  late String formDate;
  late String formQueOfNumber;
  FormInf({
    required this.formDecs,
    required this.formTitle,
    required this.formType,
    required this.formIcon,
    required this.formDate,
    required this.formQueOfNumber,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'formTitle': formTitle,
      'formDecs': formDecs,
      'formType': formType,
      'formIcon': formIcon,
      'formDate': formDate,
      'formQueOfNumber': formQueOfNumber,
    };
  }

  FormInf.fromJson(Map<String, dynamic> item) {
    formTitle:
    item['formTitle'];
    formDecs:
    item['formDecs'];
    formType:
    item['formType'];
    formIcon:
    item['formIcon'];
    formDate:
    item['formDate'];
    formQueOfNumber:
    item['formQueOfNumber'];
  }
}
