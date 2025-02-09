import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/ui/controller/create_new_task_controller.dart';
import 'package:task_manager/ui/utils/status.dart';
import 'package:task_manager/ui/widgets/centered_circular_progress_indicator.dart';

import '../widgets/background_screen.dart';
import '../widgets/snack_bar_massage.dart';
import '../widgets/tm_appBar.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  static const String name = '/add-new-task';

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _titleTEController = TextEditingController();
  final TextEditingController _descriptionTEController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool mainScreenRefrash = false;

  final CreateNewTaskController _createNewTaskController =
      Get.find<CreateNewTaskController>();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: mainScreenRefrash);
        return true;
      },
      child: Scaffold(
        appBar: TMAppBar(),
        body: BackgroundScreen(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),
                    Text('Add New Task', style: textTheme.titleLarge),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _titleTEController,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your title here';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _descriptionTEController,
                      maxLines: 6,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter your description here';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    GetBuilder<CreateNewTaskController>(builder: (controller) {
                      return Visibility(
                        visible: controller.inProgress == false,
                        replacement: const CenteredCircularProgressIndicator(),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _createNewTask();
                            }
                          },
                          child: const Icon(
                            Icons.arrow_circle_right_outlined,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _createNewTask() async {
    Map<String, dynamic> uploadMap = {
      "title": _titleTEController.text.trim(),
      "description": _descriptionTEController.text.trim(),
      "status": Status.New,
    };

    bool isSuccess = await _createNewTaskController.upload(uploadMap);
    if (isSuccess) {
      _clearTextFields();
      showSnackBarMessage(context, 'New task added!', true);
      mainScreenRefrash = true;
    } else {
      showSnackBarMessage(
          context, _createNewTaskController.errorMessege, false);
    }
  }

  void _clearTextFields() {
    _titleTEController.clear();
    _descriptionTEController.clear();
  }

  @override
  void dispose() {
    _titleTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
