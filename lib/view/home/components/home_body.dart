import 'package:flutter/material.dart';
import 'package:layout_pro/responsive_layout.dart';
import 'package:provider/provider.dart';

import '../../../view_model/controllers/home_page_controller.dart';
import '../../common_widget/app_bar.dart';
import 'animal_post_holder.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Latest Updates',
            style:
            TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: Consumer<HomePageController>(
            builder: (context, value, child) {
              if (value.postStatus==Status.loading) {
                return const Center(
                  child: SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                      color: Colors.blue,
                    ),
                  ),
                );
              }
              if(value.postStatus==Status.complete){
                if (value.animalPostList.isEmpty) {
                  return const Center(
                    child: Text('No Post Available'),
                  );
                }
                return ResponsiveLayout(
                    largeTabletCrossAxisCount: 3,
                    tabletCrossAxisCount: 2,
                    largeTabletRatio: 1,
                    mobileRatio: 0.95,
                    largeMobileRatio: 0.95,
                    tabletRatio: 0.98,
                    builder: (context, index) {
                  return PostHolder(dataModel: value.animalPostList[index]);
                }, itemCount: value.animalPostList.length);
              }
               return const Center(
                child: Text('Something went wrong! try again'),
              );
            },
          ))
        ],
      ),
    );
  }
}
