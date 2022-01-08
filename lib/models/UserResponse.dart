class UserResponse {
  List<UserDetails> data;

  UserResponse({this.data});

  UserResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <UserDetails>[];
      json['data'].forEach((v) {
        data.add(new UserDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserDetails {
  int id;
  String email;
  String firstName;
  String lastName;
  String avatar;

  UserDetails(
      {this.id, this.email, this.firstName, this.lastName, this.avatar});

  UserDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? 0;
    email = json['email'] ?? "";
    firstName = json['first_name'] ?? "";
    lastName = json['last_name'] ?? "";
    avatar = json['avatar'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['avatar'] = this.avatar;
    return data;
  }
}
