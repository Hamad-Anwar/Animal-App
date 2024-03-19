import 'dart:math';

import 'package:animal/model/animal_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FormPostHolder extends StatelessWidget {
  const FormPostHolder({super.key,required this.postModel});
  final AnimalPostModel postModel;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(imageUrl: postModel.images[Random().nextInt(2)],fit: BoxFit.cover,),
          Positioned(
              right: 10,top: 10,
              child: Text('0 Km',style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20
              ),))
        ],
      ),
    );
  }
}
