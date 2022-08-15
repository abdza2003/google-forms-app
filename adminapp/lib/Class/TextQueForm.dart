// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TextQueForm {
  late String title;
  late String type;
  String option1 = '';
  String option2 = '';
  String option3 = '';
  String option4 = '';

  TextQueForm({
    required this.title,
    required this.type,
  });
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'title': title,
      'type': type,
      'option1': '',
      'option2': '',
      'option3': '',
      'option4': '',
    };
  }

  TextQueForm.fromJson(Map<String, dynamic> item) {
    title:
    item['title'];
    type:
    item['type'];
  }
}
