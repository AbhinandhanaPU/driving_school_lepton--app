import 'package:get/get.dart';
import 'package:new_project_app/constant/utils/firebase/firebase.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';
import 'package:new_project_app/model/login_history_model/login_history_model.dart';

class AdminLoginHistroyController extends GetxController {
  List<AdminLoginDetailHistoryModel> loginHistorylistMonth = [];
  String loginTime = '';
  String month = '';
  String date = '';
  String docid = '';
  Rxn<AdminLoginDetailHistoryModel> loginhistoryModelData =
      Rxn<AdminLoginDetailHistoryModel>();

  RxBool loginHistroyontapped = false.obs;
  RxBool selectedMonth = false.obs;

  /////////////////////////////////////////\
  List<String> allLoginMonthList = [];
  RxString loginHMonthValue = 'dd'.obs;
  Future<List<String>> fetchLoginHMonth() async {
    final firebase = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('LoginHistory')
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list = firebase.docs[i].data()['docid'];
      allLoginMonthList.add(list);
    }
    return allLoginMonthList;
  }

  List<String> allLoginDayList = [];
  RxString loginHDayValue = 'dd'.obs;
  Future<List<String>> fetchLoginHDay() async {
    final firebase = await server
        .collection('DrivingSchoolCollection')
        .doc(UserCredentialsController.schoolId)
        .collection('LoginHistory')
        .doc(loginHMonthValue.value)
        .collection(loginHMonthValue.value)
        .get();

    for (var i = 0; i < firebase.docs.length; i++) {
      final list = firebase.docs[i].data()['docid'];
      allLoginDayList.add(list);
    }
    return allLoginDayList;
  }
}
