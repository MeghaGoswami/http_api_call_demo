import 'package:flutter/material.dart';
import 'package:http_api_demo/models/SingleUserResponse.dart';
import 'package:http_api_demo/models/UserResponse.dart';
import 'package:http_api_demo/utility/ApiManager.dart';
import 'package:http_api_demo/utility/AppColors.dart';
import 'package:http_api_demo/utility/AppStrings.dart';
import 'package:http_api_demo/utility/Utility.dart';

// ignore: must_be_immutable
class UserDetailScreen extends StatefulWidget {
  int selectedUserId;
  UserDetailScreen({
    @required this.selectedUserId,
  });
  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  bool isLoading = false;
  UserDetails userDetails = UserDetails();

  @override
  void initState() {
    super.initState();
    getUser(widget.selectedUserId);
  }

  getUser(int selectedUserId) async {
    //first check for internet connectivity
    if (await ApiManager.checkInternet()) {
      //show progress
      if (mounted)
        setState(() {
          isLoading = true;
        });

      //convert json response to class
      SingleUserResponse response = SingleUserResponse.fromJson(
        await ApiManager(context).getCall(
          url: AppStrings.USERS + "/" + selectedUserId.toString(),
          request: null,
        ),
      );

      //hide progress
      if (mounted)
        setState(() {
          isLoading = false;
        });

      if (response?.data != null) {
        if (mounted) {
          setState(() {
            userDetails = response.data;
          });
        }
      }
    } else {
      //if no internet connectivity available then show apecific message
      Utility.showToast("No Internet Connection");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: body(),
    );
  }

  Widget body() {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              userDetails == null
                  ? Container()
                  : Text((userDetails.firstName ?? "") +
                      " " +
                      (userDetails.lastName ?? "")),
              isLoading ? Utility.progress(context) : Container()
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(bottom: 8),
          alignment: Alignment.bottomCenter,
          child: Text("Made with ♥ in Flutter"),
        )
      ],
    );
  }
}
