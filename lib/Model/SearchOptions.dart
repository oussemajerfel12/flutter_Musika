// -- search_options.dart --

import 'dart:convert';
import 'dart:ffi';

class SearchOptions {
  SearchOptionsDetails? query;
  String? haveQuery = "true";

  SearchOptions({
    this.query,
    this.haveQuery,
  });

  SearchOptions.fromJson(Map<String, dynamic> json)
      : haveQuery = json['haveQuery'],
        query = SearchOptionsDetails.fromJson(json['SearchOptionsDetails']);

  Map<String, dynamic> toJson() => {
        'haveQuery': haveQuery,
        'query': query,
      };
}
// -- search_options_details.dart --

class SearchOptionsDetails {
  bool? ForceSearch;
  int? Page = 0;
  String? QueryString = "*";
  int? ResultSize;
  String? ScenarioCode;
  String? SortField;
  String? FacetFilter;
  int? SortOrder = 0;
  bool? InjectFields;

  SearchOptionsDetails({
    this.ForceSearch = true,
    this.QueryString,
    this.ResultSize,
    this.Page,
    this.ScenarioCode,
    this.SortField,
    this.FacetFilter = "",
    this.InjectFields,
  });
  factory SearchOptionsDetails.fromJson(Map<String, dynamic> json) =>
      SearchOptionsDetails(
          Page: json["page"] as int,
          ScenarioCode: json["scenarioCode"],
          SortField: json["sortField"],
          FacetFilter: json["facetFilter"],
          InjectFields: json["InjectFields"]);
  Map<String, dynamic> toJson() => {
        'ForceSearch': ForceSearch,
        'QueryString': QueryString,
        'ResultSize': ResultSize,
        'Page': Page,
        'ScenarioCode': ScenarioCode,
        'SortField': SortField,
        'FacetFilter': FacetFilter,
        'InjectFields': InjectFields,
      };
}
