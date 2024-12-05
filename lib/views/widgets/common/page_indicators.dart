import 'package:flutter/material.dart';
import '../../../config/app_colors.dart';

class PageIndicator extends StatelessWidget {
  int length;
  int selectedIndex = 0;
  Color? indicatorColor;

  PageIndicator(
      {Key? key,
      required this.selectedIndex,
      required this.length,
      this.indicatorColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: length,
        shrinkWrap: true,
        itemBuilder: (context, position) {
          return AnimatedContainer(
            margin: const EdgeInsets.only(left: 8),
            width: position == selectedIndex ? 30 : 10,
            height: 8,
            decoration: BoxDecoration(
                color: position == selectedIndex
                    ? indicatorColor ?? AppColors.kPrimaryColor
                    : (indicatorColor ?? AppColors.kPrimaryColor)
                        .withOpacity(0.2),
                borderRadius: BorderRadius.circular(24)),
            duration: const Duration(milliseconds: 300),
          );
        });
  }
}
