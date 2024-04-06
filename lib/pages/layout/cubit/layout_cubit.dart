import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());

  int currentPage = 0;
  late PageController pageController; // for tabs animation
  late ScrollController scrollController;

  void init() {
    pageController = PageController();
    scrollController = ScrollController();
  }

  void onItemTapped(int index) {
    currentPage = index;
    emit(IndexChangeState());
  }

  void onPageChanged(int page) {
    currentPage = page;
    emit(IndexChangeState());
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }
}
