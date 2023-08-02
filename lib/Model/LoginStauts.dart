// To parse this JSON data, do
//
//     final loginStatus = loginStatusFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

LoginStatus loginStatusFromJson(String str) =>
    LoginStatus.fromJson(json.decode(str));

String loginStatusToJson(LoginStatus data) => json.encode(data.toJson());

class LoginStatus {
  List<dynamic> errors;
  dynamic message;
  bool success;
  String d;

  LoginStatus({
    required this.errors,
    this.message,
    required this.success,
    required this.d,
  });

  // ignore: recursive_getters
  List<dynamic> _errors() => errors;

  factory LoginStatus.fromJson(Map<String, dynamic> json) => LoginStatus(
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        message: json["message"],
        success: json["success"],
        d: json["d"],
      );

  Map<String, dynamic> toJson() => {
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "message": message,
        "success": success,
        "d": d,
      };
}

Error ErrorFromJson(String str) => Error.fromJson(json.decode(str));

String ErrorsToJson(Error data) => json.encode(data.toJson());

class Error {
  Error({
    required this.Data,
    required this.Id,
    required this.Msg,
    required this.Type,
  });
  List<dynamic> Data;
  String Id;
  String Msg;
  String Type;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        Data: List<dynamic>.from(json["Data"].map((x) => x)),
        Id: json["Id"],
        Msg: json["Msg"],
        Type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(Data.map((x) => x)),
        "Id": Id,
        "Msg": Msg,
        "Type": Type,
      };
}

Data DataFromJson(String str) => Data.fromJson(json.decode(str));

String DataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    required this.Type,
    required this.BadPasswordCount,
    required this.DoCheckAdditionals,
    required this.CheckAdditionalsResult,
  });

  String Type;
  Long BadPasswordCount;
  bool DoCheckAdditionals;
  bool CheckAdditionalsResult;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        Type: json["Type"],
        BadPasswordCount: json["BadPasswordCount"],
        DoCheckAdditionals: json["DoCheckAdditionals"],
        CheckAdditionalsResult: json["CheckAdditionalsResult"],
      );

  Map<String, dynamic> toJson() => {
        "Type": Type,
        "BadPasswordCount": BadPasswordCount,
        "DoCheckAdditionals": DoCheckAdditionals,
        "CheckAdditionalsResult": CheckAdditionalsResult,
      };
}
