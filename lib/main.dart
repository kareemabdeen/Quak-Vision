import 'package:example/about_screen.dart';
import 'package:example/contact_screen.dart';
import 'package:example/custom_app_bar.dart';
import 'package:example/explore_page.dart';
import 'package:example/onboarding_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'QuakeVision',
    theme: ThemeData.dark().copyWith(primaryColor: Colors.blue),
    debugShowCheckedModeBanner: false,
    home: const WebLikeScrollNavigation(),
  ));
}

class WebLikeScrollNavigation extends StatefulWidget {
  const WebLikeScrollNavigation({super.key});

  @override
  WebLikeScrollNavigationState createState() => WebLikeScrollNavigationState();
}

class WebLikeScrollNavigationState extends State<WebLikeScrollNavigation> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        resizeToAvoidBottomInset: true,
        appBar: PreferredSize(
          preferredSize: const Size(
            double.infinity,
            50,
          ),
          child: CustomAppBar(
            pageController: _pageController,
            // isNasaLogoVisible: true,
          ),
        ),
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          children: const [
            OnBoardingPage(),
            ExplorePage(),
            AboutScreen(),
            ContactPage(),
          ],
        ),
      ),
    );
  }
}
