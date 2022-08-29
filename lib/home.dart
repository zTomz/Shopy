import 'package:flutter/material.dart';
import 'package:shopy/pages/home_page.dart';
import 'package:shopy/pages/online_page.dart';
import 'package:shopy/pages/settings_page.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPage = 0;
  // 0 = Home, 1 = Online, 2 = Settings

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage,
        onDestinationSelected: (newPage) {
          setState(() {
            currentPage = newPage;
          });
        },
        animationDuration: const Duration(seconds: 1),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_rounded),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.group_rounded),
            label: "Online",
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_rounded),
            label: "Settings",
          ),
        ],
      ),
      body: getCurrentPage(),
    );
  }

  Widget getCurrentPage() {
    if (currentPage == 0) {
      return const HomePage();
    }
    if (currentPage == 1) {
      return const OnlinePage();
    }
    return const SettingsPage();
  }
}
