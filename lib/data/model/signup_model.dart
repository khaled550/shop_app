import 'user_model.dart';

class SignupModel {
  bool? status;
  String? message;
  UserModel? user;

  SignupModel({this.status, this.message, this.user});

  SignupModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    user = json['data'] != null ? UserModel.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (user != null) {
      data['data'] = user!.toJson();
    }
    return data;
  }
}
