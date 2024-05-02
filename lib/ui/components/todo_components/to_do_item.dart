import 'package:flutter/material.dart';
import 'package:flutter_new_riverpod_test/models/to_do_model.dart';
import 'package:flutter_new_riverpod_test/ui/components/todo_components/date_card.dart';

class ToDoItem extends StatelessWidget {
  final ToDoModel toDo;
  final void Function() onDelete;
  final void Function() onToggle;

  const ToDoItem({
    super.key,
    required this.toDo,
    required this.onDelete,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: ItemDecoration.cardDecoration,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: IconButton(
                icon: toDo.isDone
                    ? const Icon(Icons.check_circle_rounded)
                    : const Icon(Icons.circle_outlined),
                onPressed: onToggle,
              ),
            ),
            DateCard(displayedDate: toDo.date),
            const SizedBox(width: 12),
            Text(toDo.title),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

// "CSS" class -----------------------------------------------
class ItemDecoration {
  static final BoxDecoration cardDecoration = BoxDecoration(
    border: Border.all(
      color: const Color.fromARGB(255, 188, 187, 187),
      width: 1,
    ),
    borderRadius: BorderRadius.circular(8),
  );

  static const VerticalDivider verticalDivider = VerticalDivider(
    color: Color.fromARGB(255, 184, 184, 184),
    thickness: 1.0,
    width: 0.0,
  );
}
