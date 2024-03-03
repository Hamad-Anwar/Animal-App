import 'package:animal/view_model/controllers/post_animal_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/input_field.dart';

class UploadForm {
  static showUploadForm({required BuildContext context}) {
    showGeneralDialog(context: context, pageBuilder: (context, animation, secondaryAnimation) {
      final controller = Provider.of<PostAnimalController>(context);
      var size = MediaQuery.sizeOf(context);
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Container(
            width: size.width,
            height: 410,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Post Animal Detials',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15,),
                InputField(
                  title: 'Name',
                  controller: controller.name,
                  hint: 'Enter Name of Animal',
                ),
                const SizedBox(height: 15,),
                InputField(
                  title: 'Address',
                  controller: controller.location,
                  hint: 'Your Address',
                ),
                const SizedBox(height: 15,),
                SizedBox(
                  width: MediaQuery
                      .sizeOf(context)
                      .width,
                  child: Row(
                    children: [
                      Expanded(
                        child: InputField(
                          type: TextInputType.number,
                          title: 'Price',
                          controller: controller.price,
                          hint: 'Price of animal',
                        ),
                      ),
                      const Expanded(child: Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: Center(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(width: 10,),
                              Icon(Icons.image, color: Colors.black38,),
                              SizedBox(width: 5,),
                              Text(
                                'Upload Images',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(height: 20,),
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: ()=>Provider.of<PostAnimalController>(context,listen: false).uploadPost(context: context,),
                  child: Container(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    alignment: Alignment.center,
                    child: Consumer<PostAnimalController>(
                      builder: (context, value, child) {
                        if(value.loading){
                          return const SizedBox(height: 15,width: 15,child: CircularProgressIndicator(
                            color: Colors.white,
                          ),);
                        }
                        return const Text('Upload',style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),);
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    },);
  }
}

