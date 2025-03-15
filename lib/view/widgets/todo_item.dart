import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_sql/controller/sql_controller.dart';
import 'package:getx_sql/view/screens/add_or_update_screen.dart';

class ItemTodo extends GetView<SqlController> {
  const ItemTodo(this.controller, {super.key, required this.index});
  @override
  final SqlController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    Get.find<SqlController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade200.withGreen(390),
              Colors.blue.shade600,
              Colors.blue.shade700,
              Colors.blue.shade800,
              Colors.blue.shade800,
              Colors.blue.shade900.withGreen(900),
            ],
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 14, right: 10),
          title: Row(
            children: [
              Expanded(flex: 25, child: Text(controller.list[index].title)),
              Expanded(
                flex: 4,
                child: InkWell(
                  onTap: () {
                    controller.updateItemToBeFav(
                      taskId: controller.list[index].id,
                      favorite: controller.list[index].favorite,
                    );
                    log(controller.list[index].favorite.toString());
                  },

                  child: Icon(
                    controller.list[index].favorite == 0
                        ? Icons.favorite_border_outlined
                        : Icons.favorite,
                    color:
                        controller.list[index].favorite == 0
                            ? Colors.grey
                            : Colors.red,
                  ),
                ),
              ),
            ],
          ),
          subtitle: ListTile(title: Text(controller.list[index].description)),
          // leading: Icon(Icons.list),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(controller.list[index].time),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                    onTap: () {
                      // Go to updateDataBase
                      controller.isUpdateTask = true;
                      // Navigate to implement **UpdateDataBase** function in AddOrUpdateTaskScreen
                      Get.to(
                        () => AddOrUpdateTaskScreen(
                          id: controller.list[index].id,
                          title: controller.list[index].title,
                          description: controller.list[index].description,
                          time: controller.list[index].time,
                        ),
                        transition: Transition.zoom,
                      );
                    },
                    child: Icon(
                      Icons.edit,
                      color: const Color.fromARGB(255, 3, 219, 10),
                    ),
                  ),
                  SizedBox(width: 14),
                  InkWell(
                    onTap: () {
                      controller.deleteOneItemData(
                        id: controller.list[index].id,
                      );
                    },
                    child: const Icon(
                      Icons.delete_sweep,
                      color: Color.fromARGB(255, 160, 55, 48),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
