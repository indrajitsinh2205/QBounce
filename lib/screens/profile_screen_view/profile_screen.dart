import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:q_bounce/constant/app_images.dart';
import 'package:q_bounce/screens/profile_screen_view/get_profile_bloc/get_profile_bloc.dart';
import 'package:q_bounce/screens/profile_screen_view/get_profile_bloc/get_profile_event.dart';
import 'package:q_bounce/screens/profile_screen_view/get_profile_bloc/get_profile_state.dart';
import 'package:q_bounce/screens/profile_screen_view/profile_singleton.dart';
import 'package:q_bounce/screens/profile_screen_view/profile_view_model/profile_response_model/profile_request_model.dart';
import 'package:q_bounce/screens/profile_screen_view/update_profile_bloc/update_profile_bloc.dart';
import 'package:q_bounce/screens/profile_screen_view/update_profile_bloc/update_profile_event.dart';
import 'package:q_bounce/screens/profile_screen_view/update_profile_bloc/update_profile_state.dart';

import '../../app_services/app_preferences.dart';
import '../../app_services/common_Capital.dart';
import '../../app_services/global_image_manager.dart';
import '../../common_widget/common_button.dart';
import '../../common_widget/common_text_field.dart';
import '../../common_widget/custom_snackbar.dart';
import '../../constant/app_color.dart';
import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';
import '../home_screen_view/home_screen.dart';
import '../leaderboard_screen_view/leaderboard_bloc/leader_board_bloc.dart';
import '../state_screen_view/statistics_bloc/statistics_bloc.dart';
import '../state_screen_view/statistics_delete_bloc/statistics_delete_bloc.dart';
import '../state_screen_view/statistics_edit_bloc/statistics_edit_event.dart';
import '../training_screen_view/training_program_bloc/training_program_bloc.dart';
import '../your_stats_screen_view/your_stats_screen.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_handler/image_handler.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final Map<String, dynamic> profileData = {};

   TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController jerseyNumberController = TextEditingController();
  final TextEditingController instagramHandleController =
      TextEditingController();

  final List<String> genders = ['male', 'female', 'other'];
  final List<String> teams = ['hawks', 'Lakers', 'Bulls', 'Celtics'];
  final List<String> positions = [
    'center',
    'power_forward',
    'small_forward',
    'point_guard',
    'shooting_guard'
  ];
  final List<String> countries = ['US', 'Canada', 'UK', 'Australia', 'Haiti'];

  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _userName;
  String? _profile;
  bool imageValue = false;
  bool loadData = false;

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await ImageHandler.selectFile(type: FileType.image);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      final XFile? convertedFile = await ImageHandler.convertFileToOtherFormat(
        file: pickedFile,
        finalFormat: 'jpeg',
        quality: 90,
      );
      if (convertedFile != null) {
        setState(() {
          _image = File(convertedFile.path);
          GlobalImageManager().updateProfileImage(convertedFile.path ?? '');
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile());
    _loadUserName();
    // Initialize map with default values
    profileData['firstName'] = ProfileData.instance.firstName;
    profileData['lastName'] = ProfileData.instance.lastName;
    profileData['jerseyNumber'] = ProfileData.instance.jerseyNumber;
    profileData['instagramHandle'] = ProfileData.instance.instagramHandler;

    profileData['gender'] = ProfileData.instance.selectedGender;
    profileData['team'] = ProfileData.instance.selectedTeam;
    profileData['position'] = ProfileData.instance.selectedPosition;
    profileData['country'] = ProfileData.instance.selectedCountry;
  }

  // // GENERATE REQUEST MODEL
  // void updateProfileData(BuildContext context) {
  //   print("selectedTeam in Update Profile ${ProfileData.instance.selectedTeam}");
  //
  //   final updatedProfileRequest = UpdateProfileRequest(
  //     firstName: firstNameController.text,
  //     lastName: lastNameController.text,
  //     country: ProfileData.instance.selectedCountry ?? '',
  //     jerseyNumber: int.tryParse(jerseyNumberController.text) ?? 0,
  //     gender: ProfileData.instance.selectedGender ?? 'Male',
  //     team: ProfileData.instance.selectedTeam ?? 'hawks',
  //     instagram: instagramHandleController.text,
  //     position: ProfileData.instance.selectedPosition ?? 'Power Forward',
  //     image: _image.toString(),
  //   );
  //
  //   // Update the ProfileData singleton
  //   ProfileData.instance.updateProfileRequest = updatedProfileRequest;
  //
  //   // Print the updated request
  //   print('Saved Profile Request: ${ProfileData.instance.updateProfileRequest?.toJson()}');
  //
  // }

  void _loadUserName() async {
    String? name = await AppPreferences().getName();
    String? profile = await AppPreferences().getImage();
    setState(() {
      _userName = name ?? 'Guest';
      _profile = profile != null
          ? profile
          : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png';
      loadData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if(loadData==false){
    //   _loadUserName();
    // }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  if (state is ProfileLoaded) {
                    print(
                        "Profile Response: ${state.getProfileResponse.data?.team}");

                    ProfileData.instance.firstName =
                        state.getProfileResponse.data?.firstName ?? '';
                    ProfileData.instance.lastName =
                        state.getProfileResponse.data?.lastName ?? '';
                    ProfileData.instance.jerseyNumber = state
                            .getProfileResponse.data?.jerseyNumber
                            .toString() ??
                        '';
                    ProfileData.instance.instagramHandler =
                        state.getProfileResponse.data?.instagram ?? '';

                    ProfileData.instance.selectedTeam =
                        state.getProfileResponse.data?.team ?? '';
                    ProfileData.instance.selectedGender =
                        state.getProfileResponse.data!.gender ?? 'Male';
                    ProfileData.instance.selectedPosition =
                        state.getProfileResponse.data!.position ??
                            'Power Forward';

                    firstNameController.text = ProfileData.instance.firstName;
                    lastNameController.text = ProfileData.instance.lastName;
                    jerseyNumberController.text =
                        ProfileData.instance.jerseyNumber;
                    instagramHandleController.text =
                        ProfileData.instance.instagramHandler;

                    AppPreferences().saveName(
                        state.getProfileResponse.data!.firstName.toString());
                    AppPreferences().saveImage(
                        state.getProfileResponse.data!.image.toString());

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.profile.toUpperCase(),
                          style: AppTextStyles.athleticStyle(
                            fontSize: 28,
                            fontFamily: AppTextStyles.athletic,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        Center(
                          child: InkWell(
                            onTap: () async {
                              // Assuming _pickImage is a method that opens a file picker
                              await _pickImage(); // Call the image picker and update the state
                            },
                            child: Consumer<GlobalImageManager>(
                              builder: (context, imageManager, child) {
                                if (!mounted) {
                                  return SizedBox.shrink();
                                }

                                try {
                                  if (imageManager!
                                      .profileImagePath.isNotEmpty) {
                                    imageValue = true;

                                    return Center(
                                      child: GestureDetector(
                                        onTap: _pickImage,
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              top: 25, bottom: 25),
                                          height: 150,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: AppColors.faq,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: AppColors.appColor,
                                                width: 5),
                                          ),
                                          child: _image == null
                                              ? _profile != null
                                                  ? ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: Image.network(
                                                          _profile.toString()))
                                                  : Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Text(
                                                          "Upload Image",
                                                          style: AppTextStyles
                                                              .athleticStyle(
                                                            fontSize: 16,
                                                            fontFamily:
                                                                AppTextStyles
                                                                    .sfPro700,
                                                            color: AppColors
                                                                .whiteColor,
                                                          ),
                                                        ),
                                                        AppImages.image(
                                                            AppImages.upload,
                                                            height: 20,
                                                            width: 20),
                                                      ],
                                                    )
                                              : ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.file(
                                                    File(imageManager!
                                                        .profileImagePath),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    imageValue = _profile != null;

                                    return InkWell(
                                      onTap: _pickImage, // Corrected here
                                      child: Padding(
                                        padding: const EdgeInsetsDirectional
                                            .fromSTEB(0.0, 30.0, 0.0, 0.0),
                                        child: _profile != null
                                            ? Container(
                                                margin: EdgeInsets.only(
                                                    top: 50, bottom: 25),
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: AppColors.faq,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: AppColors.appColor,
                                                      width: 5),
                                                ),
                                                child: Image.network(
                                                  _profile.toString(),
                                                  fit: BoxFit.cover,
                                                  loadingBuilder:
                                                      (BuildContext context,
                                                          Widget child,
                                                          ImageChunkEvent?
                                                              loadingProgress) {
                                                    if (loadingProgress ==
                                                        null) {
                                                      return child; // Display the network image when fully loaded
                                                    } else {
                                                      // Show a loading spinner while the image loads
                                                      return Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: CircularProgressIndicator(
                                                              color: AppColors
                                                                  .appColor),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                  errorBuilder: (BuildContext
                                                          context,
                                                      Object error,
                                                      StackTrace? stackTrace) {
                                                    return Image.asset(
                                                      'assets/images/placeholder.jpg',
                                                      // Use placeholder if image fails to load
                                                      fit: BoxFit.cover,
                                                    );
                                                  },
                                                ),
                                              )
                                            : Container(
                                                margin: EdgeInsets.only(
                                                    top: 50, bottom: 25),
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                  color: AppColors.faq,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: AppColors.appColor,
                                                      width: 5),
                                                ),
                                                child: Image.asset(
                                                    "assets/images/placeholder.jpg"),
                                              ),
                                      ),
                                    ); // Default icon if no image
                                  }
                                } catch (e) {
                                  return Text(
                                      'The image manager has been disposed.');
                                }
                              },
                            ),
                          ),
                        ),
                        dataFormWidget(),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [saveData(), Spacer()],
                        )
                      ],
                    );
                  } else if (state is ProfileLoading) {
                    return Center(
                        child: CircularProgressIndicator(
                      color: AppColors.appColor,
                    ));
                  } else {
                    return Center(child: Text("Something went wrong"));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget saveData() {
    return BlocConsumer<ProfileUpdateBloc, ProfileUpdateState>(
      listener: (context, state) {
        if (state is ProfileUpdateLoaded) {
          setState(() {
            GlobleValue.currentIndex.value =0;
          });
          ScaffoldMessengerHelper.showMessage(
              state.updateProfileResponse.message.toString());
          setState(() {
            GlobleValue.button.value = 0;
            GlobleValue.currentIndex.value = 0;
            GlobleValue.overlayScreen.value =null;

          });
          GlobleValue.selectedScreen.value = MultiBlocProvider(providers: [
            BlocProvider<LeaderBoardBloc>(
              create: (context) => LeaderBoardBloc(),
            ),
            BlocProvider<TrainingProgramBloc>(
              create: (context) => TrainingProgramBloc(),
            ),
          ], child: HomeScreen(key: UniqueKey()));
        }
        // if (state is ProfileUpdateError) {
        //   ScaffoldMessengerHelper.showMessage(state.errorMessage.toString());
        // }
      },
      builder: (context, state) {
        if (state is ProfileUpdateLoading) {
          return CircularProgressIndicator(
            color: AppColors.appColor,
          );
        }
        if (state is ProfileUpdateLoaded) {
          Future.delayed(Duration(milliseconds: 100), () {
            setState(() {
              GlobleValue.currentIndex.value =0;
              GlobleValue.overlayScreen.value =null;
            });
          });
        }
        return GestureDetector(
            onTap: () {
              if (ProfileData.instance.firstName.isEmpty ||
                      ProfileData.instance.lastName.isEmpty ||
                      ProfileData.instance.selectedCountry.isEmpty ||
                      ProfileData.instance.selectedGender.isEmpty ||
                      ProfileData.instance.instagramHandler.isEmpty ||
                      ProfileData.instance.jerseyNumber.isEmpty ||
                      ProfileData.instance.selectedPosition.isEmpty ||
                      ProfileData.instance.selectedTeam.isEmpty
                  // _image!.path.isEmpty
                  ) {
                ScaffoldMessengerHelper.showMessage("All field are required");
              }

              if (ProfileData.instance.updateProfileRequest == null) {
                return;
              }
              print(
                  "post Data${ProfileData.instance.updateProfileRequest?.firstName}");

              BlocProvider.of<ProfileUpdateBloc>(context).add(
                FetchProfileUpdate(
                  _image,
                  ProfileData.instance
                      .updateProfileRequest!, // Pass the object directly
                ),
              );
            },
            child: CommonButton(title: "Save", color: AppColors.appColor));
      },
    );
  }

  Widget dataFormWidget() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
                child: CommonTextField(
                  onChanged:  (newValue){
                    ProfileData.instance.firstName = newValue;
                    ProfileData.instance.getUpdateProfileRequest();
                  },
                    controller: firstNameController,
                    label: AppStrings.fName,
                    hint: "Michael",
                    numType: false)),
            SizedBox(width: 10),
            Flexible(
                child: CommonTextField(
                    onChanged:  (newValue){
                      ProfileData.instance.lastName = newValue;
                      ProfileData.instance.getUpdateProfileRequest();
                    },
                    controller: lastNameController,
                    label: AppStrings.lName,
                    hint: "Johnson",
                    numType: false)),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Flexible(
                child: buildDropdownField(
                    "Your Gender",
                    genders,
                    ProfileData.instance.selectedGender,
                    (value) => ProfileData
                        .instance.selectedGender = value.toString())),
            SizedBox(width: 15),
            Flexible(
              child: buildDropdownField(
                "Your Future Team",
                teams,
                ProfileData.instance.selectedTeam,
                (value) =>
                  ProfileData.instance.selectedTeam = value.toString()

              ),
            ),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Flexible(
                child: buildDropdownField(
                    "Your Position",
                    positions,
                    ProfileData.instance.selectedPosition,
                    (value) => ProfileData
                        .instance.selectedPosition = value.toString())),
            SizedBox(width: 10),
            Flexible(
                child: CommonTextField(
                    onChanged:  (newValue){
                      ProfileData.instance.jerseyNumber = newValue;
                      ProfileData.instance.getUpdateProfileRequest();
                    },
                    controller: jerseyNumberController,
                    label: AppStrings.jerseyNo,
                    hint: "4",
                    numType: true)),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Flexible(
                child: buildDropdownField(
                    "Your Country Name",
                    countries,
                    ProfileData.instance.selectedCountry,
                    (value) => ProfileData
                        .instance.selectedCountry = value.toString())),
            SizedBox(width: 15),
            Flexible(
                child: CommonTextField(
                    onChanged:  (newValue){
                      ProfileData.instance.instagramHandler = newValue;
                      ProfileData.instance.getUpdateProfileRequest();
                    },
                    controller: instagramHandleController,
                    label: AppStrings.instaHand,
                    hint: "bill gates",
                    numType: false)),
          ],
        ),
      ],
    );
  }

  Widget buildDropdownField(String label, List<String> options,
      String? selectedValue, ValueChanged<String?> onChanged) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.athleticStyle(
              fontSize: 14,
              fontFamily: AppTextStyles.sfPro700,
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(height: 10),
          DropdownButtonFormField<String>(
            focusColor: Colors.transparent,
            dropdownColor: Colors.black,
            value: selectedValue,
            // Pass the correct state variable here
            items: options.map((e) {
              return DropdownMenuItem(
                value: e,
                child: Text(
                  e,
                  style: AppTextStyles.getOpenSansGoogleFont(
                      12, AppColors.whiteColor, false),
                ),
              );
            }).toList(),
            onChanged: (newValue) {
              // setState(() {
                if (label == "Your Gender") {
                  ProfileData.instance.selectedGender =
                      newValue.toString(); // Update corresponding state
                } else if (label == "Your Future Team") {
                  ProfileData.instance.selectedTeam =
                      newValue.toString(); // Update corresponding state
                } else if (label == "Your Position") {
                  ProfileData.instance.selectedPosition =
                      newValue.toString(); // Update corresponding state
                } else if (label == "Your Country Name") {
                  ProfileData.instance.selectedCountry =
                      newValue.toString(); // Update corresponding state
                }
              // });
              print("Selected value for $label: $newValue");

              // Call external method if necessary
              ProfileData.instance.getUpdateProfileRequest();
            },
            icon: AppImages.image(AppImages.downArrow, height: 20, width: 10),
            decoration: InputDecoration(
              filled: true,
              fillColor: AppColors.faq,
              border: InputBorder.none,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.transparent),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.appColor, width: 2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
