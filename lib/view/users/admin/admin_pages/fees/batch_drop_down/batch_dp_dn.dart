import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_project_app/controller/batch_controller/batch_controller.dart';
import 'package:new_project_app/model/batch_model/batch_model.dart';

class UnpaidBatchDropDown extends StatelessWidget {
  final Function(BatchModel?)? onChanged;

  UnpaidBatchDropDown({super.key, this.onChanged});

  final BatchController batchController = Get.put(BatchController());

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<BatchModel>(
      items: [
        BatchModel(batchId: 'all', date: '', batchName: 'All Unpaid Students'),
      ],
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
