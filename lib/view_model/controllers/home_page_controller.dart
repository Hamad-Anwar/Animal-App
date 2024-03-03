import 'package:animal/data/firebase/firebase_services.dart';
import 'package:flutter/material.dart';

import '../../model/animal_model.dart';

class HomePageController extends ChangeNotifier{
  List<AnimalModel> postList=[];
  bool loading=false;
  getData() async {
    loading=true;
    await FirebaseServices().getAnimals().then((list){
      postList=List.from(list);
      loading=false;
      notifyListeners();
    }).onError((error, stackTrace){
      loading=false;
      notifyListeners();
    });

  }
  insetData({required BuildContext context,required AnimalModel model}){
    postList.add(model);
    notifyListeners();
  }
}