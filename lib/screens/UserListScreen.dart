import 'package:flutter/material.dart';
import 'package:http_api_demo/models/UserResponse.dart';
import 'package:http_api_demo/utility/ApiManager.dart';
import 'package:http_api_demo/utility/AppStrings.dart';
import 'package:http_api_demo/utility/Utility.dart';
import 'package:http_api_demo/widgets/UserItemView.dart';

import 'UserDetailScreen.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<UserDetails> users = [];
  bool isLoading = false;

  getUsers() async {
    //first check for internet connectivity
    if (await ApiManager.checkInternet()) {
      //show progress
      if (mounted)
        setState(() {
          isLoading = true;
        });

      var request = Map<String, dynamic>();

      //convert json response to class
      UserResponse response = UserResponse.fromJson(
        await ApiManager(context).getCall(
          url: AppStrings.USERS,
          request: request,
        ),
      );

      //hide progress
      if (mounted)
        setState(() {
          isLoading = false;
        });

      // ignore: unnecessary_null_comparison
      if (response != null) {
        if (response.data.length > 0) {
          if (mounted) {
            setState(() {
              //add paginated list data in list
              users = response.data;
            });
          }
        }
      }
    } else {
      //if no internet connectivity available then show apecific message
      Utility.showToast("No Internet Connection");
    }
  }

  @override
  void initState() {
    super.initState();
    getUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Users"),
      ),
      body: body(),
    );
  }

  Widget body() {
    return Stack(
      children: <Widget>[
        ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.only(
            bottom: 12,
          ),
          itemCount: users.length,
          itemBuilder: (BuildContext context, int index) {
            return itemView(index);
          },
        ),
        //show progress
        isLoading ? Utility.progress(context) : Container()
      ],
    );
  }

  Widget itemView(int index) {
    //users item view
    return UserItemView(
      userDetails: users[index],
      onTap: () {
        Navigator.of(context).push(
          new MaterialPageRoute(
            builder: (BuildContext context) => UserDetailScreen(
              selectedUserId: users[index].id,
            ),
          ),
        );
      },
    );
  }
}
