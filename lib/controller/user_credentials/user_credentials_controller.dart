import 'package:new_project_app/model/teacher_model/teacher_model.dart';

import '../../model/student_model/student_model.dart';

class UserCredentialsController {
  static String? schoolId;

  static String? userRole;
  static String? currentUSerID;
  static StudentModel? studentModel;
  static TeacherModel? teacherModel;

  static void clearUserCredentials() {
    schoolId = null;
    userRole = null;
    studentModel = null;
    currentUSerID = null;
  }
}
