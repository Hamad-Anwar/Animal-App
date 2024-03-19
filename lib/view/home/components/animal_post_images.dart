import 'dart:math';

import 'package:animal/view/common_widget/shimmer_effect.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../model/animal_model.dart';
import '../../../utils/utils.dart';

class PostImages extends StatefulWidget {
  const PostImages({super.key, required this.dataModel});
  final AnimalPostModel dataModel;

  @override
  State<PostImages> createState() => _PostImagesState();
}

class _PostImagesState extends State<PostImages> {
  int currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 180,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CarouselSlider(
                  items: [
                    ...widget.dataModel.images.map((image){
                      return GestureDetector(
                        onTap: () => Utils.showImage(context,image),
                        child: CachedNetworkImage(imageUrl: image,fit: BoxFit.cover,width: MediaQuery.sizeOf(context).width,
                          placeholder: (context, url) {
                          return Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.white,
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                                strokeWidth: 1,
                              ),
                            ),
                          );
                            // return ShimmerEffect(
                            //   child: Container(
                            //     height: double.infinity,
                            //     width: double.infinity,
                            //     decoration: BoxDecoration(
                            //       color: Colors.black12
                            //     ),
                            //   ),
                            // );
                          },
                        ),
                      );
                    },)
                  ], options:  CarouselOptions(
                initialPage: Random().nextInt(2),
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  currentIndex=index;
                  setState(() {

                  });
                },
                enableInfiniteScroll: true,
                reverse: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Indicators(currentIndex: currentIndex,length: widget.dataModel.images.length,)
          )
        ],
      ),
    );
  }
}

class Indicators extends StatelessWidget {
  const Indicators({super.key, required this.currentIndex, required this.length});
  final int length;
  final int currentIndex;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...List.generate(length, (index) => index).map((e){
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 6,
            width: currentIndex==e?12: 6,
            margin: const EdgeInsets.only(bottom: 17,left: 3),
            decoration: BoxDecoration(
                color: Colors.
                white,
                borderRadius: BorderRadius.circular(10)
            ),
          );
        })
      ]
    );
  }
}
