import 'dart:async';
import 'package:animal/view/common_widget/app_bar.dart';
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
     Provider.of<HomePageController>(context,listen: false).getData();
   });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add,color: Colors.white,),
        onPressed: ()=>UploadForm.showUploadForm(context: context),),
      body:  SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(padding: EdgeInsets.symmetric(vertical: 20),
            child: CustomAppBar(
              title: 'Animal',
            ),
            ),
            const Text('Latest Updates',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Consumer<HomePageController>(builder: (context, value, child) {
                if(value.loading){
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
                if(value.postList.isEmpty){
                  return const Center(
                    child: Text('No Post Available'),
                  );
                }
                return ListView.builder(
                  addAutomaticKeepAlives: true,
                  itemCount: value.postList.length,
                  itemBuilder: (context, index) {
                  return AnimalPostHolder(animal: value.postList[index]);
                },);
              },)
            )
          ],
        ),
      )),
    );
  }
}






