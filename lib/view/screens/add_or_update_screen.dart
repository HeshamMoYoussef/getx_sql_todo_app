import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:getx_sql/controller/sql_controller.dart';
import 'package:getx_sql/view/widgets/custom_form_field.dart';
import 'package:intl/intl.dart';

class AddOrUpdateTaskScreen extends GetView<SqlController> {
  AddOrUpdateTaskScreen({
    super.key,
    this.id,
    this.title,
    this.description,
    this.time,
  });
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descController = TextEditingController();
  final timeController = TextEditingController();
  final int? id;
  final String? title;
  final String? description;
  final String? time;

  // To Show old Item data in Update Screen
  void onInitUpdateItemData() {
    if (controller.isUpdateTask) {
      titleController.text = title.toString();
      descController.text = description.toString();
      timeController.text = time.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.find<SqlController>();
    onInitUpdateItemData();
    return GestureDetector(
      onTap: () {
        // all the same as behavior
        FocusScope.of(context).unfocus();
        // FocusManager.instance.primaryFocus?.unfocus();
        // FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(controller.isUpdateTask ? 'Update Task' : 'Add New Task'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    controller: titleController,
                    validatorText: 'Please Enter title',
                    labelText: 'Title',
                    isReadOnly: false,
                  ),
                  CustomTextFormField(
                    controller: descController,
                    validatorText: 'Please Enter Description',
                    labelText: 'Description',
                    isReadOnly: false,
                  ),
                  CustomTextFormField(
                    controller: timeController,
                    validatorText: 'Please Enter Time',
                    labelText: 'Select Time',
                    isReadOnly: true,
                    onTap: () {
                      DatePicker.showTime12hPicker(
                        context,
                        onConfirm: (value) {
                          timeController.text = DateFormat(
                            'hh:mm a',
                          ).format(value);
                        },
                      );
                    },
                  ),
                  SizedBox(height: 35),

                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        if (controller.isUpdateTask) {
                          controller.updateDataBase(
                            id: id!,
                            title: titleController.text,
                            description: descController.text,
                            time: timeController.text,
                          );
                        } else {
                          controller.insertDataBase(
                            title: titleController.text,
                            description: descController.text,
                            time: timeController.text,
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(200, 50),
                      fixedSize: const Size(600, 50),
                      backgroundColor: Colors.blue.shade900,
                      // backgroundColor: Colors.deepPurple,
                    ),
                    child: Text(controller.isUpdateTask ? 'Update' : 'Add'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
