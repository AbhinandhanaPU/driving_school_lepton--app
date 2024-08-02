import 'package:flutter/material.dart';
import 'package:new_project_app/view/mock_test/user/options_widget.dart';

class QuestionWidget extends StatefulWidget {
  QuestionWidget({super.key});

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  late PageController _controller;
   int _questionNumber = 1;
@override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const SizedBox(
            height: 32,
          ),
          Text('Question $_questionNumber/${question.length}'),
          Divider(
            thickness: 1,
            color: Colors.grey,
          ),
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
          buildElevatedButton(),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  ElevatedButton buildElevatedButton() {
    return ElevatedButton(
        onPressed: () {
          if (_questionNumber<question.length) {
            _controller.nextPage(duration: Duration(microseconds: 250), curve: Curves.easeInExpo);

            setState(() {
              _questionNumber++;
            });
          }
        },
        child: Text(_questionNumber < question.length
            ? 'Next Page'
            : 'See the Result'));
  }

  Column buildQuestions(Question question) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 32,
        ),
        Text(
          question.text,
          style: TextStyle(fontSize: 25),
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
