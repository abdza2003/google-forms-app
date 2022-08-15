// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class MultipleQueForm {
  late String title;
  late String type;
  late String option1;
  late String option2;
  late String option3;
  late String option4;
  MultipleQueForm({
    required this.title,
    required this.type,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'option1': option1,
      'option2': option2,
      'option3': option3,
      'option4': option4,
    };
  }

  MultipleQueForm.fromMap(Map<String, dynamic> json) {
    title:
    json['title'] as String;
    type:
    json['type'] as String;
    option2:
    json['option2'] as String;
    option1:
    json['option1'] as String;
    option3:
    json['option3'] as String;
    option4:
    json['option4'] as String;
  }
}
