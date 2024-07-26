import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/controller/login_histroy_controller/login_histroy_controller.dart';

class SelectLoginDateDropDown extends StatelessWidget {
  SelectLoginDateDropDown({
    super.key,
  });

  final loginHCtrl = Get.put(AdminLoginHistroyController());

  @override
  Widget build(BuildContext context) {
    return Center(
        child: DropdownSearch<String>(
      validator: (item) {
        if (item == null) {
          return "Required field";
        } else {
          return null;
        }
      },
      asyncItems: (value) {
        loginHCtrl.allLoginDayList.clear();

        return loginHCtrl.fetchLoginHDay();
      },
      itemAsString: (value) => value,
      onChanged: (value) async {
        if (value != null) {
          loginHCtrl.loginHDayValue.value = value;
          log(loginHCtrl.loginHDayValue.value);
        }
      },
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  hintText: "Search Date", border: OutlineInputBorder())),
          showSearchBox: true,
          searchDelay: Duration(microseconds: 10)),
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
