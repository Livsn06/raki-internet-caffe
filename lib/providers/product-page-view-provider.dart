import 'package:flutter/material.dart';

class ProductPageViewProvider extends ChangeNotifier {
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  int get currentIndex => _currentIndex;
  PageController get pageController => _pageController;

  void updateIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  // Logic to handle taps (jumping to a page)
  void jumpToPage(int index) {
    _currentIndex = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
