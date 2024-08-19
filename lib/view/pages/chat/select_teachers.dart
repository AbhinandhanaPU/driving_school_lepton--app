import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:new_project_app/controller/user_credentials/user_credentials_controller.dart';

var adminNameListValue;

class GetSchoolAdminListDropDownButton extends StatefulWidget {
  const GetSchoolAdminListDropDownButton({super.key});

  @override
  State<GetSchoolAdminListDropDownButton> createState() =>
      _GetSchoolAdminListDropDownButtonState();
}

class _GetSchoolAdminListDropDownButtonState
    extends State<GetSchoolAdminListDropDownButton> {
  @override
  Widget build(BuildContext context) {
    return dropDownButton();
  }

  FutureBuilder<QuerySnapshot<Map<String, dynamic>>> dropDownButton() {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection("DrivingSchoolCollection")
            .doc(UserCredentialsController.schoolId)
            .collection("Admins")
            .get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            return DropdownButtonFormField(
              hint: adminNameListValue == null
                  ? const Text(
                      "Select Admin",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 18),
                    )
                  : Text(adminNameListValue!["username"]),
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                border: OutlineInputBorder(
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                filled: true,
              ),
              items: snapshot.data!.docs.map(
                (val) {
                  return DropdownMenuItem(
                    value: val["username"],
                    child: Text(val["username"]),
                  );
                },
              ).toList(),
              onChanged: (val) {
                var categoryIDObject = snapshot.data!.docs
                    .where((element) => element["username"] == val)
                    .toList()
                    .first;
                log(categoryIDObject["username"]);

                setState(
                  () {
                    adminNameListValue = categoryIDObject;
                  },
                );
              },
            );
          }
          return const SizedBox(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        });
  }
}
