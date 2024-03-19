import 'package:animal/view/farm/components/form_post_holder.dart';
import 'package:animal/view/upload_form/components/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:layout_pro/responsive_layout.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../view_model/controllers/home_page_controller.dart';

class FarmPage extends StatelessWidget {
  const FarmPage({super.key});
  @override
  Widget build(BuildContext context) {
     var local=AppLocalizations.of(context)!;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             Text(
              local.farm_market,
              style:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(hint: local.search_for_farms, controller: TextEditingController(),

                  ),
                ),
                SizedBox(width: 10,),
                CircleAvatar(
                  radius: 15,
                  backgroundColor: Colors.grey.withOpacity(.04),
                  child: Center(
                    child: Icon(Icons.filter_list,color: Colors.grey,),
                  ),
                )
              ],
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
                    return  Center(
                      child: Text(local.no_post_available),
                    );
                  }
                  return ResponsiveLayout(
                    padding: EdgeInsets.zero,
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
                return  Center(
                  child: Text(local.something_went_wrong),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
