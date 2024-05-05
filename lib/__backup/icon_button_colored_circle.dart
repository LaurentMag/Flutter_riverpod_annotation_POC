import 'package:flutter/material.dart';

class DeleteCircleIcon extends StatelessWidget {
  final bool deleteLimit;
  final void Function() onDelete;

  const DeleteCircleIcon({
    super.key,
    required this.deleteLimit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: deleteLimit ? Colors.red : Colors.transparent,
      ),
      child: IconButton(
        icon: Icon(
          Icons.delete_outline,
          color: deleteLimit
              ? const Color.fromARGB(255, 243, 240, 240)
              : const Color.fromARGB(255, 36, 36, 36),
        ),
        onPressed: onDelete,
      ),
    );
  }
}
