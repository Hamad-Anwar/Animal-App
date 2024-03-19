import 'dart:async';

import 'package:animal/data/firebase/file_services.dart';
import 'package:animal/data/firebase/firebase_services.dart';
import 'package:animal/main.dart';
import 'package:animal/model/animal_model.dart';
import 'package:animal/utils/utils.dart';
import 'package:animal/view_model/controllers/home_page_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PostAnimalController extends ChangeNotifier {
  // animal post data
  final TextEditingController name = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final TextEditingController age = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController milk = TextEditingController();
  final TextEditingController noOfChildProduced = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController type = TextEditingController();
  final TextEditingController address = TextEditingController();
  List<String> selectedAnimalImages = [];

  // farm post data

  final TextEditingController startDate = TextEditingController();
  final TextEditingController farmName = TextEditingController();
  final TextEditingController endDate = TextEditingController();
  final TextEditingController farmPrice = TextEditingController();
  final TextEditingController acre = TextEditingController();
  final FirebaseServices firebaseServices = FirebaseServices();
  List<String> selectedFarmImages = [];
  String selectedPostType = 'animals';
  bool loading = false;


  pickStartDate({required BuildContext context}) async {
    startDate.text = await Utils.pickDate(context: context);
  }
  pickEndDate({required BuildContext context}) async {
    endDate.text = await Utils.pickDate(context: context);
  }
  pickAnimalImages() async {
    final List<String> imageList = List.from(await Utils.pickImages());
    if (imageList.isNotEmpty) {
      selectedAnimalImages = selectedAnimalImages + imageList;
      notifyListeners();
    }
  }
  pickFarmImages() async {
    final List<String> imageList = List.from(await Utils.pickImages());
    if (imageList.isNotEmpty) {
      selectedFarmImages = selectedFarmImages + imageList;
      notifyListeners();
    }
  }
  pickImage() {
    if (selectedPostType == 'animals') {
      pickAnimalImages();
    } else {
      pickFarmImages();
    }
    notifyListeners();
  }
  removeAnimalImage({required String name}) {
    selectedAnimalImages.remove(name);
    notifyListeners();
  }
  removeFarmImage({required String name}) {
    selectedFarmImages.remove(name);
    notifyListeners();
  }
  changePostType({required String type}) {
    selectedPostType = type;
    notifyListeners();
  }

  uploadPost({required BuildContext context}){
    if (selectedPostType == 'animals') {
      uploadAnimal(context: context);
    } else {
      uploadFormPost(context: context);
    }
  }


  uploadAnimal({required BuildContext context}) async {
    ToastContext().init(context);
    if (name.value.text.toString().isEmpty) {
      Toast.show('Please enter name');
      return;
    }
    if (age.value.text.toString().isEmpty) {
      Toast.show('Please enter age',);
      return;
    }
    if (price.value.text.toString().isEmpty) {
      Toast.show('Please enter price');
      return;
    }
    if (milk.value.text.toString().isEmpty) {
      Toast.show('Please enter quantity of milk');
      return;
    }
    if (noOfChildProduced.value.text.toString().isEmpty) {
      Toast.show('Please enter no of child produced');
      return;
    }
    if (address.value.text.toString().isEmpty) {
      Toast.show('Please enter location',);
      return;
    }

    if(selectedAnimalImages.isEmpty){
      Toast.show('Please upload at least one image',);
      return;
    }


    loading = true;
    notifyListeners();
    Timer(const Duration(seconds: 1), () {
      loading = false;
      notifyListeners();
      Navigator.pop(context);
      Toast.show('Your post is being uploaded\nW\'ll notify you after posting');
    });
    List<String> list = [];
    String id=DateTime.now().microsecondsSinceEpoch.toString();
    for (int i = 0; i < selectedAnimalImages.length; i++) {
      try {
        list.add((await FileServices.uploadFile(
            filePath: selectedAnimalImages[i],
            uploadPath: 'animal_${user!.location}/${user!.token.toString()}/$id/${DateTime.now().microsecondsSinceEpoch.toString()}.jpeg')));
      } catch (_) {
        if (kDebugMode) {
          print(_.toString());
        }
      }
    }
    AnimalPostModel post= AnimalPostModel(id: id,
        images: list,
        name: name.value.text.toString(),
        address: address.value.text.toString(),
        age: age.value.text.toString(),
        description: description.value.text.toString(),
        milkInKg: milk.value.text.toString(),
        noOfChildProduced: noOfChildProduced.value.text.toString(),
        price: price.value.text.toString(),
        owner: Owner(name: user!.name.toString(), date: Utils.formatDate(DateTime.now()), id: user!.token.toString(), contact: user!.phoneNumber!));
    try {
      await firebaseServices.addPost(post: post, type: 'animal');
      ToastContext().init(currentContext!);
      Toast.show('Your post is uploaded');
      Provider.of<HomePageController>(currentContext!,listen: false).insertData(context: currentContext!, model: post, type: 'animals');
    } catch (_) {
    }
  }
  uploadFormPost({required BuildContext context}){
    Utils.showErrorDialog(context: context, error: 'Not Implemented yet');
  }





}
