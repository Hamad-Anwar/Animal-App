import 'package:flutter/material.dart';

import '../../../model/animal_model.dart';

class PostDetail extends StatelessWidget {
  const PostDetail({super.key, required this.dataModel});
  final dynamic dataModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(dataModel.name,style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 15
              ),),
              Row(
                children: [
                  Text('\$ ${dataModel.price}',style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 13
                  ),),
                  const SizedBox(width: 10,),
                  const Text('Market',style: TextStyle(
                    color: Colors.grey,
                  ),),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.location_on_rounded,color: Colors.black26,size: 20,),
                  const SizedBox(width: 5,),
                  const Text('0 km'),
                  const SizedBox(width: 10,),
                  Text(dataModel.location,style: const TextStyle(
                      color: Colors.grey
                  ),),
                ],
              )

            ],
          ),
          const Spacer(),
          Container(
            height: 35,
            width: 90,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.blue,
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.call,color: Colors.blue,size: 20,),
                SizedBox(width: 10,),
                Text('Call',style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 12
                ),),
                SizedBox(width: 10,),

              ],
            ),
          )
        ],
      ),
    );
  }
}