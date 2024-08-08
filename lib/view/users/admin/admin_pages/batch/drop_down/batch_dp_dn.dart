import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:new_project_app/controller/batch_controller/batch_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';

class BatchDropDown extends StatelessWidget {
  final Function(BatchModel?)? onChanged; 

  BatchDropDown({super.key, this.onChanged});

  final BatchController batchController = Get.put(BatchController());

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<BatchModel>(
      validator: (item) {
        if (item == null) {
          return "Required field";
        } else {
          return null;
        }
      },
      asyncItems: (String filter) async {
        await batchController.fetchBatches();
        return batchController.batches.toList();
      },
      itemAsString: (BatchModel batch) => batch.batchName,
      onChanged: (BatchModel? batch) {
        if (onChanged != null) {
          onChanged!(batch);
        }
      },
      dropdownDecoratorProps: const DropDownDecoratorProps(
        baseStyle: TextStyle(fontSize: 14),
        dropdownSearchDecoration: InputDecoration(
          hintText: "Select Batch",
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
