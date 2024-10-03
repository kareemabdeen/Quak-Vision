import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomAppBar extends StatefulWidget {
  final PageController pageController;
  final bool isNasaLogoVisible;

  const CustomAppBar({
    super.key,
    required this.pageController,
    this.isNasaLogoVisible = false,
  });

  @override
  CustomAppBarState createState() => CustomAppBarState();
}

class CustomAppBarState extends State<CustomAppBar> {
  int _selectedIndex = 0; // Track the selected index

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
    widget.pageController.animateToPage(
      index,
      duration: const Duration(
        milliseconds: 500,
      ),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Nasa Logo
          widget.isNasaLogoVisible
              ? Positioned(
                  left: 16,
                  top: 10,
                  child: Lottie.asset(
                    'assets/nasa_logo.json',
                    repeat: true,
                    reverse: true,
                    height: 50,
                    width: 50,
                  ),
                )
              : const SizedBox(),
          const Spacer(),
          Row(
            children: List.generate(4, (index) {
              String title;
              switch (index) {
                case 0:
                  title = 'Home';
                  break;
                case 1:
                  title = 'Explore';
                  break;
                case 2:
                  title = 'About';
                  break;
                case 3:
                  title = 'Contact';
                  break;
                default:
                  title = '';
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: TextButton(
                  onPressed: () => _onItemTapped(index),
                  style: TextButton.styleFrom(
                      backgroundColor: _selectedIndex == index
                          ? const Color.fromARGB(255, 115, 14, 14).withOpacity(
                              0.9,
                            ) // Highlight color
                          : Colors.transparent, // Default color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          5,
                        ),
                      )),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
