import 'package:flutter/material.dart';

class ReelPageController extends ChangeNotifier{
  final PageController pageController=PageController();
  final PageController reelScrollControll=PageController();
  bool isVideoPlaying=true;
  int currentPage=0;
  changePage({required int page}){
    currentPage=page;
    notifyListeners();
    pageController.animateToPage(page, duration: Duration(milliseconds: 100), curve: Curves.ease);
  }
  setPlay({required bool isPlaying}){
    isVideoPlaying=isPlaying;
    notifyListeners();
  }
}