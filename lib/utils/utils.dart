import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Utils {
  static String formatDate(DateTime date) {
    return DateFormat('dd-MMM-yy').format(date);
  }
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
                  child: Center(child: CachedNetworkImage(imageUrl: image))),
            ),
          ),
        );
      },
    );
  }
  static Future<List<String>> pickImages() async {
    final picker = await ImagePicker().pickMultiImage(
      imageQuality: 50,
    );
    if (picker.isNotEmpty) {
      return picker.map((e) => e.path).toList();
    } else {
      return [];
    }
  }

  static pickDate({required BuildContext context}) async {
    final date = await showDatePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (date != null) {
      return '${date.day}/${date.month}/${date.year}';
    }
    return '';
  }

  static showErrorDialog(
      {required BuildContext context,
      String title = 'Error',
      required String error}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              title,
              style: const TextStyle(),
            ),
            content:Text(error),
            // contentPadding: const EdgeInsets.only(left: 20,right: 20,top: 10),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Ok',
                    style: TextStyle(color: Colors.blueAccent),
                  ))
            ],
          );
        });
  }
}
