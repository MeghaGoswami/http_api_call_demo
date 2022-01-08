import 'package:flutter/material.dart';
import 'package:http_api_demo/models/UserResponse.dart';

// ignore: must_be_immutable
class UserItemView extends StatelessWidget {
  UserDetails userDetails;
  Function() onTap;
  UserItemView({
    @required this.userDetails,
    @required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      title: Text(userDetails.firstName + " " + userDetails.lastName),
    );
  }
}
