import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/constant/colors/colors.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/constant/utils/validations.dart';
import 'package:new_project_app/controller/login_histroy_controller/login_histroy_controller.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/login_history_model/login_history_model.dart';
import 'package:new_project_app/view/users/widgets/listcard_widget/listcard_widget.dart';
import 'package:new_project_app/view/widgets/appbar_color_widget/appbar_color_widget.dart';
import 'package:new_project_app/view/widgets/dropdown_widget/login_history/select_date.dart';
import 'package:new_project_app/view/widgets/dropdown_widget/login_history/select_month.dart';
import 'package:new_project_app/view/widgets/loading_widget/loading_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widget/text_font_widget.dart';
import 'package:new_project_app/view/widgets/text_font_widgets/google_poppins.dart';

class LoginHistory extends StatefulWidget {
  const LoginHistory({super.key});

  @override
  State<LoginHistory> createState() => _LoginHistoryState();
}

class _LoginHistoryState extends State<LoginHistory> {
  final adminLoginHistroyController = Get.find<AdminLoginHistroyController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: cWhite,
        title: Text(
          "Login History".tr,
        ),
        flexibleSpace: const AppBarColorWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 25),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // select month
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TextFontWidget(text: 'Month *', fontsize: 15),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 180,
                      child: SelectLoginMonthDropDown(),
                    ),
                  ],
                ),
                ///////////////////////////////
                // select Date
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const TextFontWidget(text: '* Date', fontsize: 15),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: 180,
                      child: SelectLoginDateDropDown(),
                    ),
                  ],
                ),
                ///////////////////////////////
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Obx(() {
                final monthValue =
                    adminLoginHistroyController.loginHMonthValue.value;
                final dayValue =
                    adminLoginHistroyController.loginHDayValue.value;
                return StreamBuilder(
                  stream: server
                      .collection('DrivingSchoolCollection')
                      .doc(UserCredentialsController.schoolId)
                      .collection('LoginHistory')
                      .doc(monthValue)
                      .collection(monthValue)
                      .doc(dayValue)
                      .collection(dayValue)
                      .orderBy('loginTime', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!.docs.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  "Please select the month and date",
                                  style: TextStyle(fontWeight: FontWeight.w400),
                                ),
                              ),
                            )
                          : ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final data =
                                    AdminLoginDetailHistoryModel.fromMap(
                                        snapshot.data!.docs[index].data());
                                return ListTileCardWidget(
                                  title: TextFontWidget(
                                    text: data.adminuserName,
                                    fontsize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 12),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.login,
                                              color: Colors.green,
                                              size: 28,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            GooglePoppinsWidgets(
                                                text:
                                                    "${timeConvert(DateTime.parse(data.loginTime))}",
                                                fontsize: 18),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Icon(
                                              Icons.logout,
                                              color: Colors.red,
                                              size: 28,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            GooglePoppinsWidgets(
                                                text: data.logoutTime == ''
                                                    ? 'Not found'
                                                    : timeConvert(
                                                        DateTime.parse(
                                                            data.logoutTime)),
                                                fontsize: 18),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                    } else if (snapshot.data == null) {
                      return const LoadingWidget();
                    } else {
                      return const LoadingWidget();
                    }
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
