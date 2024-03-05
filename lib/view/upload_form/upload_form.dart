import 'package:animal/view_model/controllers/home_page_controller.dart';
import 'package:animal/view_model/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'components/input_field.dart';

class UploadForm {
  static showUploadForm({required BuildContext context}) {
    showGeneralDialog(context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
      final controller = Provider.of<PostAnimalController>(context,listen: false);
      final homeController = Provider.of<HomePageController>(context,listen: false);
      var size = MediaQuery.sizeOf(context);
      return Material(
        color: Colors.transparent,
        child: Center(
          child: Consumer<PostAnimalController>(
            builder: (context, value, child) {
              return AnimatedContainer(
                width:400,
                height: value.selectedPostType=='animals' ? 410 : 600,
                duration: Duration(milliseconds: 100),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Post Detials',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 15,),
                      InputField(
                        title: 'Name',
                        controller: controller.name,
                        hint: 'Enter name of post',
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
                                hint: 'Price',
                              ),
                            ),
                            SizedBox(width: 10,),
                            Expanded(child: Padding(
                              padding: const EdgeInsets.only(top: 28),
                              child: DropdownMenu(
                                controller: controller.type,
                                initialSelection: value.selectedPostType,
                                width: 160,
                                onSelected: (value) {
                                  controller.changePostType(type: value.toString());
                                },
                                menuStyle: MenuStyle(
                                    shape: MaterialStatePropertyAll(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10)
                                        )
                                    )
                                ),
                                inputDecorationTheme: InputDecorationTheme(
                                  contentPadding: EdgeInsets.symmetric(horizontal: 10),
                                  constraints: BoxConstraints(
                                    maxHeight: 45,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Colors.black12
                                      )
                                  ),

                                ),
                                dropdownMenuEntries: [
                                  DropdownMenuEntry(value: 'animals', label: 'Animal'),
                                  DropdownMenuEntry(value: 'farms', label: 'Farms'),
                                ],
                              ),
                            ))
                            // const Expanded(child: Padding(
                            //   padding: EdgeInsets.only(top: 30),
                            //   child: Center(
                            //     child: Row(
                            //       crossAxisAlignment: CrossAxisAlignment.center,
                            //       children: [
                            //         SizedBox(width: 10,),
                            //         Icon(Icons.image, color: Colors.black38,),
                            //         SizedBox(width: 5,),
                            //         Text(
                            //           'Upload Images',
                            //           style: TextStyle(
                            //               color: Colors.blue,
                            //               fontWeight: FontWeight.bold
                            //           ),
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ))
                          ],
                        ),
                      ),
                    if(value.selectedPostType=='farms')  Column(
                        children: [
                          const SizedBox(height: 20,),
                          InputField(hint: 'dd-mm-yyyy', controller: TextEditingController(),title: 'Starting Date',
                            postFix: Icon(Icons.date_range,color: Colors.grey,),
                          ),
                          const SizedBox(height: 20,),
                          InputField(hint: 'dd-mm-yyyy', controller: TextEditingController(),title: 'End Date',
                            postFix: Icon(Icons.date_range,color: Colors.grey,),
                          ),
                        ],
                      ),
                      SizedBox(height: 20,),
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
                      ),
                      SizedBox(height: 20,),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      );
    },);
  }
}

