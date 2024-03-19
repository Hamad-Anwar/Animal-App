import 'package:animal/main.dart';
import 'package:animal/utils/emun_filters.dart';
import 'package:animal/view/common_widget/aniamal_post_leading_effect.dart';
import 'package:flutter/material.dart';
import 'package:layout_pro/responsive_layout.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../view_model/controllers/home_page_controller.dart';
import 'animal_post_holder.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<HomePageController>(context,listen: false).postScrollController.addListener(() {
    });
  }
  @override
  Widget build(BuildContext context) {
    var local=AppLocalizations.of(context)!;
    final homeController=Provider.of<HomePageController>(context,listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(
             children: [
               Consumer<HomePageController>(builder: (context, value, child) {
                 return Text(
                  value.filter==PostFilters.nearby? local.latest_updates : "All Posts",
                   style:
                   const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                 );
               },),
               Spacer(),
               GestureDetector(
                 onTap: () {
                   showModalBottomSheet(
                     isScrollControlled: false,
                     context: context, builder: (context) {
                     return Container(
                       height: 80,
                       decoration: const BoxDecoration(
                         color: Colors.white,
                         borderRadius: BorderRadius.only(
                           topRight: Radius.circular(30),
                           topLeft: Radius.circular(30)
                         )
                       ),
                       child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                           FilterButton(title: 'Nearby', onTap: () {
                             homeController.changeFilter(postFilter: PostFilters.nearby);
                             homeController.getData(location: user!.nearestLocations[homeController.currentIndexAnimalPost]);
                             Navigator.pop(context);
                           },)
                           ,FilterButton(title: 'All Posts', onTap: () {
                             homeController.changeFilter(postFilter: PostFilters.all);
                             homeController.getData(location: 'all');
                             Navigator.pop(context);
                           },)
                         ],
                       ),
                     );
                   },);
                 },
                 child: CircleAvatar(
                   radius: 15,
                   backgroundColor: Colors.grey.withOpacity(.04),
                   child: const Center(
                     child: Icon(Icons.filter_list,color: Colors.grey,),
                   ),
                 ),
               )
             ],
           ),
          const SizedBox(
            height: 20,
          ),
          Expanded(child: Consumer<HomePageController>(
            builder: (context, value, child) {
              if (value.postStatus==Status.loading) {
                return ResponsiveLayout(

                    largeTabletCrossAxisCount: 3,
                    tabletCrossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    largeTabletRatio: 1,
                    mobileRatio: 1.08,
                    largeMobileRatio: 0.87,
                    tabletRatio: 0.98,
                    builder: (context, index) {
                      return const Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: AnimalPostLoadingEffect(),
                      );
                    }, itemCount: 10,);
              }
              if(value.postStatus==Status.complete){
                if (value.animalPostList.isEmpty) {
                  return Center(
                    child: Text(local.no_post_available),
                  );
                }
                return ResponsiveLayout(
                    largeTabletCrossAxisCount: 3,
                    tabletCrossAxisCount: 2,
                    padding: EdgeInsets.zero,
                    controller: value.postScrollController,
                    largeTabletRatio: 1,
                    mobileRatio: 1.08,
                    largeMobileRatio: 0.87,
                    tabletRatio: 0.98,
                    builder: (context, index) {
                  return PostHolder(dataModel: value.animalPostList[index]);
                }, itemCount: value.animalPostList.length);
              }
               return  Center(
                child: Text(local.something_went_wrong),
              );
            },
          ))
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  const FilterButton({super.key, required this.title, required this.onTap});
  final String title;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: 100,
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10)
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
