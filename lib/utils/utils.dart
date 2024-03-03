import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Utils {
  static showImage(BuildContext context, String image) {
    showGeneralDialog(
      barrierColor: Colors.black,
      transitionDuration: const Duration(milliseconds: 500),
      barrierDismissible: true,
      barrierLabel: 'Barrier',
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        return Center(
          child: Hero(
            tag: 'IMAGEVIEW',
            child: Scaffold(
                backgroundColor: Colors.black,
                body: Container(
                  color: Colors.black,
                  child: Center(
                      child: CachedNetworkImage(imageUrl: image))
                  ),
                ),
            ),
        );
      },
    );
  }
}