import 'package:flutter/material.dart';

class TaskStatusSummaryCount extends StatelessWidget {
  const TaskStatusSummaryCount({
    super.key,
    required this.count,
    required this.title,
  });

  final String count;
  final String title;

  @override
  Widget build(BuildContext context) {
    final textThem = Theme.of(context).textTheme;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      color: Colors.white,
      elevation: 1,
      shadowColor: Colors.black38,
      child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${count ?? '0'}',
              style: textThem.titleLarge,
            ),
            Text(
              '${title ?? "Title"}',
              style: textThem.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
