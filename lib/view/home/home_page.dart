import 'dart:async';
import 'package:animal/main.dart';
import 'package:animal/view/common_widget/app_bar.dart';
import 'package:animal/view/farm/farm_page.dart';
import 'package:animal/view/home/components/home_body.dart';
import 'package:animal/view/reels/reels.dart';
import 'package:animal/view/upload_form/upload_form.dart';
import 'package:animal/view_model/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../view_model/controllers/post_controller.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 100), () {
     final controller= Provider.of<HomePageController>(context, listen: false);
     controller.getData(location: user!.nearestLocations[controller.currentIndexAnimalPost]);
    });
  }

  @override
  Widget build(BuildContext context) {
    currentContext=context;
    var controller=Provider.of<HomePageController>(context,listen: false);
    var formController=Provider.of<PostAnimalController>(context,listen: false);
    var local=AppLocalizations.of(context)!;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.blue,
      //   child: const Icon(
      //     Icons.add,
      //     color: Colors.white,
      //   ),
      //   onPressed: () => UploadForm.showUploadForm(context: context),
      // ),
      floatingActionButton: GestureDetector(
        onTap:()=> UploadForm.showUploadForm(context: context),
        child: Consumer<HomePageController>(
          builder: (context, value, child) {
            return Container(
              height: 50,
              width: 120,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(value.currentPage==0 ? 'Add Animal'
                    : value.currentPage==1 ? 'Add Farm' : 'Upload Reel'
                    ,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  const Icon(Icons.add,color: Colors.white,size: 20,)
                ],
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: Consumer<HomePageController>(builder: (BuildContext context, HomePageController value, Widget? child) {
        return BottomNavigationBar(
          selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: (value){
              formController.changePostType(type: value==0? 'animals' : 'farms');
            controller.changePage(page: value);},
            showSelectedLabels: false,
            showUnselectedLabels: false,
            currentIndex: controller.currentPage,
            items:  [
              const BottomNavigationBarItem(icon: Icon(Icons.home,applyTextScaling: false,),label: '',
              ),
              BottomNavigationBarItem(icon: Text(local.farm,
              style: TextStyle(
                color: value.currentPage==1? Colors.blue:Colors.grey
              ),
              ),label: ''),
              const BottomNavigationBarItem(icon: Icon(Icons.ondemand_video_outlined),label: ''),
            ]);
      },

      ),
      body: Column(
        children: [
          Consumer<HomePageController>(builder: (context, value, child) {
            if(value.currentPage!=2){
              return  SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: CustomAppBar(
                    title: local.animal,
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },),
          Expanded(
            child: PageView(
              controller: controller.pageController,
              onPageChanged: (value) {
                controller.changePage(page: value);
                formController.changePostType(type: value==0? 'animals' : 'farms');
              },
              children: const [
                HomeBody(),
                FarmPage(),
                Reels()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
