import '../../model/student_model/student_model.dart';

class UserCredentialsController {
  static String? schoolId;

  static String? userRole;
  static String? currentUSerID;
  static StudentModel? studentModel;

  static void clearUserCredentials() {
    schoolId = null;
    userRole = null;
    studentModel = null;
    currentUSerID = null;
  }
}
