import 'package:flutter/material.dart';
import 'package:my_todo_app/data/constants.dart';
import 'package:my_todo_app/data/controllers.dart';
import 'package:my_todo_app/data/notifiers.dart';

class NavbarWidget extends StatelessWidget {
  const NavbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectedPage,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.lightBlueAccent.withValues(alpha: 0.1),
                blurRadius: 4,
                spreadRadius: 1,
                offset: Offset(0, -1),
              ),
            ],
          ),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              focusColor: Colors.transparent,
            ),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: BottomNavigationBar(
                backgroundColor: Colors.white,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: [
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Image.asset(
                        'assets/images/home_inactive.png',
                        height: MediaQuery.of(context).size.height * 0.04,
                        color: Constants.primaryTransparent,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(
                        right: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Image.asset(
                        'assets/images/home_active.png',
                        height: MediaQuery.of(context).size.height * 0.04,
                        color: Constants.primaryColor,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                    ),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Image.asset(
                        'assets/images/profile_inactive.png',
                        height: MediaQuery.of(context).size.height * 0.04,
                        color: Constants.primaryTransparent,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                    ),
                    activeIcon: Padding(
                      padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.height * 0.05,
                      ),
                      child: Image.asset(
                        'assets/images/profile_active.png',
                        height: MediaQuery.of(context).size.height * 0.04,
                        color: Constants.primaryColor,
                        colorBlendMode: BlendMode.srcIn,
                      ),
                    ),
                    label: '',
                  ),
                ],
                currentIndex: selectedPage.value,
                // matiin animasi sebelumnya
                onTap: (index) {
                  selectedPage.value = index;
                  Controllers.pageController
                      .jumpToPage(index);
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
