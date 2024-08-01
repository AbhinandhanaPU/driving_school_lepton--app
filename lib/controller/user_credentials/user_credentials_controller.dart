import 'package:new_project_app/model/admin_model/admin_model.dart';
import 'package:new_project_app/model/teacher_model/teacher_model.dart';
import '../../model/student_model/student_model.dart';

class UserCredentialsController {
  static String? schoolId;

  static String? userRole;
  static String? currentUSerID;
  static StudentModel? studentModel;
  static TeacherModel? teacherModel;
  static AdminModel? adminModel;

  static void clearUserCredentials() {
    schoolId = null;
    userRole = null;
    studentModel = null;
    teacherModel = null;
    adminModel = null;
    currentUSerID = null;
  }
}
