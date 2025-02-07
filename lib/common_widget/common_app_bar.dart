import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:q_bounce/app_services/navigation_service.dart';
import 'package:q_bounce/common_widget/common_alert.dart';
import 'package:q_bounce/common_widget/common_button.dart';
import 'package:q_bounce/common_widget/web_view.dart';
import 'package:q_bounce/screens/how_to_cast_screen_view/how_to_cast_screen.dart';
import 'package:q_bounce/screens/static_leader_board.dart';
import 'package:q_bounce/screens/your_stats_screen_view/your_stats_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../app_services/common_Capital.dart';
import '../constant/app_color.dart';
import '../constant/app_images.dart';
import '../constant/app_strings.dart';
import '../constant/app_text_style.dart';
import '../screens/contact_us_screen_view/contact_us_screen.dart';
import '../screens/faq_screen_view/faq_screen.dart';
import '../screens/home_screen_view/home_screen.dart';
import '../screens/how_to_use_screen_view/how_to_use_screen.dart';
import '../screens/privacy_policy_screen_view/privacy_policy_screen.dart';
import '../screens/profile_screen_view/profile_screen.dart';
import '../screens/state_screen_view/statistics_edit_bloc/statistics_edit_bloc.dart';
import '../screens/state_screen_view/statistics_store_bloc/statistics_store_bloc.dart';
import '../screens/state_screen_view/statistics_update_bloc/statistics_update_bloc.dart';
import '../screens/statistics_edit_view/statistics_edit_screen.dart';
import '../screens/terms_and_conditons_screen_view/terms_and_conditons_screen.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final Widget actions;
  final bool? button;
  final bool? saveButton;
  final VoidCallback voidCallback1;
  final VoidCallback voidCallback2;

  CommonAppBar({
    required this.title,
    required this.actions,
    this.button = false,
    required this.voidCallback1,
    required this.voidCallback2,
    this.saveButton,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: AppBar(
        backgroundColor: Colors.transparent,
        titleSpacing: 5, // Reduced spacing between leading and title
        title: actions,
        leading: InkWell(
          onTap: () {
            Scaffold.of(context).openDrawer();
          },
          child: Container(
            margin: EdgeInsets.only(top: 10, bottom: 10),
            height: 25,
            width: 25,
            child: AppImages.image(AppImages.drawerIcon),
          ),
        ),
        actions: [
          button == false
              ? saveButton == true ?InkWell(
          onTap: () {
    voidCallback2();
    },
      child: Container(
        width: 81,
        height: 38,
        child: CommonButton(
          title: "Save",
          color: AppColors.appColor,
          horizontal: 5,
          font: 10,
          vertical: 2,
        ),
      ),
    ):SizedBox()
              : InkWell(
            onTap: () {
              voidCallback1();
            },
            child: Container(
              width: 81,
              height: 38,
              child: CommonButton(
                title: "+ Add Match",
                color: AppColors.appColor,
                horizontal: 5,
                font: 10,
                vertical: 2,
              ),
            ),
          ),
        ],
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
 // static  int _selectedIndex = 0;
// static  int button = 0;


  // Method to update the selected screen based on BottomNavigationBar item tapped
  void _onItemTapped(int index) {
    setState(() {
      // This ensures that when tapping the same index, the widget gets rebuilt
      if (GlobleValue.selectedIndex == index) {
        // Change _selectedScreen to a new instance of the same screen.
        if (index == 0) {
          setState(() {
            GlobleValue.button =0;
          });
          _selectedScreen = HomeScreen(key: UniqueKey());  // Assign a new key to force rebuild
        } else if (index == 1) {
          setState(() {
            GlobleValue.button =1;
          });
          _selectedScreen = YourStatsScreen(key: UniqueKey());
        } else if (index == 2) {
          setState(() {
            GlobleValue.button =0;
          });
          _selectedScreen = CartScreen(key: UniqueKey());
        } else if (index == 3) {
          setState(() {
            GlobleValue.button =0;
          });
          _selectedScreen = StaticLeaderBoard(key: UniqueKey());
        }
      } else {
        // If the index has changed, assign the new screen
        GlobleValue.selectedIndex = index;
        if (index == 0) {
          setState(() {
            GlobleValue.button =0;
          });
          _selectedScreen = HomeScreen();
        } else if (index == 1) {
          setState(() {
            GlobleValue.button =1;
          });
          _selectedScreen = YourStatsScreen();
        } else if (index == 2) {
          setState(() {
            GlobleValue.button =0;
          });
          _selectedScreen = CartScreen();
        } else if (index == 3) {
          setState(() {
            GlobleValue.button =0;
          });
          _selectedScreen = StaticLeaderBoard();
        }
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
          voidCallback1: () {
            print("0.");
            setState(() {
              GlobleValue.selectedIndex=1;
              GlobleValue.button=0;
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
                child: StatisticsEditScreen(Id: 0),
              );
            });
          },
          button: GlobleValue.button==1?true:false,
          saveButton: GlobleValue.button == 2?true:false,
          title: '',
          actions: AppImages.image(AppImages.logo, height: 30),
          voidCallback2: () {
            setState(() {
              GlobleValue.selectedIndex=0;
              GlobleValue.button=0;
              _selectedScreen = HomeScreen();
            });
          },
        ),
        drawer: Drawer(
          child: Container(
            padding: EdgeInsets.only(left: 23,right: 27),
            decoration: AppImages.background(AppImages.drawerBG),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: <Widget>[

                      InkWell(
                        onTap: () {
                          setState(() {
                            GlobleValue.button=2;
                            _selectedScreen = ProfileScreen();
                          });
                          Navigator.pop(context); // Close drawer
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 110),
                          padding: EdgeInsets.symmetric(horizontal: 11.65,vertical: 10),
                          decoration: BoxDecoration(
                            color: Color(0xFF414141),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.faq.withAlpha(3),
                              )
                            ]
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: AppColors.whiteColor,width: 0.2),),
                                child: AppImages.image(AppImages.playerB,height: 40,width: 40),
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Michael Johnson",style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),),
                                    Text(overflow: TextOverflow.ellipsis,"MichaelJohnson@gmail.com",style: AppTextStyles.getOpenSansGoogleFont(11, AppColors.whiteColor, false),)
                                  ],
                                ),
                              ),
                              SizedBox(width: 10,),
                              AppImages.image(AppImages.drawerEdit,height: 20,width: 20)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50,),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColors.drawerTile
                        ),
                        child: ListTile(
                          trailing: Icon(Icons.chevron_right_rounded,size: 16,color: AppColors.whiteColor,),
                          leading:AppImages.image(AppImages.howToUse,height: 20,width: 20),
                          title: Text('How To Use',style: AppTextStyles.getOpenSansGoogleFont(14  , AppColors.whiteColor  , false),),
                          onTap: () {
                            setState(() {
                              _selectedScreen = HowToUseScreen();
                              GlobleValue.button=0;
                            });
                            Navigator.pop(context); // Close drawer
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.drawerTile
                        ),
                        child: ListTile(
                          trailing: Icon(Icons.chevron_right_rounded,size: 16,color: AppColors.whiteColor,),

                          leading: AppImages.image(AppImages.cast,height: 20,width: 20),
                          title: Text('How To Cast',style: AppTextStyles.getOpenSansGoogleFont(14 , AppColors.whiteColor  , false),),
                          onTap: () {
                            setState(() {
                              GlobleValue.button=0;                              _selectedScreen = HowToCastScreen();

                            });
                            Navigator.pop(context); // Close drawer
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.drawerTile
                        ),
                        child: ListTile(
                          trailing: Icon(Icons.chevron_right_rounded,size: 16,color: AppColors.whiteColor,),

                          leading: AppImages.image(AppImages.terms,height: 20,width: 20),
                          title: Text('Teams & Conditions',style: AppTextStyles.getOpenSansGoogleFont(14  , AppColors.whiteColor  , false),),
                          onTap: () {
                            setState(() {
                              GlobleValue.button=0;
                              _selectedScreen = TermsAndConditonsScreen();
                            });
                            Navigator.pop(context); // Close drawer
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.drawerTile
                        ),
                        child: ListTile(
                          trailing: Icon(Icons.chevron_right_rounded,size: 16,color: AppColors.whiteColor,),

                          leading: AppImages.image(AppImages.privacy,height: 20,width: 20),
                          title: Text('privacy policy',style: AppTextStyles.getOpenSansGoogleFont(14  , AppColors.whiteColor  , false),),
                          onTap: () {
                            setState(() {
                              _selectedScreen = PrivacyPolicyScreen();
                              GlobleValue.button=0;
                            });
                            Navigator.pop(context); // Close drawer
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.drawerTile
                        ),
                        child: ListTile(
                          trailing: Icon(Icons.chevron_right_rounded,size: 16,color: AppColors.whiteColor,),

                          leading: AppImages.image(AppImages.faq,height: 20,width: 20),
                          title: Text('Faq',style: AppTextStyles.getOpenSansGoogleFont(14 , AppColors.whiteColor  , false),),
                          onTap: () {
                            setState(() {
                              _selectedScreen = FAQPage();
                              GlobleValue.button=0;
                            });
                            Navigator.pop(context); // Close drawer
                          },
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.drawerTile
                        ),
                        child: ListTile(
                          trailing: Icon(Icons.chevron_right_rounded,size: 16,color: AppColors.whiteColor,),

                          leading: AppImages.image(AppImages.contact,height: 20,width: 20),
                          title: Text('Contact Us',style: AppTextStyles.getOpenSansGoogleFont(14  , AppColors.whiteColor  , false),),
                          onTap: () {
                            setState(() {
                              _selectedScreen = ContactUsScreen();
                              GlobleValue.button=0;
                            });
                            Navigator.pop(context); // Close drawer
                          },
                        ),
                      ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: AppColors.drawerTile
                  ),
                  child: ListTile(
                    leading:AppImages.image(AppImages.signOut,height: 30,width: 30),
                    title: Text('Sign Out',style: AppTextStyles.athleticStyle(fontSize: 16  , color: AppColors.whiteColor.withOpacity(0.5),fontFamily: AppTextStyles.sfPro700),),
                    onTap: () {
                        CommonAlert.showAlertDialog(context,"SignOut","You want to signOut",() {
                          NavigationService.navigateTo(NavigationService.signIn);
                        },);
                      // Navigator.pop(context); // Close drawer
                    },
                  ),
                ),
                SizedBox(height: 50,),
              ],
            ),
          ),
        ),

        body: _selectedScreen,
        // BottomNavigationBar for screen switching
        bottomNavigationBar: Container(
          margin: EdgeInsets.only(bottom: 15,left: 15,right: 15),
          decoration: BoxDecoration(
            color: AppColors.bNavBar,
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
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
              bottomLeft: Radius.circular(14),
              bottomRight: Radius.circular(14),
            ),
            child: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: BottomNavigationBar(
                backgroundColor: AppColors.bNavBar,
                selectedItemColor: AppColors.appColor,
                unselectedItemColor: AppColors.unSelectedNav,
                type: BottomNavigationBarType.fixed,
                elevation: 0.0,
                currentIndex: GlobleValue.selectedIndex,
                onTap: _onItemTapped,  // Update selected screen based on tapped index
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Center(
                      child: ImageIcon(AssetImage(AppImages.home), size: 24),
                    ),
                    label: '', // Keep this empty to remove labels
                  ),
                  BottomNavigationBarItem(
                    icon: Center(
                      child: ImageIcon(AssetImage(AppImages.state), size: 24),
                    ),
                    label: '', // Keep this empty to remove labels
                  ),
                  BottomNavigationBarItem(
                    icon: Center(
                      child: ImageIcon(AssetImage(AppImages.cart), size: 24),
                    ),
                    label: '', // Keep this empty to remove labels
                  ),
                  BottomNavigationBarItem(
                    icon: Center(
                      child: ImageIcon(AssetImage(AppImages.leader), size: 24),
                    ),
                    label: '', // Keep this empty to remove labels
                  ),
                ],
              )

            ),
          ),
        ),
      ),
    );
  }
}




class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        color: Colors.transparent,
        child: Expanded(
          child: Stack(
            children: [
              FlutterFlowWebView(
                content: "https://qbouncepro.com/",
                verticalScroll: true,
                horizontalScroll: false,
                onPageStarted: (url) {
                  setState(() {
                    isLoading = true;
                  });
                },
                onPageFinished: (url) {
                    setState(() {
                      isLoading = false;
                  });
                },
              ),
              if (isLoading)
                Container(
                  color: Colors.transparent,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: AppColors.appColor,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
  }
}












