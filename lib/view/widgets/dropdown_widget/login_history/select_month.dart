import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_project_app/controller/login_histroy_controller/login_histroy_controller.dart';

class SelectLoginMonthDropDown extends StatelessWidget {
  SelectLoginMonthDropDown({
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
        loginHCtrl.allLoginMonthList.clear();

        return loginHCtrl.fetchLoginHMonth();
      },
      itemAsString: (value) => value,
      onChanged: (value) async {
        if (value != null) {
          loginHCtrl.loginHMonthValue.value = value;
          log(loginHCtrl.loginHMonthValue.value);
          loginHCtrl.selectedMonth.value = true;
        }
      },
      popupProps: const PopupProps.menu(
          searchFieldProps: TextFieldProps(
              decoration: InputDecoration(
                  hintText: "Search Month", border: OutlineInputBorder())),
          showSearchBox: true,
          searchDelay: Duration(microseconds: 10)),
      dropdownDecoratorProps: DropDownDecoratorProps(
          baseStyle: GoogleFonts.poppins(
              fontSize: 13, color: Colors.black.withOpacity(0.7))),
    ));
  }
}
