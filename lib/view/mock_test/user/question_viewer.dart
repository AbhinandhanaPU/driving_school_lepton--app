import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/utils.dart';
import 'package:new_project_app/controller/mock_test/admin_side/adminside_controller.dart';
import 'package:new_project_app/view/mock_test/user/model/moctest_questionnair.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget({super.key});

  final QuizTestAdminSideController quizTestAdminSideController =
      Get.put(QuizTestAdminSideController());
  Widget build(BuildContext context) {
    quizTestAdminSideController.startTimer();
    return StreamBuilder(
        stream: quizTestAdminSideController.getAllQuestionAndSuffleStream(),
        builder: (context, questionSnap) {
          if (quizTestAdminSideController.selectedQuestions.isEmpty ||
              questionSnap.connectionState == ConnectionState.waiting) {
            return const LoadingWidget();
          } else {
            quizTestAdminSideController.optionSelected.value = false;
            quizTestAdminSideController.screenLock.value = true;

            return Obx(() {
              if (quizTestAdminSideController.startTimerValue.value == 0) {
                if (quizTestAdminSideController.initquestionNumber.value <
                    quizTestAdminSideController.selectedQuestions.length) {
                  quizTestAdminSideController.pgcontroller.nextPage(
                      duration: Duration(milliseconds: 250),
                      curve: Curves.easeInExpo);

                  quizTestAdminSideController.initquestionNumber.value++;
                  quizTestAdminSideController.wrongAns.value++;
                  quizTestAdminSideController.optionSelected.value = false;
                  quizTestAdminSideController.screenLock.value = true;
                  showToast(msg: 'No Answer Selected');
                }

                quizTestAdminSideController.stopTimer();
                quizTestAdminSideController.resetTimer();
                quizTestAdminSideController.startTimer();
              }
              // if (quizTestAdminSideController.initquestionNumber.value ==
              //     quizTestAdminSideController.selectedQuestions.length) {
              //   quizTestAdminSideController.startTimer();
              //   Future.delayed(Duration(seconds: 30), () {})
              //       .then((value) async {
              //     quizTestAdminSideController.wrongAns.value++;
              //     showToast(msg: 'No Answer Selected');
              //     quizTestAdminSideController.stopTimer();
              //     quizTestAdminSideController.resetTimer();
              //     quizTestAdminSideController.showResult();
              //   });
              // }

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
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Row(
                        children: [
                          Text(
                              '${quizTestAdminSideController.initquestionNumber.value}/${quizTestAdminSideController.selectedQuestions.length}',
                              style: TextStyle(color: Colors.black)),
                          kWidth20,
                         quizTestAdminSideController
                                          .initquestionNumber.value ==
                                      quizTestAdminSideController
                                          .selectedQuestions.length?SizedBox(): Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.yellow),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.timer_sharp,
                                  color: cblack,
                                ),
                                kWidth10,
                                Text(
                                  "${quizTestAdminSideController.startTimerValue.value}",
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
                        controller: quizTestAdminSideController.pgcontroller,
                        itemCount: quizTestAdminSideController
                            .selectedQuestions.length,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final _question = quizTestAdminSideController
                              .selectedQuestions[index];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 32,
                              ),
                              Text(
                                'Q. ${_question.question}',
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
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
                                                image: NetworkImage(
                                                    _question.imageID!))),
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
                                                final data = optionsnapshot
                                                    .data!.docs[index];
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                      onTap: () async {
                                                    quizTestAdminSideController
                                                        .stopTimer();
                                                    quizTestAdminSideController
                                                        .resetTimer();
                                                    if (quizTestAdminSideController
                                                            .screenLock.value ==
                                                        true) {
                                                      quizTestAdminSideController
                                                          .screenLock
                                                          .value = false;
                                                      optionsnapshot.data?.docs[
                                                                      index][
                                                                  'isCorrect'] ==
                                                              true
                                                          ? quizTestAdminSideController
                                                              .correctAns
                                                              .value++
                                                          : quizTestAdminSideController
                                                              .wrongAns.value++;
                                                      optionsnapshot.data?.docs[
                                                                      index][
                                                                  'isCorrect'] ==
                                                              true
                                                          ? showToast(
                                                              msg:
                                                                  "Correct Answer")
                                                          : showToast(
                                                              msg:
                                                                  "Wrong Answer");
                                                      quizTestAdminSideController
                                                              .selectedOptIndex =
                                                          index;
                                                      quizTestAdminSideController
                                                          .optionSelected
                                                          .value = true;
                                                      final MockQuestionAnswerModel
                                                          data =
                                                          MockQuestionAnswerModel(
                                                              dataModel:
                                                                  _question,
                                                              lockoption: true,
                                                              questionNo: index,
                                                              ansIsTrue: optionsnapshot
                                                                              .data
                                                                              ?.docs[index]
                                                                          [
                                                                          'isCorrect'] ==
                                                                      true
                                                                  ? true
                                                                  : false,
                                                              selectedOption:
                                                                  optionsnapshot
                                                                          .data
                                                                          ?.docs[index]
                                                                      [
                                                                      'options']);

                                                      quizTestAdminSideController
                                                          .userQuestionAnsList
                                                          .add(data);
                                                      optionsnapshot.data?.docs[
                                                                      index][
                                                                  'isCorrect'] ==
                                                              true
                                                          ? quizTestAdminSideController
                                                                  .correctAns
                                                                  .value +
                                                              1
                                                          : quizTestAdminSideController
                                                                  .wrongAns
                                                                  .value +
                                                              1;
                                                    }
                                                  }, child: LayoutBuilder(
                                                    builder:
                                                        (context, constraints) {
                                                      final text =
                                                          '${index + 1}. ${optionsnapshot.data?.docs[index]['options']}';
                                                      final textSpan = TextSpan(
                                                        text: text,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w500),
                                                      );
                                                      final textPainter =
                                                          TextPainter(
                                                        text: textSpan,
                                                        maxLines: 1,
                                                        textDirection:
                                                            TextDirection.ltr,
                                                      );
                                                      textPainter.layout(
                                                          maxWidth: constraints
                                                                  .maxWidth -
                                                              24); // Considering padding
                                                      final isOverflowing =
                                                          textPainter
                                                              .didExceedMaxLines;

                                                      return Container(
                                                        padding:
                                                            EdgeInsets.all(12),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                vertical: 8),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: quizTestAdminSideController
                                                                      .optionSelected
                                                                      .value ==
                                                                  true
                                                              ? data['isCorrect'] ==
                                                                      true
                                                                  ? Colors.green
                                                                      .shade300
                                                                  : Colors.red
                                                                      .shade300
                                                              : Colors.grey
                                                                  .shade300,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          border: Border.all(
                                                              color: cgrey),
                                                        ),
                                                        height: isOverflowing
                                                            ? null
                                                            : 50, // Increase height if overflowing
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Expanded(
                                                              child: Text(
                                                                text,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        20,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                  )),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox();
                                              },
                                              itemCount: optionsnapshot
                                                  .data!.docs.length);
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
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(222, 134, 240, 88),
                                    borderRadius: BorderRadius.horizontal(
                                        left: Radius.circular(50))),
                                child: Row(
                                  children: [
                                    Icon(Icons.check, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      quizTestAdminSideController
                                          .correctAns.value
                                          .toString(),
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
                                padding: EdgeInsets.only(
                                    left: 10, right: 10, top: 8, bottom: 8),
                                decoration: BoxDecoration(
                                    color: Colors.redAccent.shade100,
                                    borderRadius: BorderRadius.horizontal(
                                        right: Radius.circular(50))),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.close, color: Colors.white),
                                    SizedBox(width: 10),
                                    Text(
                                      quizTestAdminSideController.wrongAns.value
                                          .toString(),
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
                            

                              if (quizTestAdminSideController
                                      .optionSelected.value ==
                                  false) {
                                quizTestAdminSideController.wrongAns.value++;
                              }
                              if (quizTestAdminSideController
                                      .initquestionNumber.value ==
                                  quizTestAdminSideController
                                      .selectedQuestions.length) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  // This will run after the build method is completed
                                  // Example: Showing a dialog after build
                                  quizTestAdminSideController.showResult();
                                });
                                quizTestAdminSideController.stopTimer();
                                quizTestAdminSideController.resetTimer();
                              }
                              if (quizTestAdminSideController
                                      .initquestionNumber.value <
                                  quizTestAdminSideController
                                      .selectedQuestions.length) {
                                quizTestAdminSideController.pgcontroller
                                    .nextPage(
                                        duration: Duration(milliseconds: 250),
                                        curve: Curves.easeInExpo);

                                quizTestAdminSideController
                                    .initquestionNumber.value++;
                                quizTestAdminSideController
                                    .optionSelected.value = false;
                                quizTestAdminSideController.screenLock.value =
                                    true;
                              }

                              quizTestAdminSideController.stopTimer();
                              quizTestAdminSideController.resetTimer();
                              quizTestAdminSideController.startTimer();
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: quizTestAdminSideController
                                            .initquestionNumber.value <
                                        quizTestAdminSideController
                                            .selectedQuestions.length
                                    ? Colors.yellow
                                    : cred,
                              ),
                              height: 50,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 13),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      quizTestAdminSideController
                                                  .initquestionNumber.value <
                                              quizTestAdminSideController
                                                  .selectedQuestions.length
                                          ? 'NEXT QUESTION'
                                          : 'RESULT',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: quizTestAdminSideController
                                                    .initquestionNumber.value <
                                                quizTestAdminSideController
                                                    .selectedQuestions.length
                                            ? cblack
                                            : cWhite,
                                      ),
                                    ),
                                    kWidth10,
                                    Icon(
                                      Icons.navigate_next,
                                      size: 30,
                                      color: quizTestAdminSideController
                                                  .initquestionNumber.value <
                                              quizTestAdminSideController
                                                  .selectedQuestions.length
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
            });
          }
        });
  }
}
