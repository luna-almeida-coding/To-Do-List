import 'package:flutter/material.dart';
import 'package:to_do_list_squad_premiun/design_system/colors/app_colors.dart';

class AppButton extends StatelessWidget {
  final Function onTap;
  final OutlinedBorder? shape;
  final String text;
  final bool isSelected;

  const AppButton({
    Key? key,
    required this.onTap,
    required this.text,
    this.shape,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () => onTap(),
      style: FilledButton.styleFrom(
        shape: shape,
        backgroundColor: isSelected ? AppColors.blue : AppColors.lightGrey,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? AppColors.white : AppColors.grey,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
