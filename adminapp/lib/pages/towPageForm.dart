import 'package:flutter/material.dart';
import 'package:sampleproject/widget/formInput.dart';
import 'package:sampleproject/widget/inputFaild.dart';
import 'package:sampleproject/widget/myButton.dart';

class towPageForm extends StatefulWidget {
  int queIndex;
  int index;
  towPageForm({
    required this.queIndex,
    required this.index,
  });
  @override
  State<towPageForm> createState() => _towPageFormState();
}

class _towPageFormState extends State<towPageForm> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Stack(
          alignment: Alignment.bottomRight,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                ),
                formInput(
                  title: '#${widget.queIndex} Question',
                  index: widget.index,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
