// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:new_project_app/constant/colors/colors.dart';
// import 'package:new_project_app/constant/sizes/sizes.dart';
// import 'package:new_project_app/constant/utils/firebase/firebase.dart';
// import 'package:new_project_app/constant/utils/utils.dart';
// import 'package:new_project_app/controller/mock_test/admin_side/adminside_controller.dart';
// import 'package:new_project_app/view/mock_test/user/model/moctest_questionnair.dart';
// import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
// import 'package:http/http.dart' as http;

// class TranslationService {
//   final String apiKey = 'AIzaSyCJ9d-ofeEZQ-RzEQbrux-U-8ve_uh4fWE'; // Replace with your API key
//   final String endpoint = 'https://translation.googleapis.com/language/translate/v2';

//   Future<String> translateText(String text, String targetLanguage) async {
//     final response = await http.post(
//       Uri.parse(endpoint),
//       headers: {
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'q': text,
//         'target': targetLanguage,
//         'format': 'text',
//         'key': apiKey,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['data']['translations'][0]['translatedText'];
//     } else {
//       throw Exception('Failed to translate text: ${response.body}');
//     }
//   }
// }

// class QuestionWidget extends StatelessWidget {
//   QuestionWidget({super.key});

//   final QuizTestAdminSideController quizTestAdminSideController = Get.put(QuizTestAdminSideController());
//   final TranslationService translationService = TranslationService();

//   @override
//   Widget build(BuildContext context) {
//     quizTestAdminSideController.startTimer();
//     return StreamBuilder(
//         stream: quizTestAdminSideController.getAllQuestionAndSuffleStream(),
//         builder: (context, questionSnap) {
//           if (quizTestAdminSideController.selectedQuestions.isEmpty ||
//               questionSnap.connectionState == ConnectionState.waiting) {
//             return const LoadingWidget();
//           } else {
//             quizTestAdminSideController.optionSelected.value = false;
//             quizTestAdminSideController.screenLock.value = true;

//             return Obx(() {
//               if (quizTestAdminSideController.startTimerValue.value == 0) {
//                 if (quizTestAdminSideController.initquestionNumber.value <
//                     quizTestAdminSideController.selectedQuestions.length) {
//                   quizTestAdminSideController.pgcontroller.nextPage(
//                       duration: Duration(milliseconds: 250),
//                       curve: Curves.easeInExpo);

//                   quizTestAdminSideController.initquestionNumber.value++;
//                   quizTestAdminSideController.wrongAns.value++;
//                   quizTestAdminSideController.optionSelected.value = false;
//                   quizTestAdminSideController.screenLock.value = true;
//                   showToast(msg: 'No Answer Selected');
//                 }

//                 quizTestAdminSideController.stopTimer();
//                 quizTestAdminSideController.resetTimer();
//                 quizTestAdminSideController.startTimer();
//               }

//               return Scaffold(
//                 appBar: AppBar(
//                   backgroundColor: Colors.white,
//                   elevation: 9.0,
//                   shadowColor: Colors.black45,
//                   title: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         "Exam",
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 30),
//                       ),
//                       Row(
//                         children: [
//                           Text(
//                               '${quizTestAdminSideController.initquestionNumber.value}/${quizTestAdminSideController.selectedQuestions.length}',
//                               style: TextStyle(color: Colors.black)),
//                           kWidth20,
//                           quizTestAdminSideController.initquestionNumber.value ==
//                                   quizTestAdminSideController.selectedQuestions.length
//                               ? SizedBox()
//                               : Container(
//                                   padding: EdgeInsets.all(10),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(20),
//                                       color: Colors.yellow),
//                                   child: Row(
//                                     children: [
//                                       Icon(
//                                         Icons.timer_sharp,
//                                         color: cblack,
//                                       ),
//                                       kWidth10,
//                                       Text(
//                                         "${quizTestAdminSideController.startTimerValue.value}",
//                                         style: TextStyle(color: cblack),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//                 body: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       Expanded(
//                           child: PageView.builder(
//                         controller: quizTestAdminSideController.pgcontroller,
//                         itemCount: quizTestAdminSideController.selectedQuestions.length,
//                         physics: NeverScrollableScrollPhysics(),
//                         itemBuilder: (context, index) {
//                           final _question = quizTestAdminSideController.selectedQuestions[index];
//                           return FutureBuilder(
//                             future: _translateQuestionAndOptions(_question, index),
//                             builder: (context, snapshot) {
//                               if (!snapshot.hasData) {
//                                 return LoadingWidget();
//                               }

//                               final translatedData = snapshot.data as Map<String, dynamic>;
//                               final translatedQuestion = translatedData['question'] as String;
//                               final translatedOptions = translatedData['options'] as List<String>;

//                               return Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(height: 32),
//                                   Text(
//                                     'Q. $translatedQuestion',
//                                     style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
//                                   ),
//                                   SizedBox(height: 32),
//                                   _question.imageQuestion == true
//                                       ? Center(
//                                           child: Container(
//                                             height: 150,
//                                             width: 150,
//                                             decoration: BoxDecoration(
//                                                 image: DecorationImage(
//                                                     image: NetworkImage(_question.imageID!))),
//                                           ),
//                                         )
//                                       : SizedBox(),
//                                   Expanded(
//                                       child: ListView.separated(
//                                           itemBuilder: (context, index) {
//                                             final optionText = translatedOptions[index];
//                                             return Padding(
//                                               padding: const EdgeInsets.all(8.0),
//                                               child: GestureDetector(
//                                                 onTap: () {
//                                                   quizTestAdminSideController.stopTimer();
//                                                   quizTestAdminSideController.resetTimer();
//                                                   _handleOptionTap(optionsnapshot.data!.docs[index], index);
//                                                 },
//                                                 child: Container(
//                                                   padding: EdgeInsets.all(12),
//                                                   margin: EdgeInsets.symmetric(vertical: 8),
//                                                   decoration: BoxDecoration(
//                                                     color: quizTestAdminSideController.optionSelected.value ==
//                                                             true
//                                                         ? data['isCorrect'] == true
//                                                             ? Colors.green.shade300
//                                                             : Colors.red.shade300
//                                                         : Colors.grey.shade300,
//                                                     borderRadius: BorderRadius.circular(5),
//                                                     border: Border.all(color: cgrey),
//                                                   ),
//                                                   child: Text(
//                                                     optionText,
//                                                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
//                                                   ),
//                                                 ),
//                                               ),
//                                             );
//                                           },
//                                           separatorBuilder: (context, index) => SizedBox(),
//                                           itemCount: translatedOptions.length)),
//                                 ],
//                               );
//                             },
//                           );
//                         },
//                       )),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Container(
//                                 padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
//                                 decoration: BoxDecoration(
//                                     color: Color.fromARGB(222, 134, 240, 88),
//                                     borderRadius: BorderRadius.horizontal(left: Radius.circular(50))),
//                                 child: Row(
//                                   children: [
//                                     Icon(Icons.check, color: Colors.white),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       quizTestAdminSideController.correctAns.value.toString(),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w800,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Container(
//                                 padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
//                                 decoration: BoxDecoration(
//                                     color: Colors.redAccent.shade100,
//                                     borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Icon(Icons.close, color: Colors.white),
//                                     SizedBox(width: 10),
//                                     Text(
//                                       quizTestAdminSideController.wrongAns.value.toString(),
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 20,
//                                         fontWeight: FontWeight.w800,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           GestureDetector(
//                             onTap: () {
//                               if (quizTestAdminSideController.optionSelected.value == false) {
//                                 quizTestAdminSideController.wrongAns.value++;
//                               }
//                               if (quizTestAdminSideController.initquestionNumber.value ==
//                                   quizTestAdminSideController.selectedQuestions.length) {
//                                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                                   quizTestAdminSideController.showResult();
//                                 });
//                                 quizTestAdminSideController.stopTimer();
//                                 quizTestAdminSideController.resetTimer();
//                                 quizTestAdminSideController.initquestionNumber.value = 0;
//                               } else {
//                                 quizTestAdminSideController.pgcontroller.nextPage(
//                                     duration: Duration(milliseconds: 250), curve: Curves.easeInExpo);
//                                 quizTestAdminSideController.initquestionNumber.value++;
//                                 quizTestAdminSideController.screenLock.value = true;
//                                 quizTestAdminSideController.stopTimer();
//                                 quizTestAdminSideController.resetTimer();
//                                 quizTestAdminSideController.startTimer();
//                               }
//                             },
//                             child: Container(
//                               padding: EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: Colors.blueAccent,
//                               ),
//                               child: Text(
//                                 "Next",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             });
//           }
//         });
//   }

//   Future<Map<String, dynamic>> _translateQuestionAndOptions(
//       MocktestQuestionnair question, int index) async {
//     final translatedQuestion = await translationService.translateText(question.question.toString(), 'ml');
//     final translatedOptions = await Future.wait(question.options!.map((option) {
//       return translationService.translateText(option, 'ml');
//     }).toList());

//     return {
//       'question': translatedQuestion,
//       'options': translatedOptions,
//     };
//   }

//   void _handleOptionTap(DocumentSnapshot data, int index) {
//     quizTestAdminSideController.optionSelected.value = true;
//     quizTestAdminSideController.screenLock.value = false;

//     if (data['isCorrect'] == true) {
//       quizTestAdminSideController.correctAns.value++;
//     } else {
//       quizTestAdminSideController.wrongAns.value++;
//     }

//     showToast(msg: data['isCorrect'] == true ? 'Correct Answer' : 'Wrong Answer');
//   }
// }
