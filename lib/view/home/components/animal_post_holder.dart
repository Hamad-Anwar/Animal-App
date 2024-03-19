import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import 'animal_post_details.dart';
import 'animal_post_images.dart';
import 'animal_post_social_icon.dart';
import 'animal_post_top.dart';

class PostHolder extends StatefulWidget {
  const PostHolder({super.key, required this.dataModel});

  final dynamic dataModel;

  @override
  State<PostHolder> createState() => _PostHolderState();
}

class _PostHolderState extends State<PostHolder>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      child: Column(
        children: [
          PostTop(dataModel: widget.dataModel),
          const SizedBox(
            height: 10,
          ),
          PostImages(dataModel: widget.dataModel),
          const SizedBox(
            height: 5,
          ),
          PostDetail(dataModel: widget.dataModel),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 10),
          //   child: Divider(
          //     color: Colors.black.withOpacity(.05),
          //   ),
          // ),
          // const AnimalPostSocialIcon(),
        ],
      ),
    );
  }
}
