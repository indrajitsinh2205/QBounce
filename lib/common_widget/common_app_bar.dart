import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/screens/how_to_cast_screen_view/how_to_cast_screen.dart';
import 'package:q_bounce/screens/your_stats_screen_view/your_stats_screen.dart';
import '../constant/app_color.dart';
import '../constant/app_images.dart';
import '../constant/app_strings.dart';
import '../constant/app_text_style.dart';
import '../screens/contact_us_screen_view/contact_us_screen.dart';
import '../screens/faq_screen_view/faq_screen.dart';
import '../screens/home_screen_view/home_screen.dart';
import '../screens/how_to_use_screen_view/how_to_use_screen.dart';
import '../screens/privacy_policy_screen_view/privacy_policy_screen.dart';
import '../screens/state_screen_view/statistics_edit_bloc/statistics_edit_bloc.dart';
import '../screens/state_screen_view/statistics_store_bloc/statistics_store_bloc.dart';
import '../screens/state_screen_view/statistics_update_bloc/statistics_update_bloc.dart';
import '../screens/statistics_edit_view/statistics_edit_screen.dart';
import '../screens/terms_and_conditons_screen_view/terms_and_conditons_screen.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget actions;

  CommonAppBar({
    required this.title,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      title: actions,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          Scaffold.of(context).openDrawer(); // Open the drawer when the menu icon is tapped
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  Widget _selectedScreen = HomeScreen(); // Default screen
  int _selectedIndex = 0;

  // Method to update the selected screen based on BottomNavigationBar item tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        _selectedScreen = HomeScreen();
      } else if (index == 1) {
        _selectedScreen = MultiBlocProvider(
            providers: [
              BlocProvider<StatisticsEditBloc>(
                create: (BuildContext context) => StatisticsEditBloc(),
              ),
              BlocProvider<StatisticsUpdateBloc>(
                create: (BuildContext context) => StatisticsUpdateBloc(),
              ),
              BlocProvider<StatisticsStoreBloc>(
                create: (BuildContext context) => StatisticsStoreBloc(),
              ),
            ],
            child: StatisticsEditScreen(Id: 0,));
      } else if (index == 2) {
        _selectedScreen = ProfileScreen();
      }
      else if (index == 3) {
        _selectedScreen = YourStatsScreen();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppImages.background(AppImages.appBackGround),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppBar(
          title: '',
          actions: AppImages.image(AppImages.logo, height: 40),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('How To Use'),
                onTap: () {
                  setState(() {
                    _selectedScreen = HowToUseScreen();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.question_answer),
                title: Text('FAQ'),
                onTap: () {
                  setState(() {
                    _selectedScreen = FAQPage();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.privacy_tip),
                title: Text('Privacy'),
                onTap: () {
                  setState(() {
                    _selectedScreen = PrivacyPolicyScreen();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.terminal_sharp),
                title: Text('Terms & Conditions'),
                onTap: () {
                  setState(() {
                    _selectedScreen = TermsAndConditonsScreen();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.cast),
                title: Text('How To Cast'),
                onTap: () {
                  setState(() {
                    _selectedScreen = HowToCastScreen();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
              ListTile(
                leading: Icon(Icons.contact_page),
                title: Text('Contact Us'),
                onTap: () {
                  setState(() {
                    _selectedScreen = ContactUsScreen();
                  });
                  Navigator.pop(context); // Close drawer
                },
              ),
            ],
          ),
        ),
        body: _selectedScreen,
        // BottomNavigationBar for screen switching
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 15,left: 15,right: 15),
          decoration: BoxDecoration(
            // color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(14),
            boxShadow: [
              BoxShadow(
                color:AppColors.bShadow.withOpacity(0.6),
                spreadRadius: 0,
                blurRadius: 100,
                offset: Offset(0, 26)
              )
            ]
          ),
          child: BottomNavigationBar(

            backgroundColor: AppColors.whiteColor,
            selectedItemColor: AppColors.appColor,

            currentIndex: _selectedIndex,
            onTap: _onItemTapped,  // Update selected screen based on tapped index
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart),
                label: 'stats',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}




class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Profile Screen", style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)),
    );
  }
}
