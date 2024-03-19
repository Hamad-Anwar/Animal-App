import 'package:flutter/material.dart';

import '../../../model/animal_model.dart';

class PostTop extends StatelessWidget {
  const PostTop({super.key, required this.dataModel});
  final AnimalPostModel dataModel;
  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        const CircleAvatar(
          radius: 20,
          backgroundColor: Colors.black12,
          child: Center(
            child: Icon(Icons.person,color: Colors.white,size: 30,),
          ),
        ),
        const SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dataModel.owner.name,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,height: 0),),
            // Text('Pankaj142',style: TextStyle(color: Colors.black54,fontSize: 12),),
            Row(
              children: [
                Text('${dataModel.owner.date} Market',style: const TextStyle(color: Colors.black54,fontSize: 12),),
                const SizedBox(width: 10,),
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