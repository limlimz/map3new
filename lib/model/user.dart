import 'dart:io';

class UserModel {
  String Email;
  String FirstName;
  String LastName;
  String userID;
  String profilePictureURL;



  UserModel({this.Email , this.FirstName , this.LastName , this.userID , this.profilePictureURL });


  factory UserModel.fromJson(Map<String, dynamic> parsedJson) {
    return new UserModel(
        Email: parsedJson['Email'] ?? '',
        FirstName: parsedJson['FirstName'] ?? '',
        LastName: parsedJson['LastName'] ?? '',
        userID: parsedJson['id'] ?? parsedJson['userID'] ?? '',
        profilePictureURL: parsedJson['profilePictureURL'] ?? '');
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