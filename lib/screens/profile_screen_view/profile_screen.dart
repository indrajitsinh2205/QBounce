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
import '../../common_widget/common_button.dart';
import '../../common_widget/common_text_field.dart';
import '../../common_widget/custom_snackbar.dart';
import '../../constant/app_color.dart';
import '../../constant/app_strings.dart';
import '../../constant/app_text_style.dart';
import '../state_screen_view/statistics_bloc/statistics_bloc.dart';
import '../state_screen_view/statistics_delete_bloc/statistics_delete_bloc.dart';
import '../state_screen_view/statistics_edit_bloc/statistics_edit_event.dart';
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

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController jerseyNumberController = TextEditingController();
  final TextEditingController instagramHandleController = TextEditingController();

  String? selectedGender = 'Male';
  String? selectedTeam = 'hawks';
  String? selectedPosition = 'Power Forward';
  String? selectedCountry = 'Haiti';

  final List<String> genders = ['male', 'female', 'other'];
  final List<String> teams = ['hawks', 'Lakers', 'Bulls', 'Celtics'];
  final List<String> positions = ['center','power_forward','small_forward','point_guard','shooting_guard'];
  final List<String> countries = ['US', 'Canada', 'UK', 'Australia', 'Haiti'];
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _userName;
  String? _profile;
  // ... existing code ...

  Future<void> _pickImage() async {
    final XFile? pickedFile = await ImageHandler.selectFile(type: FileType.image);
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
        });
      }
    }
  }
  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().add(FetchProfile());
    _loadUserName
      ();
    // Initialize map with default values
    profileData['firstName'] = '';
    profileData['lastName'] = '';
    profileData['jerseyNumber'] = '';
    profileData['instagramHandle'] = '';
    profileData['gender'] = selectedGender;
    profileData['team'] = selectedTeam;
    profileData['position'] = selectedPosition;
    profileData['country'] = selectedCountry;
  }

  void updateProfileData() {
    final updatedProfileRequest = UpdateProfileRequest(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      country: selectedCountry ?? '',
      jerseyNumber: int.tryParse(jerseyNumberController.text) ?? 0,
      gender: selectedGender ?? 'Male',
      team: selectedTeam ?? 'hawks',
      instagram: instagramHandleController.text,
      position: selectedPosition ?? 'Power Forward',
      image: _image.toString()
    );

    // Update the ProfileData singleton
    ProfileData().updateProfileRequest = updatedProfileRequest;

    // Print the updated request
    print('Saved Profile Request: ${ProfileData().updateProfileRequest?.toJson()}');
  }
  void _loadUserName() async {
    String? name = await AppPreferences().getName();
    String? profile = await AppPreferences().getImage();
    setState(() {
      _userName = name ?? 'Guest';
      _profile = Uri.tryParse(profile ?? '')?.hasAbsolutePath ?? false
          ? profile
          : 'https://cdn.pixabay.com/photo/2016/08/08/09/17/avatar-1577909_960_720.png';
    });}
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      child: SingleChildScrollView(
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoaded) {
              firstNameController.text = state.getProfileResponse.data!.firstName ?? '';
              lastNameController.text = state.getProfileResponse.data!.lastName ?? '';
              jerseyNumberController.text = state.getProfileResponse.data!.jerseyNumber.toString();
              instagramHandleController.text = state.getProfileResponse.data!.instagram ?? '';

              selectedGender = state.getProfileResponse.data!.gender ?? 'Male';
              selectedPosition = state.getProfileResponse.data!.position ?? 'Power Forward';

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
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        margin: EdgeInsets.only(top: 50, bottom: 25),
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          color: AppColors.faq,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: AppColors.appColor, width: 5),
                        ),
                        child: _image == null
                            ?_profile!=null?ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(_profile.toString())
            ): Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Upload Image",
                              style: AppTextStyles.athleticStyle(
                                fontSize: 16,
                                fontFamily: AppTextStyles.sfPro700,
                                color: AppColors.whiteColor,
                              ),
                            ),
                            AppImages.image(AppImages.upload, height: 20, width: 20),
                          ],
                        )
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            File(_image!.path),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                  dataFormWidget(),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      saveData(),
                      Spacer()
                    ],
                  )
                ],
              );
            } else if (state is ProfileLoading) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text("Something went wrong"));
            }
          },
        ),
      ),
    );
  }
  Widget saveData() {
    return BlocConsumer<ProfileUpdateBloc, ProfileUpdateState>(
      listener: (context, state) {
        if (state is ProfileUpdateLoaded) {
          ScaffoldMessengerHelper.showMessage(state.updateProfileResponse.message.toString());
        }
      },
      builder: (context, state) {
        if(state is ProfileUpdateLoading){
          return CircularProgressIndicator(color: AppColors.appColor,);
        }
        if(state is ProfileUpdateLoaded){
          Future.delayed(Duration(milliseconds: 100), () {
            setState(() {
              GlobleValue.button.value =1;
            });
          });
        }
        return GestureDetector(
            onTap: () {
              UpdateProfileRequest postData = UpdateProfileRequest(
                  lastName: lastNameController.text,
                  firstName: firstNameController.text,
                  country: selectedCountry.toString(),
                  gender: selectedGender.toString(),
                  instagram: instagramHandleController.text,
                  jerseyNumber: int.tryParse(jerseyNumberController.text) ?? 0,
                  position: selectedPosition.toString(),
                  team: selectedTeam.toString(),
                  image: _image.toString()
              );
              BlocProvider.of<ProfileUpdateBloc>(context).add(FetchProfileUpdate( _image,postData));
            },
            child: CommonButton(title: "Save", color: AppColors.appColor)
        );
      },
    );
  }

  Widget dataFormWidget() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(child: CommonTextField(controller: firstNameController, label: AppStrings.fName, hint: "Michael", numType: false)),
            SizedBox(width: 10),
            Flexible(child: CommonTextField(controller: lastNameController, label: AppStrings.lName, hint: "Johnson", numType: false)),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Flexible(child: buildDropdownField("Your Gender", genders, selectedGender, (value) => setState(() => selectedGender = value))),
            SizedBox(width: 15),
            Flexible(child: buildDropdownField("Your Future Team", teams, selectedTeam, (value) => setState(() => selectedTeam = value))),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Flexible(child: buildDropdownField("Your Position", positions, selectedPosition, (value) => setState(() => selectedPosition = value))),
            SizedBox(width: 10),
            Flexible(child: CommonTextField(controller: jerseyNumberController, label: AppStrings.jerseyNo, hint: "4", numType: true)),
          ],
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Flexible(child: buildDropdownField("Your Country Name", countries, selectedCountry, (value) => setState(() => selectedCountry = value))),
            SizedBox(width: 15),
            Flexible(child: CommonTextField(controller: instagramHandleController, label: AppStrings.instaHand, hint: "bill gates", numType: false)),
          ],
        ),
      ],
    );
  }

  Widget buildDropdownField(String label, List<String> options, String? selectedValue, ValueChanged<String?> onChanged) {
    return Consumer<ProfileNotifier>(
      builder: (context, profileNotifier, child) {
        String selected = selectedValue ?? profileNotifier.profile.toJson()[label] ?? options.first;

        // Remove duplicates from options
        options = options.toSet().toList();

        // Ensure selected value exists in the options
        if (!options.contains(selected)) {
          selected = options.isNotEmpty ? options.first : ''; // Fallback to first option or empty
        }

        return SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: AppTextStyles.athleticStyle(fontSize: 14, fontFamily: AppTextStyles.sfPro700, color: AppColors.whiteColor),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                focusColor: Colors.transparent,
                dropdownColor: Colors.black,
                value: selected,
                items: options.map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: AppTextStyles.getOpenSansGoogleFont(12, AppColors.whiteColor, false),
                  ),
                )).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedValue = newValue;
                    });

                    // Call to updateProfileData to save the updated data
                    updateProfileData();
                  }
,
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
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
