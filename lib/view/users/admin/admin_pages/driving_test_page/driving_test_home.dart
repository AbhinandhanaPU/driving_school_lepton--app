import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/controller/test_controller/test_controller.dart';
import 'package:new_project_app/model/test_model/test_model.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/CRUD/create_test.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/data_list/alltest_studentlist.dart';
import 'package:new_project_app/view/users/admin/admin_pages/driving_test_page/data_list/list_test.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/buttoncontaiber_widget/button_container_widget.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';

class DrivingHomePage extends StatelessWidget {
  DrivingHomePage({super.key});
  final TestController testController = Get.put(TestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Driving Test".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: testController.fetchOrderedDrivingTests(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isEmpty) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              "Please schedule a test",
                              style: TextStyle(fontWeight: FontWeight.w400),
                            ),
                          ),
                        );
                      } else {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            final data = TestModel.fromMap(snapshot.data![index]);
                            return GestureDetector(
                              onTap: () {
                                Get.to(() => AllTestStudentList(testModel: data));
                              },
                              child: DrivingTestList(data: data),
                            );
                          },
                        );
                      }
                    } else {
                      return const LoadingWidget();
                    }
                  },
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: () {},
              child: ButtonContainerWidgetRed(
                curving: 30,
                height: 40,
                width: 180,
                child: const Center(
                  child: TextFontWidgetRouter(
                    text: 'Send Notification',
                    fontsize: 14,
                    fontWeight: FontWeight.bold,
                    color: cWhite,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) {
                    return CreateTest();
                  },
                ));
              },
              child: ButtonContainerWidget(
                  curving: 30,
                  colorindex: 0,
                  height: 40,
                  width: 140,
                  child: const Center(
                    child: TextFontWidgetRouter(
                      text: 'Create Test',
                      fontsize: 14,
                      fontWeight: FontWeight.bold,
                      color: cWhite,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
