import 'package:flutter/material.dart';
import '../../../model/animal_model.dart';
import 'animal_post_details.dart';
import 'animal_post_images.dart';
import 'animal_post_social_icon.dart';
import 'animal_post_top.dart';

class AnimalPostHolder extends StatefulWidget {
  const AnimalPostHolder({super.key, required this.animal});

  final AnimalModel animal;

  @override
  State<AnimalPostHolder> createState() => _AnimalPostHolderState();
}

class _AnimalPostHolderState extends State<AnimalPostHolder>
    with AutomaticKeepAliveClientMixin {
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          AnimalPostTop(animal: widget.animal),
          const SizedBox(
            height: 10,
          ),
          AnimalPostImages(animal: widget.animal),
          const SizedBox(
            height: 5,
          ),
          AnimalPostDetail(animal: widget.animal),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Divider(
              color: Colors.black.withOpacity(.05),
            ),
          ),
          const AnimalPostSocialIcon(),
        ],
      ),
    );
  }
}
