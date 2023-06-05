import 'package:flutter/material.dart';
import 'package:news_app/src/screens/tab1_screen.dart';
import 'package:news_app/src/screens/tab2_screen.dart';
import 'package:news_app/src/services/news_service.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {
  const TabsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) {
        return _NavigationModel();
      },
      child: const Scaffold(
        body: _Pages(),
        bottomNavigationBar: _BottomNavigationBar(),
      ),
    );
  }
}

class _BottomNavigationBar extends StatelessWidget {
  const _BottomNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navigationModel = Provider.of<_NavigationModel>(context);
    return BottomNavigationBar(
        currentIndex: navigationModel.currentScreen,
        onTap: (value) => navigationModel.currentScreen = value,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.person_2_outlined), label: 'For you'),
          BottomNavigationBarItem(icon: Icon(Icons.public), label: 'Headers')
        ]);
  }
}
class _Pages extends StatelessWidget {
  const _Pages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final navegacionModel = Provider.of<_NavigationModel>(context);
    return PageView(
      controller: navegacionModel.pageController,
      // physics: const BouncingScrollPhysics(),
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        Tab1Screen(),       
        Tab2Screen(),       
      ],
    );
  }
}

class _NavigationModel with ChangeNotifier {
  int _currentScreen = 0;
  PageController _pageController = PageController();
  int get currentScreen => _currentScreen;
  set currentScreen(int value) {
    _currentScreen = value;
    _pageController.animateToPage(value, duration: const Duration(milliseconds: 250), curve: Curves.bounceInOut);
    notifyListeners();
  }
  PageController get pageController => _pageController;
}
