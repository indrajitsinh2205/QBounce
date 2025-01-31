import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../constant/app_color.dart';
import '../../../constant/app_strings.dart';

class EditCalender extends StatefulWidget {
  const EditCalender({super.key});

  @override
  State<EditCalender> createState() => _EditCalenderState();
}

class _EditCalenderState extends State<EditCalender> {
  String selectedDate = "";

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate.isEmpty ? DateTime.now() : DateTime.parse(selectedDate),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      String formattedDate = DateFormat(AppStrings.dateFormat).format(pickedDate);
      setState(() {
        selectedDate = formattedDate;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(AppStrings.match, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700)),
          Container(
            padding: EdgeInsets.only(left: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: AppColors.blackColor),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    selectedDate.isEmpty ? AppStrings.dateFormat : selectedDate,
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _selectDate(context); // Open date picker
                  },
                  icon: Icon(Icons.calendar_month),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
