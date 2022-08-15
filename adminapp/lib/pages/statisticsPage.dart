import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sampleproject/Controller/FirebaseServise.dart';
import 'package:sampleproject/Themes/ThemeController.dart';
import 'package:sampleproject/Themes/Themes.dart';
import 'package:sampleproject/widget/FormsScreen.dart';
import 'package:sampleproject/widget/Skelton.dart';
import 'package:sampleproject/widget/myButton.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class statisticsPage extends StatefulWidget {
  String formId;
  statisticsPage({required this.formId});
  @override
  State<statisticsPage> createState() => _statisticsPageState();
}

class _statisticsPageState extends State<statisticsPage> {
  FirebaseServise a1 = Get.find();
  @override
  void initState() {
    a1.statisticsMultipleData = [];
    a1.statisticsCheckboxesData = [];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Analysis Page'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('/formDesc/Questions/${widget.formId}')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Skeleton(
                          height: MediaQuery.of(context).size.height / 3,
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: C,
                          children: [
                            Skeleton(
                              height: MediaQuery.of(context).size.height / 15,
                              width: MediaQuery.of(context).size.width / 2.2,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Skeleton(
                              height: MediaQuery.of(context).size.height / 7,
                              width: MediaQuery.of(context).size.width / 2.2,
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                }
                List<DocumentSnapshot> s1 = snapshot.data!.docs;

                return Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              child: Text(
                                'Questions',
                                style: Themes().headLine3.copyWith(
                                      fontSize: 20,
                                      color: Colors.black,
                                    ),
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1.43,
                                child: Divider(
                                  color: Colors.black54,
                                  thickness: 1.2,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ...List.generate(
                              s1.length,
                              (index) => getQue(
                                context: context,
                                queIndex: index,
                                queTitle: s1[index]['title'],
                                queType: s1[index]['type'],
                                option1: s1[index]['option1'],
                                option2: s1[index]['option2'],
                                option3: s1[index]['option3'],
                                option4: s1[index]['option4'],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  getQue({
    required BuildContext context,
    required int queIndex,
    required String queTitle,
    required String queType,
    var option1,
    var option2,
    var option3,
    var option4,
  }) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 179, 214, 206),
      ),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '#${queIndex + 1}Question',
              style: Themes().headLine3.copyWith(
                    fontSize: 20,
                    color: Colors.black,
                  ),
            ),
            Text(
              '${queType}',
              style: Themes().headLine1.copyWith(fontSize: 18),
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              // color: Colors.red,
              child: Text(
                '${queTitle}',
                style: Themes().headLine4.copyWith(
                      fontSize: 20,
                      color: Colors.black,
                    ),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0.0,
                      backgroundColor: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: ThemeController().themeApp == ThemeMode.dark
                              ? Color.fromARGB(255, 53, 52, 52)
                              : Colors.white,
                        ),
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            queType == 'Short answer'
                                ? textAnswerStatis(
                                    queTitle: queTitle,
                                  )
                                : queType == 'Multiple choice'
                                    ? chartMultipleQue(
                                        queTitle: queTitle,
                                        option1: option1,
                                        option2: option2,
                                        option3: option3,
                                        option4: option4,
                                      )
                                    : chartCheckboxesQue(
                                        queTitle: queTitle,
                                        option1: option1,
                                        option2: option2,
                                        option3: option3,
                                        option4: option4,
                                      ),
                            myButton(
                              title: 'close',
                              myfunc: () {
                                Get.back();
                              },
                              height: MediaQuery.of(context).size.height / 15.5,
                              width: MediaQuery.of(context).size.width / 4,
                              padding: 10,
                            ),
                          ],
                        ),
                      )),
                );
              },
              child: Text(
                'Details ...',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  chartMultipleQue({
    required String queTitle,
    required String option1,
    required String option2,
    required String option3,
    required String option4,
  }) {
    return FutureBuilder(
        future:
            a1.getMultiAnswerQue(title: queTitle, formId: '${widget.formId}'),
        builder: (context, snapshot) {
          return Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Answers',
                      style: Themes().headLine3.copyWith(
                            fontSize: 20,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Divider(
                      color: Colors.black45,
                      thickness: 1.2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.check_box),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          // color: Colors.red,
                          child: Text(
                            '$queTitle',
                            style: Themes().headLine4.copyWith(
                                  fontSize: 20,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  /////
                  Container(
                    child: SfCircularChart(
                      // title: ChartTitle(text: 'This is chart title'),
                      legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                      ),
                      series: [
                        PieSeries<StatisticsMultipleData, String>(
                          dataSource: a1.statisticsMultipleData,
                          xValueMapper: (StatisticsMultipleData data, _) =>
                              data.que,
                          yValueMapper: (StatisticsMultipleData data, _) =>
                              data.numberOfAnswer,
                          dataLabelSettings: DataLabelSettings(
                            isVisible: true,
                          ),
                          enableTooltip: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  chartCheckboxesQue({
    required String queTitle,
    required String option1,
    required String option2,
    required String option3,
    required String option4,
  }) {
    return FutureBuilder(
        future: a1.getCheckboxesAnswerQue(
          title: '${queTitle}',
          formId: '${widget.formId}',
        ),
        builder: (context, snapshot) {
          return Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            padding: EdgeInsets.only(top: 20, left: 20, right: 20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Answers',
                      style: Themes().headLine3.copyWith(
                            fontSize: 20,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Divider(
                      color: Colors.black45,
                      thickness: 1.2,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.check_box),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          // color: Colors.red,
                          child: Text(
                            '$queTitle',
                            style: Themes().headLine4.copyWith(
                                  fontSize: 20,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: SfCartesianChart(
                      primaryXAxis: CategoryAxis(),
                      // title: ChartTitle(text: 'This is chart title'),
                      legend: Legend(
                        isVisible: true,
                        overflowMode: LegendItemOverflowMode.wrap,
                      ),
                      series: [
                        StackedColumnSeries(
                          dataSource: a1.statisticsCheckboxesData,
                          xValueMapper: (StatisticsCheckboxesData data, _) =>
                              data.que,
                          yValueMapper: (StatisticsCheckboxesData data, _) =>
                              data.numberOfAnswer,

                          // dataLabelSettings: DataLabelSettings(
                          //   isVisible: true,
                          // ),
                          // enableTooltip: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  textAnswerStatis({required String queTitle}) {
    return FutureBuilder(
        future: a1.getTextAnswerQue(
          title: '$queTitle',
          formId: '${widget.formId}',
        ),
        builder: (context, snapshot) {
          if (a1.getAnswrQue.isEmpty) {
            return Container(
              alignment: Alignment.topCenter,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Answers',
                        style: Themes().headLine3.copyWith(
                              fontSize: 20,
                            ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 1.6,
                      child: Divider(
                        color: Colors.black45,
                        thickness: 1.2,
                      ),
                    ),
                    AnimationConfiguration.staggeredGrid(
                      columnCount: 0,
                      position: 0,
                      child: ScaleAnimation(
                        duration: Duration(milliseconds: 1500),
                        child: FadeInAnimation(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100),
                            child: RefreshIndicator(
                              onRefresh: () async {
                                /*   await FirebaseFirestore.instance
                                    .collection('/newAccount/${idKey}/note')
                                    .snapshots(); */
                              },
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SvgPicture.asset(
                                      'images/266c29a5d874af62d87413456e07d700.svg',
                                      height:
                                          MediaQuery.of(context).size.height /
                                              (6.2),
                                      width: MediaQuery.of(context).size.width /
                                          (6.2),
                                      color: Colors.cyan[700],
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, 20),
                                      child: Container(
                                        // color: Colors.red,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                (1.4),
                                        child: Text(
                                          'No answers have been added yet ..!!',
                                          style: Themes().headLine3.copyWith(
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    (22.6),
                                                color: ThemeController()
                                                            .themeApp ==
                                                        ThemeMode.light
                                                    ? Colors.black
                                                        .withOpacity(.6)
                                                    : Colors.white
                                                        .withOpacity(.6),
                                              ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container(
            alignment: Alignment.topCenter,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Answers',
                      style: Themes().headLine3.copyWith(
                            fontSize: 20,
                          ),
                    ),
                  ),
                  SizedBox(
                    width: 300,
                    child: Divider(
                      color: Colors.black45,
                      thickness: 1.2,
                    ),
                  ),
                  ...List.generate(
                    a1.getAnswrQue.length,
                    (index) => Column(
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundColor: Colors.cyan[800],
                              child: Text(
                                '#${index + 1}',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                width: double.infinity,
                                // color: Colors.cyan[100],
                                child: Text(
                                  '${a1.getAnswrQue[index]}',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 300,
                          child: Divider(
                            color: Colors.black54,
                            thickness: 1.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
