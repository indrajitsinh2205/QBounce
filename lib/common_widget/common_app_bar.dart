import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:q_bounce/app_services/app_preferences.dart';
import 'package:q_bounce/app_services/navigation_service.dart';
import 'package:q_bounce/common_widget/common_alert.dart';
import 'package:q_bounce/common_widget/common_button.dart';
import 'package:q_bounce/common_widget/web_view.dart';
import 'package:q_bounce/screens/how_to_cast_screen_view/how_to_cast_screen.dart';
import 'package:q_bounce/screens/profile_screen_view/update_profile_bloc/update_profile_bloc.dart';
import 'package:q_bounce/screens/static_leader_board.dart';
import 'package:q_bounce/screens/your_stats_screen_view/your_stats_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../app_services/common_Capital.dart';
import '../app_services/global_image_manager.dart';
import '../constant/app_color.dart';
import '../constant/app_images.dart';
import '../constant/app_strings.dart';
import '../constant/app_text_style.dart';
import '../screens/contact_us_screen_view/contact_us_bloc/contact_us_bloc.dart';
import '../screens/contact_us_screen_view/contact_us_screen.dart';
import '../screens/faq_screen_view/faq_screen.dart';
import '../screens/home_screen_view/home_screen.dart';
import '../screens/home_screen_view/user_details_bloc/user_details_bloc.dart';
import '../screens/home_screen_view/user_details_bloc/user_details_event.dart';
import '../screens/how_to_use_screen_view/how_to_use_screen.dart';
import '../screens/leaderboard_screen_view/leaderboard_bloc/leader_board_bloc.dart';
import '../screens/privacy_policy_screen_view/privacy_policy_screen.dart';
import '../screens/profile_screen_view/get_profile_bloc/get_profile_bloc.dart';
import '../screens/profile_screen_view/get_profile_bloc/get_profile_event.dart';
import '../screens/profile_screen_view/profile_screen.dart';
import '../screens/profile_screen_view/profile_singleton.dart';
import '../screens/state_screen_view/statistics_bloc/statistics_bloc.dart';
import '../screens/state_screen_view/statistics_delete_bloc/statistics_delete_bloc.dart';
import '../screens/state_screen_view/statistics_edit_bloc/statistics_edit_bloc.dart';
import '../screens/state_screen_view/statistics_store_bloc/statistics_store_bloc.dart';
import '../screens/state_screen_view/statistics_update_bloc/statistics_update_bloc.dart';
import '../screens/statistics_edit_view/statistics_edit_screen.dart';
import '../screens/terms_and_conditons_screen_view/terms_and_conditons_screen.dart';
import '../screens/training_screen_view/training_program_bloc/training_program_bloc.dart';
import '../screens/training_screen_view/training_program_bloc/training_program_event.dart';

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
        titleSpacing: 0, // Remove spacing between leading and title
        // title: actions,
        leadingWidth: MediaQuery.of(context).size.width/2,
        leading: Row(
          children: [
            InkWell(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10,right: 10),
                height: 36,
                width: 36,
                child: AppImages.image(AppImages.drawerIcon),
              ),
            ),
            actions
          ],
        ),
        actions: [
          ValueListenableBuilder<int>(
            valueListenable: GlobleValue.button,
            builder: (context, isSaveEnabled, child) {
              return isSaveEnabled==1? InkWell(
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
              ):Container();
            },
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
  void _onItemTapped(int index) {
    setState(() {
      if (GlobleValue.selectedIndex.value == index) {
        if (index == 0) {
          setState(() {
            GlobleValue.button.value =0;
          });
          GlobleValue.selectedScreen.value = MultiBlocProvider(
              providers: [
                BlocProvider<LeaderBoardBloc>(
                  create: (context) => LeaderBoardBloc(),
                ),
                BlocProvider<TrainingProgramBloc>(
                  create: (context) => TrainingProgramBloc(),
                ), BlocProvider<UserDetailsBloc>(
                  create: (context) => UserDetailsBloc(),
                ),

              ],
              child: HomeScreen(key: UniqueKey()));
        } else if (index == 1) {
          setState(() {
            GlobleValue.button.value =1;
          });
          GlobleValue.selectedScreen.value = MultiBlocProvider(
              providers: [
                BlocProvider<StatisticsBloc>(
                  create: (BuildContext context) => StatisticsBloc(),
                ),
                BlocProvider<StatisticsDeleteBloc>(
                  create: (BuildContext context) => StatisticsDeleteBloc(),
                ),
              ],
              child: YourStatsScreen(key: UniqueKey()));
        } else if (index == 2) {
          setState(() {
            GlobleValue.button.value =0;
          });
          GlobleValue.selectedScreen.value = CartScreen(key: UniqueKey());
        } else if (index == 3) {
          setState(() {
            GlobleValue.button.value =0;
          });
          GlobleValue.selectedScreen.value = BlocProvider<LeaderBoardBloc>(
              create: (context) => LeaderBoardBloc(),
              child: StaticLeaderBoard());
        }
      } else {
        // If the index has changed, assign the new screen
        GlobleValue.selectedIndex.value = index;
        if (index == 0) {
          setState(() {
            GlobleValue.button.value =0;
          });
          GlobleValue.selectedScreen.value = MultiBlocProvider(
              providers: [
                BlocProvider<LeaderBoardBloc>(
                  create: (context) => LeaderBoardBloc(),
                ),
                BlocProvider<TrainingProgramBloc>(
                  create: (context) => TrainingProgramBloc(),
                ),
                BlocProvider<TrainingProgramBloc>(
                  create: (context) => TrainingProgramBloc(),
                ), BlocProvider<UserDetailsBloc>(
                  create: (context) => UserDetailsBloc(),
                ),
              ],
              child: HomeScreen());
        } else if (index == 1) {
          setState(() {
            GlobleValue.button.value =1;
          });
          GlobleValue.selectedScreen.value = MultiBlocProvider(
             providers: [
               BlocProvider<StatisticsBloc>(
                 create: (BuildContext context) => StatisticsBloc(),
               ),
               BlocProvider<StatisticsDeleteBloc>(
                 create: (BuildContext context) => StatisticsDeleteBloc(),
               ),
             ],
              child: YourStatsScreen());
        } else if (index == 2) {
          setState(() {
            GlobleValue.button.value =0;
          });
          GlobleValue.selectedScreen.value = CartScreen();
        } else if (index == 3) {
          setState(() {
            GlobleValue.button.value =0;
          });
          GlobleValue.selectedScreen.value = BlocProvider<LeaderBoardBloc>(
              create: (context) => LeaderBoardBloc(),
              child: StaticLeaderBoard());
        }
      }
    });
  }
  String? _userName;
  String? _profile;
  String? _email;
@override
  void initState() {
    // TODO: implement initState
  context.read<ProfileBloc>().add(FetchProfile());
  // context.read<TrainingProgramBloc>().add(FetchTraining('beginner'));
  context.read<UserDetailsBloc>().add(FetchUserDetails());
  // context.read<TrainingProgramBloc>().add(FetchTraining('advanced'));

  // context.read<TrainingProgramBloc>().add(FetchTraining('pro'));

  // context.read<TrainingProgramBloc>().add(FetchTraining('master'));

  _loadUserName();
  print("_userName $_userName");

  super.initState();
  }
  void _loadUserName() async {
    String? name = await AppPreferences().getName();
    String? profile = await AppPreferences().getImage();
    String? email = await AppPreferences().getEmail();
    String? image = await AppPreferences().getImage();
    setState(() {
      _userName = name ?? 'Guest';
      _profile = Uri.tryParse(profile ?? '')?.hasAbsolutePath ?? false
          ? profile
          : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png';
      _email = email ?? '';
      // AppPreferences().g
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
              GlobleValue.selectedIndex.value=0;
              GlobleValue.button.value=0;
              GlobleValue.selectedScreen.value = MultiBlocProvider(
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
          button: GlobleValue.button.value==1?true:false,
          saveButton: GlobleValue.button.value == 2?true:false,
          
          
          title: '',
          actions: AppImages.image(AppImages.logo, height: 30),
          voidCallback2: () {
            setState(() {
              final profile = Provider.of<ProfileNotifier>(context, listen: false).profile;
              print("SaveData : ${profile.toJson()}");
              print("SaveData1 : ${ProfileData()}");
              GlobleValue.selectedIndex.value=0;
              GlobleValue.button.value=0;
              BlocProvider(
                create: (context) =>ProfileUpdateBloc() ,
              );
              GlobleValue.selectedScreen.value = MultiBlocProvider(
                  providers: [
                    ChangeNotifierProvider.value(value:  GlobalImageManager()),
                    BlocProvider<LeaderBoardBloc>(
                      create: (context) => LeaderBoardBloc(),
                    ),
                    BlocProvider<TrainingProgramBloc>(
                      create: (context) => TrainingProgramBloc(),
                    ),
                    BlocProvider<TrainingProgramBloc>(
                      create: (context) => TrainingProgramBloc(),
                    ), BlocProvider<UserDetailsBloc>(
                      create: (context) => UserDetailsBloc(),
                    ),
                  ],
                  child: HomeScreen());
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
                            GlobleValue.button.value=2;
                            GlobleValue.selectedScreen.value = MultiBlocProvider(
                                providers: [
                                  BlocProvider<ProfileBloc>(
                                    create: (context) => ProfileBloc(),
                                  ),BlocProvider<ProfileUpdateBloc>(
                                    create: (context) => ProfileUpdateBloc(),
                                  ),
                                ],
                                child: ProfileScreen());
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
                              Consumer<GlobalImageManager>(
                                builder: (context, imageManager, child) {
                                  if (!mounted) {
                                    return SizedBox.shrink();
                                  }


                                  try {
                                    if (imageManager.profileImagePath.isNotEmpty) {
                                      return Container(
                                        width: 40.0,
                                        height: 40.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.file(
                                          File(imageManager.profileImagePath),
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    } else {
                                      return _profile!=null ?Container(
                                        width: 40.0,
                                        height: 40.0,
                                        clipBehavior: Clip.antiAlias,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          _profile.toString(),
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: CircularProgressIndicator(color: AppColors.appColor,),
                                                ),
                                              );
                                            }
                                          },
                                          errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                            return Image.asset(
                                              'assets/images/placeholder.jpg',
                                              fit: BoxFit.cover,
                                            );
                                          },
                                        ),
                                      )
                                          :Container(
                                          width: 40.0,
                                          height: 40.0,
                                          clipBehavior: Clip.antiAlias,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                          ),
                                          child: Image.asset("assets/images/placeholder.jpg")
                                      );
                                    }
                                  } catch (e) {
                                    return Text('The image manager has been disposed.');
                                  }
                                },
                              ),
                              SizedBox(width: 10,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Consumer<GlobalImageManager>(
                                      builder: (context, imageManager, child) {
                                        if (!mounted) {
                                          return SizedBox.shrink();
                                        }

                                        try {
                                          if (imageManager.textData.isNotEmpty) {
                                            return Text(
                                              imageManager.textData, // Display the text data from GlobalImageManager
                                              style: AppTextStyles.athleticStyle(
                                                fontSize: 14,
                                                fontFamily: AppTextStyles.sfPro700,
                                                color: AppColors.whiteColor,
                                              ),
                                            );
                                          } else {
                                            return _userName != null
                                                ? Text(
                                              _userName.toString(),
                                              style: AppTextStyles.athleticStyle(
                                                fontSize: 14,
                                                fontFamily: AppTextStyles.sfPro700,
                                                color: AppColors.whiteColor,
                                              ),
                                            )
                                                : Text(
                                              'No data available', // Default text if no data
                                              style: AppTextStyles.athleticStyle(
                                                fontSize: 14,
                                                fontFamily: AppTextStyles.sfPro700,
                                                color: AppColors.whiteColor,
                                              ),
                                            );
                                          }
                                        } catch (e) {
                                          return Text(
                                            'The text manager has been disposed.',
                                            style: AppTextStyles.athleticStyle(
                                              fontSize: 14,
                                              fontFamily: AppTextStyles.sfPro700,
                                              color: AppColors.whiteColor,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    Text(overflow: TextOverflow.ellipsis,"$_email",style: AppTextStyles.getOpenSansGoogleFont(11, AppColors.whiteColor, false),)
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
                              GlobleValue.selectedScreen.value = HowToUseScreen();
                              GlobleValue.button.value=0;
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
                              GlobleValue.button.value=0;                              GlobleValue.selectedScreen.value = HowToCastScreen();

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
                              GlobleValue.button.value=0;
                              GlobleValue.selectedScreen.value = TermsAndConditonsScreen();
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
                          title: Text('Privacy policy',style: AppTextStyles.getOpenSansGoogleFont(14  , AppColors.whiteColor  , false),),
                          onTap: () {
                            setState(() {
                              GlobleValue.selectedScreen.value = PrivacyPolicyScreen();
                              GlobleValue.button.value=0;
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
                              GlobleValue.selectedScreen.value = FAQPage();
                              GlobleValue.button.value=0;
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
                              GlobleValue.selectedScreen.value = MultiBlocProvider(
                                  providers: [
                                    BlocProvider<ContactUsBloc>(
                                      create: (context) => ContactUsBloc(),
                                    ),
                                  ],

                                  child: ContactUsScreen());
                              GlobleValue.button.value=0;
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

        body:  ValueListenableBuilder(
        valueListenable: GlobleValue.selectedScreen,
        builder: (context, selectedScreen, child) {
          return selectedScreen ?? Container();  // Show a default widget if no screen is set
        },
      ),

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
                currentIndex: GlobleValue.selectedIndex.value,
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
  String url='https://quietbounce.com/?trafficSource=qbounce.netlify.app';
  bool isLoading = true;
  late final WebViewController _controller;
  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            print("onPageStarted");
            setState(() {
              isLoading = true;
            });
          },
          onUrlChange: (change) {
            print("onUrlChange");
            setState(() {
              isLoading = false;
            });
          },
          onPageFinished: (String url) {
            print("onPageFinished");

          },
          onWebResourceError: (WebResourceError error) {
            print("URL: ${error.url}, Description: ${error.description}");
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        WebViewWidget(controller: _controller),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(color: AppColors.appColor,),
          ),
      ],
    );
  }
}












