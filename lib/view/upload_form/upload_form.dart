import 'dart:io';
import 'package:animal/view/upload_form/components/animal_form.dart';
import 'package:animal/view/upload_form/components/farm_form.dart';
import 'package:animal/view_model/controllers/home_page_controller.dart';
import 'package:animal/view_model/controllers/post_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'components/input_field.dart';
class UploadForm {
  static showUploadForm({required BuildContext context}) {
    var local=AppLocalizations.of(context)!;
    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) {
        final controller =
            Provider.of<PostAnimalController>(context, listen: false);
        final homeController =
            Provider.of<HomePageController>(context, listen: false);
        var size = MediaQuery.sizeOf(context);
        return Material(
            color: Colors.transparent,
            child: AnimatedContainer(
              width: size.width,
              height: size.height,
              duration: const Duration(milliseconds: 100),
              padding: const EdgeInsets.only(left: 20, right: 20),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: AssetImage('assets/images/bg.png',),fit: BoxFit.cover
              )
              ),
              child: SafeArea(
                child: Center(
                  child: Card(
                    child: SizedBox(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                               Center(
                                 child: Text(
                                  local.post_details,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                                               ),
                               ),
                              const SizedBox(
                                height: 15,
                              ),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                child: Row(
                                  children: [
                                    // Expanded(
                                    //     child: Padding(
                                    //   padding: const EdgeInsets.only(top: 0),
                                    //   child: DropdownMenu(
                                    //     controller: controller.type,
                                    //     initialSelection: controller.selectedPostType,
                                    //     width: MediaQuery.sizeOf(context).width / 2.75,
                                    //     onSelected: (value) {
                                    //       controller.changePostType(
                                    //           type: value.toString());
                                    //     },
                                    //     menuStyle: MenuStyle(
                                    //         shape: MaterialStatePropertyAll(
                                    //             RoundedRectangleBorder(
                                    //                 borderRadius:
                                    //                     BorderRadius.circular(10)))),
                                    //     inputDecorationTheme: InputDecorationTheme(
                                    //       contentPadding:
                                    //           const EdgeInsets.symmetric(horizontal: 10),
                                    //       constraints: const BoxConstraints(
                                    //         maxHeight: 45,
                                    //       ),
                                    //       border: OutlineInputBorder(
                                    //           borderRadius: BorderRadius.circular(10),
                                    //           borderSide:
                                    //               const BorderSide(color: Colors.black12)),
                                    //     ),
                                    //     dropdownMenuEntries: [
                                    //        DropdownMenuEntry(
                                    //           value: 'animals', label: local.animal),
                                    //        DropdownMenuEntry(
                                    //           value: 'farms', label: local.farm),
                                    //     ],
                                    //   ),
                                    // )),
                                    // const SizedBox(
                                    //   width: 5,
                                    // ),
                                    Consumer<PostAnimalController>(builder: (context, value, child) {
                                      return controller.selectedPostType == 'animals'? Expanded(
                                        child: DropdownMenu(
                                          controller: controller.name,
                                          // initialSelection: '',
                                          hintText: 'Animal',
                                          width: MediaQuery.sizeOf(context).width-90,
                                          onSelected: (value) {
                                            // controller.changePostType(
                                            //     type: value.toString());
                                          },
                                          menuStyle: MenuStyle(
                                              shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10)))),
                                          inputDecorationTheme: InputDecorationTheme(
                                            contentPadding:
                                            const EdgeInsets.symmetric(horizontal: 10),
                                            constraints: const BoxConstraints(
                                              maxHeight: 45,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide:
                                                const BorderSide(color: Colors.black12)),
                                          ),
                                          dropdownMenuEntries: const [
                                            DropdownMenuEntry(
                                                value: 'Cow', label: 'Cow'),
                                            DropdownMenuEntry(
                                                value: 'Goat', label: 'Goat'),
                                            DropdownMenuEntry(
                                                value: 'Sheep', label: 'Sheep'),
                                            DropdownMenuEntry(
                                                value: 'Buffalo', label: 'Buffalo'),
                                            DropdownMenuEntry(
                                                value: 'Camel', label: 'Camel'),
                                            DropdownMenuEntry(
                                                value: 'Yok', label: 'Yok'),


                                          ],
                                        ),
                                      ) :   Expanded(
                                        child: DropdownMenu(
                                          controller: controller.farmName,
                                          // initialSelection: '',
                                          hintText: 'Farm',
                                          width: MediaQuery.sizeOf(context).width -90,
                                          // onSelected: (value) {
                                          //   controller.changePostType(
                                          //       type: value.toString());
                                          // },
                                          menuStyle: MenuStyle(
                                              shape: MaterialStatePropertyAll(
                                                  RoundedRectangleBorder(
                                                      borderRadius:
                                                      BorderRadius.circular(10)))),
                                          inputDecorationTheme: InputDecorationTheme(
                                            contentPadding:
                                            const EdgeInsets.symmetric(horizontal: 10),
                                            constraints: const BoxConstraints(
                                              maxHeight: 45,
                                            ),
                                            border: OutlineInputBorder(
                                                borderRadius: BorderRadius.circular(10),
                                                borderSide:
                                                const BorderSide(color: Colors.black12)),
                                          ),
                                          dropdownMenuEntries: const [
                                            DropdownMenuEntry(
                                                value: 'Union', label: 'Union'),
                                            DropdownMenuEntry(
                                                value: 'Potato', label: 'Potato'),
                                            DropdownMenuEntry(
                                                value: 'Orange', label: 'Orange'),


                                          ],
                                        ),
                                      );
                                    },)
                                  ],
                                ),
                              ),
                              Consumer<PostAnimalController>(
                                builder: (context, value, child) =>
                                    value.selectedPostType == 'animals'
                                        ? const AnimalForm()
                                        : FarmForm(),
                              ),

                              Consumer<PostAnimalController>(builder: (context, value, child) => controller.selectedPostType == 'animals'
                                  ? controller.selectedAnimalImages.isNotEmpty ? SizedBox (
                                height: 120,
                                width: size.width,
                                child: ListView.builder(
                                  addAutomaticKeepAlives: true,
                                  itemCount:
                                  controller.selectedAnimalImages.length <= 4
                                      ? controller.selectedAnimalImages.length
                                      : 4,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 120,
                                      width: 120,
                                      margin: const EdgeInsets.only(left: 10,bottom: 20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                              image: FileImage(File(controller
                                                  .selectedAnimalImages[index]))),
                                      ),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () => controller.removeAnimalImage(name: controller
                                              .selectedAnimalImages[index]),
                                          child: const Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Icon(Icons.close_sharp,color: Colors.white,),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ) :const SizedBox.shrink()
                                  : controller.selectedFarmImages.isNotEmpty ?  SizedBox(
                                height: 120,
                                width: size.width,
                                child: ListView.builder(
                                  addAutomaticKeepAlives: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount:
                                  controller.selectedFarmImages.length <= 4
                                      ? controller.selectedFarmImages.length
                                      : 4,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      height: 120,
                                      width: 120,
                                      margin: const EdgeInsets.only(left: 10,bottom: 20),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                              image: FileImage(File(controller
                                                  .selectedFarmImages[index])))),
                                      child: Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () => controller.removeFarmImage(name: controller
                                              .selectedFarmImages[index]),
                                          child: const Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Icon(Icons.close_sharp,color: Colors.white,),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ) : const SizedBox.shrink(),),

                              GestureDetector(
                                onTap: () {
                                  controller.pickImage();
                                },
                                child:  Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Icon(
                                      Icons.image,
                                      color: Colors.black38,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      local.upload_images,
                                      style: const TextStyle(
                                          color: Colors.blue,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () => Provider.of<PostAnimalController>(context,
                                        listen: false)
                                    .uploadPost(
                                  context: context,
                                ),
                                child: Container(
                                  height: 50,
                                  width: MediaQuery.sizeOf(context).width,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                  alignment: Alignment.center,
                                  child: Consumer<PostAnimalController>(
                                    builder: (context, value, child) {
                                      if (value.loading) {
                                        return const SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        );
                                      }
                                      return  Text(
                                        local.upload,
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ));
      },
    );
  }
}
