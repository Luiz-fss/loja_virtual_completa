import 'package:flutter/cupertino.dart';

class PageManager {
  PageManager(this._pageController);

  PageController _pageController;

  int page =0;

  void setPage(int value){
    if(page != value){
      _pageController.jumpToPage(value);
      page = value;
    }

  }
}