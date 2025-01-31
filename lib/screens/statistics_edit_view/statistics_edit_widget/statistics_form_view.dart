import 'package:flutter/cupertino.dart';

import '../../../common_widget/common_text_field.dart';
import '../../../constant/app_strings.dart';
import 'edit_calender.dart';

class StatisticsFormView extends StatefulWidget {
  const StatisticsFormView({super.key});

  @override
  State<StatisticsFormView> createState() => _StatisticsFormViewState();
}

class _StatisticsFormViewState extends State<StatisticsFormView> {
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _opponentController = TextEditingController();
  final TextEditingController _PTSController = TextEditingController();
  final TextEditingController _REBController = TextEditingController();
  final TextEditingController _ASTController = TextEditingController();
  final TextEditingController _STLController = TextEditingController();
  final TextEditingController _BLKController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CommonTextField(controller: _locationController,label:  AppStrings.location,hint:  AppStrings.location,numType: false
          ),
          CommonTextField(controller:_opponentController,label: AppStrings.opponent,hint: AppStrings.opponent,numType:false),
          Row(
            children: [
              Flexible(
                child: CommonTextField(controller:_PTSController,label: AppStrings.pts,hint: AppStrings.pts,numType:true),
              ),
              SizedBox(width: 10),
              Flexible(
                child: CommonTextField(controller:_REBController,label: AppStrings.reb,hint: AppStrings.reb,numType:true),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: CommonTextField(controller:_ASTController,label: AppStrings.ast,hint: AppStrings.ast,numType:true),
              ),
              SizedBox(width: 10),
              Flexible(
                child: CommonTextField(controller:_STLController,label: AppStrings.stl,hint: AppStrings.stl,numType:true,),
              ),
            ],
          ),
          Row(
            children: [
              Flexible(
                child: CommonTextField(controller:_BLKController,label: AppStrings.blk,hint: AppStrings.blk,numType:true),
              ),
              SizedBox(width: 10),
              EditCalender(),
            ],
          ),
        ],
      ),
    );
  }
}
