import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/data/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/ui/todo/components/to_do_item_date.dart';
import 'package:flutter_new_riverpod_test/ui/todo/logic/todo_settings.dart';
import 'package:flutter_new_riverpod_test/ui_style/colors.dart';

class ToDoItemTopAnimated extends StatelessWidget {
  final ToDoModel toDo;
  final double translationX;
  final double cardHeight;

  const ToDoItemTopAnimated({
    super.key,
    required this.toDo,
    required this.translationX,
    required this.cardHeight,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration:
          const Duration(milliseconds: TodoSettings.animationDurationTopCard),
      transform: Matrix4.translationValues(translationX, 0, 0),
      child: Container(
        height: cardHeight,
        decoration: containerCardDecoration,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Row(
            children: [
              ToDoItemDate(
                displayedDate: toDo.date,
                isDone: toDo.isDone,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    toDo.title,
                    style: TextStyle(
                        fontSize: TodoSettings.toDoCardFontSize,
                        decoration:
                            toDo.isDone ? TextDecoration.lineThrough : null),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

final BoxDecoration containerCardDecoration = BoxDecoration(
  color: AppColors.grayLightBg,
  border: Border.all(
    color: AppColors.cardBorder,
    width: 1,
  ),
  borderRadius: BorderRadius.circular(8),
);
