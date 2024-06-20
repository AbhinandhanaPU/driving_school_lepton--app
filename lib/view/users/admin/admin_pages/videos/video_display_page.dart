import 'dart:async';

import 'package:adaptive_ui_layout/flutter_responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/sizes/sizes.dart';

class VideosList extends StatefulWidget {
  const VideosList({
    super.key,
  });

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  final ScrollController controller = ScrollController();
  double _scrollPosition = 0.0;
  final double _scrollMax = 1000.0; // adjust this to your content's height
  Timer? _timer;
  @override
  void initState() {
    _startAutoScroll();
    super.initState();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      if (_scrollPosition < _scrollMax) {
        _scrollPosition += 1.0;
        if (controller.hasClients) {
          controller.animateTo(_scrollPosition,
              duration: const Duration(milliseconds: 50), curve: Curves.linear);
        }
      } else {
        _scrollPosition = 0.0;
        controller.jumpTo(0.0);
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        title: const Text("Recorded classes"),
      ),
      body: SafeArea(
          child: ListView.separated(
        itemCount: 5,
        separatorBuilder: ((context, index) {
          return kHeight10;
        }),
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(left: 10.h, right: 10.h, top: 10.h),
            child: Card(
              color: const Color.fromARGB(236, 228, 244, 255),
              clipBehavior: Clip.antiAlias,
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                shape: const BeveledRectangleBorder(
                    side: BorderSide(
                        color: Color.fromARGB(255, 125, 169, 225), width: 0.2)),
                leading: SizedBox(
                  width: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 17, right: 8),
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(
                            fontSize: 16.h,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const VerticalDivider(
                        color: cgrey, width: 1,
                        // indent: 4,
                        // endIndent: 4,
                      )
                    ],
                  ),
                ),
                title: SingleChildScrollView(
                  controller: controller,
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Text(
                        " video name",
                        // ' ${data['topicName']}',
                        style: TextStyle(
                          fontSize: 18.h,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                trailing: SizedBox(
                  width: 72,
                  child: GestureDetector(
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => PlayVideoFlicker(
                        //           videoUrl: data['downloadUrl'])
                        //                            //       ),
                        // );
                      },
                      child: const Icon(Icons.ondemand_video_outlined)),
                ),
              ),
            ),
          );
        },
      )),
    );
  }
}
