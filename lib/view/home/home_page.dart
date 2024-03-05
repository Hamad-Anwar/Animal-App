import 'dart:async';
import 'package:animal/view/common_widget/app_bar.dart';
import 'package:animal/view/farm/farm_page.dart';
import 'package:animal/view/home/components/home_body.dart';
import 'package:animal/view/upload_form/upload_form.dart';
import 'package:animal/view_model/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/animal_post_holder.dart';

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
      Provider.of<HomePageController>(context, listen: false).getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    var controller=Provider.of<HomePageController>(context);
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () => UploadForm.showUploadForm(context: context),
      ),
      bottomNavigationBar: Consumer<HomePageController>(builder: (BuildContext context, HomePageController value, Widget? child) {
        return BottomNavigationBar(
          selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            onTap: (value) => controller.changePage(page: value),
            currentIndex: controller.currentPage,
            items:  [
              BottomNavigationBarItem(icon: Icon(Icons.home,),label: ''),
              BottomNavigationBarItem(icon: Text('Farm',
              style: TextStyle(
                color: value.currentPage==1? Colors.blue:Colors.grey
              ),
              ),label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.ondemand_video_outlined),label: ''),
            ]);
      },

      ),
      body: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: CustomAppBar(
                  title: 'Animal',
                ),
              ),
              Expanded(
                child: PageView(
                  controller: controller.pageController,
                  children: [
                    const HomeBody(),
                    const FarmPage()

                  ],
                ),
              ),
            ],
          )),
    );
  }
}
