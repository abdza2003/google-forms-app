import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fdottedline_nullsafety/fdottedline__nullsafety.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:sampleproject/Controller/DatabaseApp.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/widget/inputFaild.dart';

class onePageForm extends StatefulWidget {
  TextEditingController formType;
  TextEditingController formTitle;
  TextEditingController formDesc;

  onePageForm({
    required this.formDesc,
    required this.formTitle,
    required this.formType,
  });

  @override
  State<onePageForm> createState() => _onePageFormState();
}

class _onePageFormState extends State<onePageForm> {
  DatabaseApp databaseApp = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            GestureDetector(
              onTap: changeImage,
              child: FDottedLine(
                color: Color.fromARGB(255, 0, 132, 144),
                strokeWidth: 2.0,
                dottedLength: 20.0,
                space: 3.0,
                corner: FDottedLineCorner.all(20),
                child: Container(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width / 2,
                  child: (databaseApp.ListInf['0']![0] as dynamic)['icon'] == ''
                      ? isLoading == false
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.camera,
                                  size: MediaQuery.of(context).size.width / 7,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Add Icon',
                                  style: Themes().headLine3.copyWith(
                                        fontSize:
                                            MediaQuery.of(context).size.width /
                                                (16.6),
                                      ),
                                ),
                              ],
                            )
                          : Stack(
                              alignment: Alignment.center,
                              children: [
                                AnimatedOpacity(
                                  duration: Duration.zero,
                                  opacity: .5,
                                  child: Image.asset(
                                    'images/s1.png',
                                    height: MediaQuery.of(context).size.height /
                                        7.45,
                                    width:
                                        MediaQuery.of(context).size.width / 4,
                                  ),
                                ),
                                CircularProgressIndicator(
                                  color: Colors.cyan[700],
                                ),
                              ],
                            )
                      : CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              (databaseApp.ListInf['0']![0] as dynamic)['icon'],
                          placeholder: (context, url) => Stack(
                            alignment: Alignment.center,
                            children: [
                              AnimatedOpacity(
                                duration: Duration.zero,
                                opacity: .5,
                                child: Image.asset(
                                  'images/s1.png',
                                  height:
                                      MediaQuery.of(context).size.height / 7.45,
                                  width: MediaQuery.of(context).size.width / 4,
                                ),
                              ),
                              CircularProgressIndicator(
                                color: Colors.cyan[700],
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            inputFaild(
              textEditingController: widget.formType,
              title: 'Form Type',
              hintText: 'add form type here .',
            ),
            SizedBox(
              height: 20,
            ),
            inputFaild(
              textEditingController: widget.formTitle,
              title: 'Title',
              hintText: 'add title here .',
              maxLines: 1,
              maxLength: 40,
            ),
            inputFaild(
              textEditingController: widget.formDesc,
              title: 'Short Description',
              hintText: 'add description here .',
              maxLines: 3,
              maxLength: 100,
            ),
          ],
        ),
      ),
    );
  }

  bool isLoading = false;
  changeImage() async {
    final ImagePicker _picker = ImagePicker();
    File? pickedImage;

    final image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 60);
    if (image == null) {
      return;
    }
    setState(() {
      isLoading = true;

      pickedImage = File(image.path);
    });
    Random x = Random();

    final ref = FirebaseStorage.instance
        .ref()
        .child('form_icon')
        .child('${x.nextInt(100)}.jpg');

    ///
    ////
    var urlImage;
    if (pickedImage != null) {
      await ref.putFile(pickedImage!);
      urlImage = await ref.getDownloadURL();
      await ref.putFile(pickedImage!);
    } else {
      urlImage =
          'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
    }
    setState(() {
      (databaseApp.ListInf['0']![0] as dynamic)['icon'] = urlImage;
      print('==========${(databaseApp.ListInf['0']![0] as dynamic)['icon']}');
    });

    setState(() {
      isLoading = false;
    });
  }
}
