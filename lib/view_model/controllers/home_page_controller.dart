import 'package:animal/data/firebase/firebase_services.dart';
import 'package:flutter/material.dart';

import '../../model/animal_model.dart';
enum Status{
 loading,complete,error
}
class HomePageController extends ChangeNotifier{
  List<PostModel> animalPostList=[];
  List<PostModel> farmPostList=[];
  Status farmPostStatus=Status.loading;
  Status postStatus=Status.loading;
  final PageController pageController=PageController();
  int currentPage=0;

  changePage({required int page}){
    currentPage=page;
    notifyListeners();
    pageController.animateToPage(page, duration: Duration(milliseconds: 100), curve: Curves.ease);
  }
  getData() async {
    farmPostStatus=Status.loading;
    notifyListeners();
    FirebaseServices().getFarms().then((list){
      farmPostList=List.from(list);
      farmPostStatus=Status.complete;
      notifyListeners();
    }).onError((error, stackTrace){
      farmPostStatus=Status.error;
      notifyListeners();
    });
    FirebaseServices().getAnimals().then((list){
      animalPostList=List.from(list);
      postStatus=Status.complete;
      notifyListeners();
    }).onError((error, stackTrace){
      postStatus=Status.error;
      notifyListeners();
    });

  }
  insetData({required BuildContext context,required PostModel model,required String type}){
    if(type=='animals'){
      animalPostList.add(model);
    }else{
      farmPostList.add(model);
    }
    notifyListeners();
  }
}