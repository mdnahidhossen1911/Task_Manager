import 'package:flutter/material.dart';
import 'package:task_manager/data/models/task_model.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

class TaskItemWidget extends StatelessWidget {
  final TaskModel taskModel;
  final VoidCallback ontabDetele;
  final ValueChanged ontabChangeStatus;
  TaskItemWidget({
    super.key,
    required this.taskModel,
    required this.ontabDetele,
    required this.ontabChangeStatus,
  });

  final List<String> dropdownItems = [
    'New',
    'Progress',
    'Cancel',
    'Complete',
  ];
  final List<Color> dropdownItemsColor = [
    Colors.lightBlueAccent,
    Colors.purpleAccent,
    Colors.redAccent,
    AppColors.themColor,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.black38,
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: ListTile(
          title: Text(
            taskModel.title ?? '',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w700,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                taskModel.description ?? '',
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.black54,
                ),
              ),
              SizedBox(height: 8),
              Text(
                taskModel.createdDate ?? '',
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: Color(
                    0xff3d3d3d,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: dropdownItemsColor[
                          _getStatusColor(taskModel.status!)],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        taskModel.status!,
                        style: TextStyle(fontSize: 10, color: Colors.white),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      DropdownButton<String>(
                        dropdownColor: Colors.white,
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.note_alt_outlined,
                          size: 20,
                          color: Colors.green,
                        ),
                        items: List.generate(
                          dropdownItems.length,
                          (index) {
                            return DropdownMenuItem<String>(
                              value: dropdownItems[index],
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: dropdownItemsColor[index],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 4),
                                  child: Text(
                                    dropdownItems[index],
                                    style: TextStyle(
                                        fontSize: 10, color: Colors.white),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                        onChanged: ontabChangeStatus,
                      ),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: ontabDetele,
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                          size: 20,
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<dynamic> buildPopupMenuItem(_title, _color) {
    return PopupMenuItem(
      child: Row(
        children: [
          CircleAvatar(
            radius: 5,
            backgroundColor: _color,
          ),
          SizedBox(width: 6),
          Text(_title),
        ],
      ),
    );
  }

  int _getStatusColor(String status) {
    if (status == 'New') {
      return 0;
    } else if (status == 'Progress') {
      return 1;
    } else if (status == 'Cancel') {
      return 2;
    } else {
      return 3;
    }
  }
}
