import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sampleproject/Themes/Themes.dart';

class FormsScreen extends StatelessWidget {
  String icon;
  String title;
  String Date;
  String description;
  String queOfNumber;

  FormsScreen({
    required this.icon,
    required this.title,
    required this.description,
    required this.Date,
    required this.queOfNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        // width: 400,

        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                icon == ''
                    ? Image.asset(
                        'images/s1.png',
                        height: MediaQuery.of(context).size.height / 7.45,
                        width: MediaQuery.of(context).size.width / 4,
                      )
                    : CachedNetworkImage(
                        height: MediaQuery.of(context).size.height / 7.42,
                        width: MediaQuery.of(context).size.height / 3.7,
                        fit: BoxFit.cover,
                        imageBuilder: (context, snapshot) {
                          return Container(
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white60,
                                image: DecorationImage(
                                  image: NetworkImage(icon),
                                  fit: BoxFit.cover,
                                )),
                          );
                        },
                        imageUrl: icon,
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
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width / 2,
                      // color: Colors.red,
                      child: Text(
                        '${title}',

                        /// title
                        style: Themes().headLine3.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                      ),
                    ),
                    Text(
                      '${Date}',
                      style: Themes().headLine3.copyWith(
                            fontSize:
                                MediaQuery.of(context).size.width / (25.6),
                            color: Colors.black,
                          ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.2,
                      child: Divider(
                        color: Colors.black54,
                        thickness: 1.2,
                      ),
                    ),
                    Container(
                      // color: Colors.red,
                      width: MediaQuery.of(context).size.width / 2,
                      child: Text(
                        '${description}',
                        style: GoogleFonts.roboto(
                          color: Colors.black, //// Desc
                          fontSize: 17,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Icon(
                  Icons.question_mark_sharp,
                  color: Colors.cyan[800],
                  size: 30,
                ),
                Text(
                  '${queOfNumber} questions',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),

                /// QueNum
              ],
            ),
          ],
        ),
      ),
    );
  }
}
