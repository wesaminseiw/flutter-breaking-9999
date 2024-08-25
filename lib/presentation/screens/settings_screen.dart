import 'package:flutter/material.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/constants/variables.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: MyColors.myGrey,
          ),
        ),
        leading: BackButton(
          color: MyColors.myGrey,
        ),
        backgroundColor: MyColors.myYellow,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                Text(
                  'Search by .contains',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: MyColors.myGrey),
                ),
                Spacer(),
                Switch(
                  value: searchType,
                  onChanged: (value) {
                    setState(() {
                      searchType = value;
                    });
                  },
                  activeColor: MyColors.myYellow,
                  activeTrackColor: Colors.grey[300],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
