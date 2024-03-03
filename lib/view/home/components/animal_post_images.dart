import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../model/animal_model.dart';
import '../../../utils/utils.dart';

class AnimalPostImages extends StatelessWidget {
  const AnimalPostImages({super.key, required this.animal});
  final AnimalModel animal;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 200,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: CarouselSlider(
              items: animal.images.map((image) => GestureDetector(
                onTap: () => Utils.showImage(context,image),
                child: CachedNetworkImage(imageUrl: image,fit: BoxFit.cover,width: MediaQuery.sizeOf(context).width,
                  placeholder: (context, url) {
                    return Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.white,
                      child: const Center(
                        child: const SizedBox(
                          height: 15,
                          width: 15,
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),).toList(), options:  CarouselOptions(
            initialPage: Random().nextInt(2),
            viewportFraction: 1,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlayInterval: const Duration(seconds: 3),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            scrollDirection: Axis.horizontal,
          )),
        ),
      ),
    );
  }
}