import '../Model/SearchOptions.dart';

class CheckAvailabilityOptions {
  List<RecordIdArray>? recordIdArray;
  SearchOptionsDetails? query;

  CheckAvailabilityOptions({
    this.recordIdArray,
    this.query,
  });

  factory CheckAvailabilityOptions.fromJson(Map<String, dynamic> json) =>
      CheckAvailabilityOptions();

  Map<String, dynamic> toJson() => {};
}

class RecordIdArray {
  String docbase;
  String rscId;
  String rscType;

  RecordIdArray(
    this.docbase,
    this.rscId,
    this.rscType,
  );
}
