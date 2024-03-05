import 'package:animal/data/firebase/firebase_services.dart';
import 'package:animal/model/animal_model.dart';
import 'package:animal/view_model/controllers/home_page_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class PostAnimalController extends ChangeNotifier {
  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController location = TextEditingController();
  final TextEditingController type = TextEditingController();
  final FirebaseServices firebaseServices=FirebaseServices();
  String selectedPostType='animals';
  bool loading=false;


  changePostType({required String type}){
    selectedPostType=type;
    notifyListeners();
  }
  uploadPost({required BuildContext context}) {
    ToastContext().init(context);
    if (name.value.text.toString().isEmpty) {
      Toast.show('Please enter name');
      return;
    }
    if (price.value.text.toString().isEmpty) {
      Toast.show('Please enter price');
      return;
    }
    if (location.value.text.toString().isEmpty) {
      Toast.show('Please enter location');
      return;
    }
    loading=true;
    notifyListeners();
    PostModel post = PostModel(
        name: name.value.text.toString(),
        owner:
            Owner(name: 'Pankaj More', date: '11-Feb-2024', id: 'pankaj4410'),
        distance: '0 km',
        images: type.value.text.toString().toLowerCase()=='animals'? [
          'https://firebasestorage.googleapis.com/v0/b/animal-dd877.appspot.com/o/cow%2Fimg3.png?alt=media&token=a2767a6e-fcc2-408a-9dcb-753bb45d02ef',
          'https://firebasestorage.googleapis.com/v0/b/animal-dd877.appspot.com/o/cow%2Fimg2.png?alt=media&token=a169a48d-7b36-4f25-923b-7bf92baabdce',
          'https://firebasestorage.googleapis.com/v0/b/animal-dd877.appspot.com/o/cow%2Fimg1.png?alt=media&token=a5910e1d-63df-4c1f-8579-41af61dcc950'
        ] : [
          'https://firebasestorage.googleapis.com/v0/b/animal-dd877.appspot.com/o/0_rtwJ4Yq-Fce88wU2.png?alt=media&token=a578c7b7-23ec-4df8-b767-68c4c7c4e8ed',
          'https://firebasestorage.googleapis.com/v0/b/animal-dd877.appspot.com/o/img1.webp?alt=media&token=a7e0df71-110b-456d-a1f6-0e786aa3e69b',
          'https://firebasestorage.googleapis.com/v0/b/animal-dd877.appspot.com/o/images.jpg?alt=media&token=860bf123-7b15-40d1-92dc-27c24eb1f216'
        ],
        location: location.value.text.toString(),
        price: price.value.text.toString());
    firebaseServices.addPost(post: post,type: type.value.text.toString().toLowerCase()).then((value) {
      loading=false;notifyListeners();
      Toast.show('Post is successfully uploaded');
      Provider.of<HomePageController>(context,listen: false).insetData(context: context, model: post,type:type.value.text.toString().toLowerCase());
      Navigator.pop(context);
      name.clear();
      price.clear();
      location.clear();

    }).onError((error, stackTrace) {
      Toast.show('Something went wrong please try again');
      loading=false;notifyListeners();
    });
  }
}
