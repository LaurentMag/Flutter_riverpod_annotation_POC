import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/constants/months.dart';

class DateCard extends StatelessWidget {
  final DateTime? displayedDate;

  const DateCard({
    super.key,
    required this.displayedDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 194, 68, 40),
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
