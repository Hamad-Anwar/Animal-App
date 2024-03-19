import 'package:animal/view/common_widget/select_language.dart';
import 'package:animal/view_model/controllers/localization_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../res/app_svg.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        // Positioned(left: 1, child: SvgPicture.asset(AppSvg.drawer, height: 20),),
        Icon(Icons.person),
        Center(child: Text(title.toString(),style: const TextStyle(
            fontWeight: FontWeight.bold,color: Colors.black87
        ),),),
        Positioned(right: 1, child: Row(
          children: [
            SvgPicture.asset(
              AppSvg.search,
              color: Colors.black87,
              width: 20,
            ),
            const SizedBox(
              width: 10,
            ),
            // SvgPicture.asset(
            //   AppSvg.notification,
            //   color: Colors.black87,
            //   width: 20,
            // ),
            GestureDetector(
                onTap: () {
                 showDialog(context: context, builder: (context) {
                   final controller=Provider.of<LocalizationController>(context,listen: false);
                   return AlertDialog(
                     title: Text('Select Language'),
                     contentPadding: EdgeInsets.zero,
                     titleTextStyle: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                     content: SelectLanguage(),
                     actions: <Widget>[
                      TextButton(onPressed: () {
                        if(controller.selectLanguage=='English'){
                          controller.changeLanguage(type: Locale('en'));
                        }else if(controller.selectLanguage=='Hindi'){
                          controller.changeLanguage(type: Locale('hi'));
                        }else if(controller.selectLanguage=='Marathi'){
                          controller.changeLanguage(type: Locale('mr'));
                        }
                        Navigator.pop(context);
                      }, child: Text('Ok'))
                     ],
                   );
                 },);
                },
                child: Icon(Icons.language,size: 20,))
          ],
        ),)
      ],
    );
  }
}