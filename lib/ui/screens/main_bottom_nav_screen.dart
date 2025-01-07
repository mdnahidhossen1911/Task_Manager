import 'package:flutter/material.dart';
import 'package:task_manager/ui/utils/app_colors.dart';

import 'core/screens.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  static String name = '/home';

  @override
  State<MainBottomNavScreen> createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    NewTaskListScreen(),
    CompletedTaskListScreen(),
    CanceledTaskListScreen(),
    ProgressTaskListScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.themColor,
        onTap: (index) {
          _selectedIndex = index;
          setState(() {});
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), label: 'New Task'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sticky_note_2), label: 'Completed'),
          BottomNavigationBarItem(
              icon: Icon(Icons.cancel_outlined), label: 'Canceled'),
          BottomNavigationBarItem(
              icon: Icon(Icons.incomplete_circle), label: 'Progress'),
        ],
      ),
    );
  }
}
