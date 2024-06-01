import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/constants/months.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class ToDoItemDate extends StatelessWidget {
  final DateTime? displayedDate;
  final bool isDone;

  const ToDoItemDate({
    super.key,
    required this.displayedDate,
    required this.isDone,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      decoration: BoxDecoration(
        color: isDone
            ? const Color.fromARGB(255, 118, 108, 104)
            : AppColors.dateBackground,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Text(
            dateFormat(displayedDate),
            style: const TextStyle(color: Color.fromARGB(255, 233, 231, 231)),
          ),
        ),
      ),
    );
  }
}

String dateFormat(DateTime? date) {
  return date == null ? '' : ' ${date.day}\n${monthNames[date.month - 1]}';
}
