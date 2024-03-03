import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../res/app_svg.dart';
class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key, this.title});
  final String? title;
  @override
  Widget build(BuildContext context) {
    return  Stack(
      children: [
        Positioned(left: 1, child: SvgPicture.asset(AppSvg.drawer, height: 20),),
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
            SvgPicture.asset(
              AppSvg.notification,
              color: Colors.black87,
              width: 20,
            ),
          ],
        ),)
      ],
    );
  }
}