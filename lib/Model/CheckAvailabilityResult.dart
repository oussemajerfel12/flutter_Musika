// -- check_availability_result.dart --
import 'dart:convert';

CheckAvailabilityResult CheckAvailabilityResultFromJson(String str) =>
    CheckAvailabilityResult.fromJson(json.decode(str));

class CheckAvailabilityResult {
  List<dynamic>? errors;
  Object? message;
  bool? success;
  List<CheckAvailabilityData>? D;

  CheckAvailabilityResult({
    required this.errors,
    required this.message,
    required this.success,
    required this.D,
  });

  factory CheckAvailabilityResult.fromJson(Map<String, dynamic> json) =>
      CheckAvailabilityResult(
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        message: json["message"],
        success: json["success"],
        D: json["d"],
      );

  Map<String, dynamic> toJson() => {
        "errors": List<dynamic>.from(errors!.map((x) => x)),
        "message": message,
        "success": success,
        "d": D,
      };
}

class CheckAvailabilityData {
  String htmlView;
  IdCheckAvailability id;

  CheckAvailabilityData({
    required this.htmlView,
    required this.id,
  });

  factory CheckAvailabilityData.fromJson(Map<String, dynamic> json) =>
      CheckAvailabilityData(htmlView: json['htmlView'], id: json['id']);

  Map<String, dynamic> toJson() => {"htmlView": htmlView, "id": id};
}

class IdCheckAvailability {
  String docbase;
  String rscId;

  IdCheckAvailability({
    required this.docbase,
    required this.rscId,
  });

  factory IdCheckAvailability.fromJson(Map<String, dynamic> json) =>
      IdCheckAvailability(docbase: json['docbase'], rscId: json['rscId']);
  Map<String, dynamic> toJson() => {"docbase": docbase, "rscId": docbase};
}
