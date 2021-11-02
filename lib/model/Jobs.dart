import 'dart:io';

class JobModel {
  String icon;
  String name;

  JobModel({this.icon , this.name  });


  factory JobModel.fromJson(Map<String, dynamic> parsedJson) {
    return new JobModel(
        icon: parsedJson['icon'] ?? '',
        name: parsedJson['name'] ?? '',
    );
  }

// Map<String, dynamic> toJson() {
//   return {
//     'email': this.email,
//     'name': this.FirstName,
//     'name': this.LastName,
//     'id': this.userID,
//     'profilePictureURL': this.profilePictureURL,
//
//   };
// }
}