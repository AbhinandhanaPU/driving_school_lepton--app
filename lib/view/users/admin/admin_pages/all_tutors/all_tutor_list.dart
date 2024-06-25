import 'package:flutter/material.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class AllTutorList extends StatelessWidget {
  final int index;
  // final TeacherModel data;
  const AllTutorList({
    required this.index,
    // required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: index % 2 == 0 ? const Color.fromARGB(255, 246, 246, 246) : Colors.blue[50],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Row(
              children: [
                // SizedBox(
                //   width: 20,
                //   child: Center(
                //     child: Image.asset(
                //       'webassets/stickers/icons8-student-100 (1).png',
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Center(
                    child: TextFontWidget(
                      text: "Ramu",
                      fontsize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ), //........................................... teacher Name
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                    child: Center(
                  child: TextFontWidget(
                    text: "20-04-2023",
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
              ],
            ),
          ), // ................................... teacher Email
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                // SizedBox(
                //   width: 15,
                //   child: Center(
                //     child: Image.asset(
                //       'webassets/png/telephone.png',
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Center(
                    child: TextFontWidget(
                      text: "3",
                      fontsize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ), //....................................... teacher Phone Number
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 6,
            child: Row(
              children: [
                Expanded(
                    child: Center(
                  child: TextFontWidget(
                    text: "5-04-2023",
                    fontsize: 12,
                    overflow: TextOverflow.ellipsis,
                  ),
                )),
              ],
            ),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                // SizedBox(
                //   width: 15,
                //   child: Center(
                //     child: Image.asset(
                //       'webassets/png/telephone.png',
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Center(
                    child: TextFontWidget(
                      text: "good",
                      fontsize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 01,
          ),
          Expanded(
            flex: 4,
            child: Row(
              children: [
                // SizedBox(
                //   width: 15,
                //   child: Center(
                //     child: Image.asset(
                //       'webassets/png/telephone.png',
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Center(
                    child: TextFontWidget(
                      text: "pass",
                      fontsize: 12,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ), //....................................... teacher licence number
          const SizedBox(
            width: 01,
          ),
          //............................. Status [Active or DeActivate]
        ],
      ),
    );
  }
}
