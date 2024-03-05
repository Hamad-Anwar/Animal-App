import 'package:animal/view/farm/components/form_post_holder.dart';
import 'package:animal/view/upload_form/components/input_field.dart';
import 'package:flutter/material.dart';
import 'package:layout_pro/responsive_layout.dart';
import 'package:provider/provider.dart';
import '../../view_model/controllers/home_page_controller.dart';
import '../home/components/animal_post_holder.dart';

class FarmPage extends StatelessWidget {
  const FarmPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Farm Market',
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            InputField(hint: 'Search for forms', controller: TextEditingController(),

            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(child: Consumer<HomePageController>(
              builder: (context, value, child) {
                if (value.farmPostStatus==Status.loading) {
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
                else if(value.farmPostStatus==Status.complete){
                  if (value.farmPostList.isEmpty) {
                    return const Center(
                      child: Text('No Post Available'),
                    );
                  }
                  return ResponsiveLayout(
                      largeTabletCrossAxisCount: 4,
                      tabletCrossAxisCount: 3,
                      largeTabletRatio: 1.2,
                      mobileRatio: 1,
                      mobileCrossAxisCount: 2,
                      largeMobileCrossAxisCount: 2,
                      largeMobileRatio: 1,
                      tabletRatio: 1,
                      // largeTabletCrossAxisCount: 3,
                      // tabletCrossAxisCount: 2,
                      // largeTabletRatio: 1,
                      // mobileRatio: 0.95,
                      // largeMobileRatio: 0.95,
                      // tabletRatio: 0.98,
                      builder: (context, index) {
                        // return PostHolder(dataModel: value.farmPostList[index]);
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                          child: FormPostHolder(postModel: value.farmPostList[index]),
                        );
                      }, itemCount: value.farmPostList.length);
                }
                return const Center(
                  child: Text('Something Went Wrong! try again'),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
