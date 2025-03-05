import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';

class CheckboxWidget extends StatelessWidget {
  const CheckboxWidget({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final Function() onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onChanged(),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(
            color: Constants.ristekPrimaryColor,
            width: 2,
          ),
        ),
        child: Center(
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: value ? Constants.ristekPrimaryColor : Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}
