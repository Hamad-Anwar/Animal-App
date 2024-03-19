import 'package:animal/data/firebase/firebase_services.dart';
import 'package:animal/main.dart';
import 'package:animal/utils/emun_filters.dart';
import 'package:flutter/material.dart';

import '../../model/animal_model.dart';
enum Status{
 loading,complete,error
}
class HomePageController extends ChangeNotifier{
  List<AnimalPostModel> animalPostList=[];
  List<AnimalPostModel> farmPostList=[];
  Status farmPostStatus=Status.complete;
  Status postStatus=Status.loading;
  final PageController pageController=PageController();
  final ScrollController postScrollController=ScrollController();
  int currentPage=0;
  int currentIndexAnimalPost=0;
  int currentIndexAnimalPostTemp=0;
  PostFilters filter=PostFilters.nearby;




  changePage({required int page}){
    changePageIndex(page: page);
    pageController.animateToPage(page, duration: const Duration(milliseconds: 100), curve: Curves.ease);
  }
  changePageIndex({required int page}){
    currentPage=page;
    notifyListeners();
  }
  getData({required String location}) async {
    // farmPostStatus=Status.loading;
    // postStatus=Status.loading;
    // notifyListeners();
    // FirebaseServices().getFarms().then((list){
    //   farmPostList.addAll(list);
    //   farmPostStatus=Status.complete;
    //   notifyListeners();
    // }).onError((error, stackTrace){
    //   farmPostStatus=Status.error;
    //   notifyListeners();
    // });
    FirebaseServices().getAnimals(filter: filter,location: location).then((list){
      if(filter==PostFilters.all){
        animalPostList=List.from(list);
      }else{
        animalPostList.addAll(list);
      }
      postStatus=Status.complete;
      notifyListeners();
      if(currentIndexAnimalPost==0){
        postScrollController.addListener(() {
          double maxScroll = postScrollController.position.maxScrollExtent;
          double currentScroll = postScrollController.position.pixels;
          double delta = 100.0;
          if (maxScroll - currentScroll <= delta &&
              !postScrollController.position.outOfRange) {
            if(filter==PostFilters.nearby){
              if(currentIndexAnimalPost==currentIndexAnimalPostTemp){
                getData(location: user!.nearestLocations[currentIndexAnimalPost]);
              }
            }
          }
        });
      }
      if(filter==PostFilters.nearby && currentIndexAnimalPost<user!.nearestLocations.length -1){
        currentIndexAnimalPost++;
      }
      currentIndexAnimalPostTemp++;
    }).onError((error, stackTrace){
      postStatus=Status.error;
      notifyListeners();
    });

  }

  void insertData({required BuildContext context, required AnimalPostModel model, required String type}) {
    if (type == 'animals') {
      animalPostList.insert(0, model);
    } else {
      farmPostList.insert(0, model);
    }
    notifyListeners();
  }

  changeFilter({required PostFilters postFilter}){
    animalPostList.clear();
    filter=postFilter;
    postStatus=Status.loading;
    currentIndexAnimalPost=0;
    notifyListeners();
  }
}