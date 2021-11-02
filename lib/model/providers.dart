import 'dart:io';

class ProviderModel {
  String Email;

  String FirstName;
  String LastName;
  String userID;

  String profilePictureURL;



  ProviderModel({this.Email , this.FirstName , this.LastName , this.userID , this.profilePictureURL });


  factory ProviderModel.fromJson(Map<String, dynamic> parsedJson) {
    return new ProviderModel(
        Email: parsedJson['email'] ?? '',
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