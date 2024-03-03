import 'package:flutter/material.dart';

class AnimalPostSocialIcon extends StatelessWidget {
  const AnimalPostSocialIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [


          _buildIcon(name: 'Like', iconData: Icons.favorite_border_rounded),
          _buildIcon(name: 'Share', iconData: Icons.share),
          _buildIcon(name: 'WhatsApp', iconData: Icons.whatshot_sharp)
        ],
      ),
    );
  }
  Widget _buildIcon({required String name,required IconData iconData}){
    return Row(
      children: [
        Icon(iconData,
          color: Colors.black26,size: 25,
        ),
        const SizedBox(width: 5,),
        Text(name,)
      ],
    );
  }
}