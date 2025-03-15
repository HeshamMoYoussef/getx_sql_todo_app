import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sql/controller/sql_controller.dart';
import 'package:getx_sql/view/screens/add_or_update_screen.dart';
import 'package:getx_sql/view/widgets/todo_item.dart';

class HomeScreen extends GetView<SqlController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get.put(SqlController());
    Get.find<SqlController>();
    // Get.lazyPut(() => SqlController(), fenix: true);
    return Scaffold(
      appBar: AppBar(title: Text('ToDo App'), centerTitle: true),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: () {
          controller.isUpdateTask = false;
          // Navigate to Add New Task Screen
          Get.to(
            () => AddOrUpdateTaskScreen(),
            transition: Transition.downToUp,
          );
        },

        child: const Icon(Icons.add),
      ),
      body: GetBuilder<SqlController>(
        // init: SqlController(),
        builder:
            (controller) =>
                controller.list.isEmpty
                    ? const Center(
                      child: Text(
                        'No Tasks Found,\n\n Try Add New',
                        style: TextStyle(fontSize: 22, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    )
                    : ListView.builder(
                      itemCount: controller.list.length,
                      itemBuilder:
                          (context, index) =>
                              ItemTodo(controller, index: index),
                    ),
      ),
    );
  }
}
