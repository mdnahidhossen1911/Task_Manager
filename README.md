# Task Manager App 📅✅
A powerful Task Manager App built with Flutter, using GetX for state management and SharedPreferences for local storage. Easily create, update, delete, and filter tasks by status (New, In Progress, Completed, Canceled).

✨ Features:
- User Authentication (Login, Registration)
- Task Management (CRUD operations)
- Task Filtering & Status Count
- Secure Local Storage (SharedPreferences)
- State Management with GetX
- A new Flutter project.


## Screenshots
![flutter-task-manager](https://raw.githubusercontent.com/mdnahidhossen1911/Task_Manager/refs/heads/master/screenshort.png)


## Project File Tree format
~~~
lib
├── data
│   ├── models
│   │   ├── task_count_by_status_model.dart
│   │   ├── task_count_model.dart
│   │   ├── task_list_by_status_model.dart
│   │   ├── task_model.dart
│   │   └── user_model.dart
│   ├── services
│   │   └── network_caller.dart
│   └── utils
│       └── urls.dart
├── ui
│   ├── controller
│   │   ├── auth_controller.dart
│   │   ├── cancel_task_list_controller.dart
│   │   ├── complete_task_list_controller.dart
│   │   ├── create_new_task_controller.dart
│   │   ├── forgot_password_gmail_controller.dart
│   │   ├── forgot_password_otp_controller.dart
│   │   ├── image_picker_controller.dart
│   │   ├── new_task_list_controller.dart
│   │   ├── profile_update_controller.dart
│   │   ├── progress_task_list_controller.dart
│   │   ├── recovery_password_controller.dart
│   │   ├── sign_in_controller.dart
│   │   ├── sign_up_controller.dart
│   │   ├── summary_task_list_controller.dart
│   │   ├── task_delete_controller.dart
│   │   └── task_update_controller.dart
│   ├── screens
│   │   ├── add_new_task_screen.dart
│   │   ├── canceled_task_list_screen.dart
│   │   ├── completed_task_list_screen.dart
│   │   ├── forgot_password_email_verification.dart
│   │   ├── forgot_password_otp_verification.dart
│   │   ├── main_bottom_nav_screen.dart
│   │   ├── new_task_list_screen.dart
│   │   ├── progress_task_list_screen.dart
│   │   ├── recovery_password_screen.dart
│   │   ├── sign_in_screen.dart
│   │   ├── sign_up_screen.dart
│   │   ├── splash_screen.dart
│   │   ├── task_update_screen.dart
│   │   └── update_profile_screen.dart
│   ├── utils
│   │   ├── app_colors.dart
│   │   ├── assets_path.dart
│   │   └── status.dart
│   └── widgets
│       ├── app_logo.dart
│       ├── background_screen.dart
│       ├── centered_circular_progress_indicator.dart
│       ├── snack_bar_message.dart
│       ├── task_item_widget.dart
│       ├── task_status_summary_count.dart
│       ├── task_widgets.dart
│       └── tm_appBar.dart
├── app.dart
├── controll_binder.dart
└── main.dart
~~~


