import 'package:flutter/material.dart';

import '../../../model/animal_model.dart';

class AnimalPostTop extends StatelessWidget {
  const AnimalPostTop({super.key, required this.animal});
  final AnimalModel animal;
  @override
  Widget build(BuildContext context) {
    return  const Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundColor: Colors.black12,
          child: Center(
            child: Icon(Icons.person,color: Colors.white,size: 40,),
          ),
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pankaj More',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,height: 0),),
            Text('Pankaj142',style: TextStyle(color: Colors.black54,fontSize: 12),),
            Row(
              children: [
                Text('11-Feb-20 Market',style: TextStyle(color: Colors.black54,fontSize: 12),),
                SizedBox(width: 10,),
                Icon(Icons.sell_outlined,color: Colors.red,size: 15,),
              ],
            ),
          ],
        ),
        Spacer(),
        Icon(Icons.more_vert_outlined,color: Colors.black,size: 20,),

      ],
    );
  }
}