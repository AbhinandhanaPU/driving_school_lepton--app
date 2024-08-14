import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/mock_test/admin_side/adminside_controller.dart';
import 'package:new_project_app/view/mock_test/user/model/moctest_questionnair.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget({super.key});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  QuizTestAdminSideController quizTestAdminSideController = Get.put(QuizTestAdminSideController());
  late PageController _controller;
  int _questionNumber = 1;
  // int _secondsElapsed = 10;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    // startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: quizTestAdminSideController.getAllQuestionAndSuffleStream(),
        builder: (context, questionSnap) {
          if (quizTestAdminSideController.selectedQuestions.isEmpty ||
              questionSnap.connectionState == ConnectionState.waiting) {
            return Scaffold(body: const LoadingWidget());
          } else {
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 9.0,
                shadowColor: Colors.black45,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,                                                                                                                                                                                                                                                          
                  children: [
                    Text(
                      "Exam",
                      style:
                          TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
                    ),
                    Row(
                      children: [
                        Text(
                            '$_questionNumber/${quizTestAdminSideController.selectedQuestions.length}',
                            style: TextStyle(color: Colors.black)),
                        kWidth20,
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20), color: Colors.yellow),
                          child: Row(
                            children: [
                              Icon(
                                Icons.timer_sharp,
                                color: cblack,
                              ),
                              kWidth10,
                              Text(
                                "30 s",
                                // "${_secondsElapsed} s",
                                style: TextStyle(color: cblack),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                        child: PageView.builder(
                      controller: _controller,
                      itemCount: quizTestAdminSideController.selectedQuestions.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final _question = quizTestAdminSideController.selectedQuestions[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 32,
                            ),
                            Text(
                              'Q. ${_question.question}',
                              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 32,
                            ),
                            _question.imageQuestion == true
                                ? Center(
                                    child: Container(
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(_question.imageID!))),
                                    ),
                                  )
                                : SizedBox(),
                            Expanded(
                                child: StreamBuilder(
                                    stream: server
                                        .collection('DrivingSchoolCollection')
                                        .doc('Hi2qKeAIvhdpLkTDAgOoNN2AS0z2')
                                        .collection('MockTestCollection')
                                        .doc(quizTestAdminSideController
                                            .selectedQuestions[index].docid)
                                        .collection('Options')
                                        .snapshots(),
                                    builder: (context, optionsnapshot) {
                                      if (optionsnapshot.hasData) {
                                        return ListView.separated(
                                            itemBuilder: (context, index) {
                                              return Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    final MockQuestionAnswerModel data =
                                                        MockQuestionAnswerModel(
                                                            dataModel: _question,
                                                            lockoption: true,
                                                            questionNo: index,
                                                            ansIsTrue:
                                                                optionsnapshot.data?.docs[index]
                                                                            ['isCorrect'] ==
                                                                        true
                                                                    ? true
                                                                    : false,
                                                            selectedOption: optionsnapshot
                                                                .data?.docs[index]['options']);

                                                    quizTestAdminSideController.userQuestionAnsList
                                                        .add(data);
                                                  },
                                                  child: Container(
                                                    height: 50,
                                                    padding: EdgeInsets.all(12),
                                                    margin: EdgeInsets.symmetric(vertical: 8),
                                                    decoration: BoxDecoration(
                                                      color: Colors.grey.shade200,
                                                      borderRadius: BorderRadius.circular(5),
                                                      border: Border.all(color: cgrey),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Text(
                                                          '${index + 1}. ${optionsnapshot.data?.docs[index]['options']}',
                                                          style: TextStyle(
                                                              fontSize: 20,
                                                              fontWeight: FontWeight.w500),
                                                        ),
                                                        // getIconForOption(option, question)
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox();
                                            },
                                            itemCount: optionsnapshot.data!.docs.length);
                                      } else {
                                        return LoadingWidget();
                                      }
                                    })),
                          ],
                        );
                      },
                    )),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(222, 134, 240, 88),
                                  borderRadius: BorderRadius.horizontal(left: Radius.circular(50))),
                              child: Row(
                                children: [
                                  Icon(Icons.check, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                              decoration: BoxDecoration(
                                  color: Colors.redAccent.shade100,
                                  borderRadius:
                                      BorderRadius.horizontal(right: Radius.circular(50))),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.close, color: Colors.white),
                                  SizedBox(width: 10),
                                  Text(
                                    '0',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            {
                              if (_questionNumber <
                                  quizTestAdminSideController.selectedQuestions.length) {
                                _controller.nextPage(
                                    duration: Duration(milliseconds: 250),
                                    curve: Curves.easeInExpo);

                                setState(() {
                                  _questionNumber++;
                                });
                              }
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _questionNumber <
                                      quizTestAdminSideController.selectedQuestions.length
                                  ? Colors.yellow
                                  : cred,
                            ),
                            height: 50,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 13),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _questionNumber <
                                            quizTestAdminSideController.selectedQuestions.length
                                        ? 'NEXT QUESTION'
                                        : 'RESULT',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: _questionNumber <
                                              quizTestAdminSideController.selectedQuestions.length
                                          ? cblack
                                          : cWhite,
                                    ),
                                  ),
                                  kWidth10,
                                  Icon(
                                    Icons.navigate_next,
                                    size: 30,
                                    color: _questionNumber <
                                            quizTestAdminSideController.selectedQuestions.length
                                        ? cblack
                                        : cWhite,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // buildElevatedButton(),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
              ),
            );
          }
        });
  }
}
