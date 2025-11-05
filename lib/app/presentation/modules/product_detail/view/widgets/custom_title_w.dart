import 'package:flutter/material.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';

class CustomTitleW extends StatelessWidget {
  const CustomTitleW({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    if (title == null || title!.isEmpty) {
      return 0.h;
    }
    return Text(
      title!,
      style: Theme.of(context).textTheme.titleMedium,
    ).center;
  }
}
