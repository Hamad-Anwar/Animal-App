import 'package:flutter/material.dart';

class PostImageIndicatorController extends ChangeNotifier{
  List<int> currentPosition=[];
  insertItem({required numberOfItems}){
    currentPosition=List.generate(numberOfItems, (index) => 0);
  }

  scrollImage({required int index,required int position}){
    currentPosition[index]=position;
    notifyListeners();
  }


}