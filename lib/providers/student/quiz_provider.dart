import 'package:flutter/material.dart';

class QuizProvider extends ChangeNotifier {
  late TabController tabController;

  List questions = [];

  QuizProvider(TickerProvider tickerProvider) {
    init(tickerProvider);
  }

  init(ticker) {
    tabController = TabController(length: 30, vsync: ticker);
    questions = List.generate(30, (index) {
      return {
        'id': index,
      };
    });
    notifyListeners();
  }

  void goToPrev() {
    if (tabController.index == 0) return;
    animateTo(tabController.index - 1);
  }

  void goToNext() {
    if (tabController.index == tabController.length - 1) return;
    animateTo(tabController.index + 1);
  }

  void animateTo(index) {
    tabController.animateTo(index);
    notifyListeners();
  }
}
