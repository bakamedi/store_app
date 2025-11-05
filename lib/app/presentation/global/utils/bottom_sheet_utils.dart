import 'package:flutter/material.dart';
import 'package:store_app/app/presentation/global/extensions/widgets_ext.dart';
import 'package:store_app/app/presentation/global/widgets/inputs/input_text_gw.dart';

Future<String?> showTextInputBottomSheet(
  BuildContext context, {
  String? initialValue,
  String? labelText,
}) {
  final controller = TextEditingController(text: initialValue);
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    isDismissible: false,
    backgroundColor: Colors.white,
    builder: (context) {
      return SafeArea(
        bottom: true,
        child: Container(
          margin: const EdgeInsets.all(25),
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              const Text(
                'Enter the Custom Title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              InputTextGW(controller: controller),
              ElevatedButton(
                onPressed: () => Navigator.pop(context, controller.text),
                child: const Text('Save'),
              ),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Close'),
              ),
              16.h,
            ],
          ),
        ),
      );
    },
  );
}
