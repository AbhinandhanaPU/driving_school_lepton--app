import 'dart:async';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';
import 'package:new_project_app/view/mock_test/user/options_widget.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget({super.key});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late PageController _controller;
  int _questionNumber = 1;
  int _secondsElapsed = 10;
  Timer? _timer;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    startTimer();
    super.initState();
  }

  void startTimer() {
    // Cancel any existing timer before starting a new one
    _timer?.cancel();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _secondsElapsed--;
        print('Seconds elapsed: $_secondsElapsed');
        // if (_secondsElapsed == 0) {
        //   if (_questionNumber < question.length) {
        //     _controller.nextPage(duration: Duration(milliseconds: 250), curve: Curves.easeInExpo);
        //     _questionNumber++;
        //     _secondsElapsed = 10; // Reset the timer for the next question
        //   } else {
        //     _timer!.cancel(); // Stop the timer after the last question
        //     customShowDilogBox(
        //       context: context,
        //       title: 'Result',
        //       children: [Text('check your score')],
        //       doyouwantActionButton: true,
        //       actiontext: "view",
        //       actiononTapfuction: () {},
        //     );
        //   }
        // }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 30),
            ),
            Row(
              children: [
                Text('$_questionNumber/${question.length}', style: TextStyle(color: Colors.black)),
                kWidth20,
                Container(
                  padding: EdgeInsets.all(10),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.yellow),
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
              itemCount: question.length,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final _question = question[index];
                return buildQuestions(_question);
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
                          borderRadius: BorderRadius.horizontal(right: Radius.circular(50))),
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
                      if (_questionNumber < question.length) {
                        _controller.nextPage(
                            duration: Duration(milliseconds: 250), curve: Curves.easeInExpo);

                        setState(() {
                          _questionNumber++;
                          _secondsElapsed = 10;
                          startTimer();
                        });
                      }
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: _questionNumber < question.length ? Colors.yellow : cred,
                    ),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 13),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _questionNumber < question.length ? 'NEXT QUESTION' : 'RESULT',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _questionNumber < question.length ? cblack : cWhite,
                            ),
                          ),
                          kWidth10,
                          Icon(
                            Icons.navigate_next,
                            size: 30,
                            color: _questionNumber < question.length ? cblack : cWhite,
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

  Column buildQuestions(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 32,
        ),
        Text(
          'Q. ${question.text}',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 32,
        ),
        Expanded(
            child: Optionswidget(
          question: question,
          onclickOption: (option) {
            if (question.isLocked) {
              return;
            } else {
              setState(() {});
              question.isLocked = true;
              question.selectedOption = option;
            }
          },
        ))
      ],
    );
  }
}
