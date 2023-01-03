import 'package:flutter/material.dart';
import 'package:todo_dafault/common/theme.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.name,
    this.date,
    this.imgUrl,
  });

  final String? date;
  final String? imgUrl;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: subtitle2),
            Text(date!, style: bodyText1),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: SizedBox(
            width: 48,
            height: 48,
            child: Image.asset(
              imgUrl!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
