
import 'package:animal/view_model/controllers/localization_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Provider.of<LocalizationController>(context);
    return  Consumer(builder: (context, value, child) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children:[
          SizedBox(height: 10,),
          RadioListTile(
            title: Text('English'),
            value: 'English',
            groupValue: controller.selectLanguage,
            onChanged: (value) {
              controller.setLanguage(lan: value.toString());
            },
          ),
          RadioListTile(
            title: Text('Hindi'),
            value: 'Hindi',
            groupValue: controller.selectLanguage,
            onChanged: (value) {
              controller.setLanguage(lan: value.toString());
            },
          ),
          RadioListTile(
            title: Text('Marathi'),
            value: 'Marathi',
            groupValue: controller.selectLanguage,
            onChanged: (value) {
              controller.setLanguage(lan: value.toString());
            },
          ),
        ],
      );
    },);
  }
}
