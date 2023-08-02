import 'dart:convert';
import 'dart:ffi';

import 'package:get/get.dart';

SearchResult SearchResultFromJson(String str) =>
    SearchResult.fromJson(json.decode(str));

String SearchResultToJson(SearchResult data) => json.encode(data.toJson());

class SearchResult {
  List<dynamic>? errors;
  dynamic? message;
  bool? success;
  List<D>? d;

  SearchResult({
    this.errors,
    this.message,
    this.success,
    this.d,
  });

  factory SearchResult.fromJson(Map<String, dynamic> json) {
    return SearchResult(
      errors: List<dynamic>.from(json["errors"].map((x) => x)),
      message: json["message"],
      success: json["success"],
      d: (json['D'] as List<dynamic>)
          .cast<Map<String, dynamic>>()
          .map((item) => D.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {};
}

D dFromJson(String str) => D.fromJson(json.decode(str));

String dToJson(D data) => json.encode(data.toJson());

class D {
  D({
    this.facetCollectionList,
    this.htmlResult,
    this.query,
    this.results,
    this.scenarioDisplayMode,
    this.searchInfo,
    this.sorts,
    this.spellChecking,
  });

  List<FacetCollectionList>? facetCollectionList;
  String? htmlResult;
  Query? query;
  List<Result>? results;
  List<ScenarioDisplayMode>? scenarioDisplayMode;
  SearchInfo? searchInfo;
  List<Sort>? sorts;
  SpellChecking? spellChecking;

  factory D.fromJson(Map<String, dynamic> json) {
    return D(
      facetCollectionList: List<FacetCollectionList>.from(
          json["FacetCollectionList"]
              .map((x) => FacetCollectionList.fromJson(x))),
      htmlResult: json["HtmlResult"],
      query: Query.fromJson(json["Query"]),
      results: List<Result>.from(json["Results"].map((x) => Result.fromJson(x)))
          .toList(),
      scenarioDisplayMode: List<ScenarioDisplayMode>.from(
          json["ScenarioDisplayMode"]
              .map((x) => ScenarioDisplayMode.fromJson(x))),
      searchInfo: SearchInfo.fromJson(json["SearchInfo"]),
      sorts: List<Sort>.from(json["Sorts"].map((x) => Sort.fromJson(x))),
      spellChecking: SpellChecking.fromJson(json["SpellChecking"]),
    );
  }

  Map<String, dynamic> toJson() => {
        "FacetCollectionList":
            List<dynamic>.from(facetCollectionList!.map((x) => x.toJson())),
        "HtmlResult": htmlResult,
        "Query": query!.toJson(),
        "Results": List<Result>.from(results!.map((x) => x.toJson())),
        "ScenarioDisplayMode":
            List<dynamic>.from(scenarioDisplayMode!.map((x) => x.toJson())),
        "SearchInfo": searchInfo!.toJson(),
        "Sorts": List<dynamic>.from(sorts!.map((x) => x.toJson())),
        "SpellChecking": spellChecking!.toJson(),
      };
}

class FacetCollectionList {
  FacetCollectionList({
    this.facetContains,
    required this.facetDisplayMode,
    required this.facetDisplayed,
    required this.facetField,
    required this.facetId,
    required this.facetLabel,
    required this.facetLimit,
    required this.facetList,
    required this.facetSortOrder,
    required this.isMultiselectable,
    required this.isSearchable,
    required this.lastPage,
    required this.nullValues,
    this.recoveryThresHold,
    this.rights,
  });

  dynamic facetContains;
  int facetDisplayMode;
  int facetDisplayed;
  String facetField;
  int facetId;
  String facetLabel;
  int facetLimit;
  List<FacetList> facetList;
  int facetSortOrder;
  bool isMultiselectable;
  bool isSearchable;
  bool lastPage;
  bool nullValues;
  dynamic recoveryThresHold;
  String? rights;

  factory FacetCollectionList.fromJson(Map<String, dynamic> json) =>
      FacetCollectionList(
        facetContains: json["FacetContains"],
        facetDisplayMode: json["FacetDisplayMode"],
        facetDisplayed: json["FacetDisplayed"],
        facetField: json["FacetField"],
        facetId: json["FacetId"],
        facetLabel: json["FacetLabel"],
        facetLimit: json["FacetLimit"],
        facetList: List<FacetList>.from(
            json["FacetList"].map((x) => FacetList.fromJson(x))),
        facetSortOrder: json["FacetSortOrder"],
        isMultiselectable: json["IsMultiselectable"],
        isSearchable: json["IsSearchable"],
        lastPage: json["LastPage"],
        nullValues: json["NullValues"],
        recoveryThresHold: json["RecoveryThresHold"],
        rights: json["Rights"],
      );

  Map<String, dynamic> toJson() => {
        "FacetContains": facetContains,
        "FacetDisplayMode": facetDisplayMode,
        "FacetDisplayed": facetDisplayed,
        "FacetField": facetField,
        "FacetId": facetId,
        "FacetLabel": facetLabel,
        "FacetLimit": facetLimit,
        "FacetList": List<dynamic>.from(facetList.map((x) => x.toJson())),
        "FacetSortOrder": facetSortOrder,
        "IsMultiselectable": isMultiselectable,
        "IsSearchable": isSearchable,
        "LastPage": lastPage,
        "NullValues": nullValues,
        "RecoveryThresHold": recoveryThresHold,
        "Rights": rights,
      };
}

class FacetList {
  FacetList({
    required this.count,
    required this.isSelected,
    required this.label,
    this.size,
    this.displayLabel,
  });

  int count;
  bool isSelected;
  String label;
  int? size;
  String? displayLabel;

  factory FacetList.fromJson(Map<String, dynamic> json) => FacetList(
        count: json["Count"],
        isSelected: json["IsSelected"],
        label: json["Label"],
        size: json["Size"],
        displayLabel: json["DisplayLabel"],
      );

  Map<String, dynamic> toJson() => {
        "Count": count,
        "IsSelected": isSelected,
        "Label": label,
        "Size": size,
        "DisplayLabel": displayLabel,
      };
}

class Query {
  Query({
    required this.cloudTerms,
    required this.facetFilter,
    required this.forceSearch,
    required this.initialSearch,
    required this.page,
    required this.pageRange,
    required this.queryGuid,
    required this.queryString,
    required this.resultSize,
    required this.scenarioCode,
    required this.scenarioDisplayMode,
    required this.searchGridFieldsShownOnResultsDto,
    required this.searchLabel,
    required this.searchTerms,
    this.sortField,
    required this.sortOrder,
    required this.templateParams,
    required this.url,
    this.useSpellChecking,
  });

  List<dynamic> cloudTerms;
  String facetFilter;
  bool forceSearch;
  bool initialSearch;
  int page;
  int pageRange;
  String queryGuid;
  String queryString;
  int resultSize;
  String scenarioCode;
  String scenarioDisplayMode;
  List<dynamic> searchGridFieldsShownOnResultsDto;
  String searchLabel;
  String searchTerms;
  dynamic sortField;
  int sortOrder;
  TemplateParams templateParams;
  String url;
  dynamic useSpellChecking;

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        cloudTerms: List<dynamic>.from(json["CloudTerms"].map((x) => x)),
        facetFilter: json["FacetFilter"],
        forceSearch: json["ForceSearch"],
        initialSearch: json["InitialSearch"],
        page: json["Page"],
        pageRange: json["PageRange"],
        queryGuid: json["QueryGuid"],
        queryString: json["QueryString"],
        resultSize: json["ResultSize"],
        scenarioCode: json["ScenarioCode"],
        scenarioDisplayMode: json["ScenarioDisplayMode"],
        searchGridFieldsShownOnResultsDto: List<dynamic>.from(
            json["SearchGridFieldsShownOnResultsDTO"].map((x) => x)),
        searchLabel: json["SearchLabel"],
        searchTerms: json["SearchTerms"],
        sortField: json["SortField"],
        sortOrder: json["SortOrder"],
        templateParams: TemplateParams.fromJson(json["TemplateParams"]),
        url: json["Url"],
        useSpellChecking: json["UseSpellChecking"],
      );

  Map<String, dynamic> toJson() => {
        "CloudTerms": List<dynamic>.from(cloudTerms.map((x) => x)),
        "FacetFilter": facetFilter,
        "ForceSearch": forceSearch,
        "InitialSearch": initialSearch,
        "Page": page,
        "PageRange": pageRange,
        "QueryGuid": queryGuid,
        "QueryString": queryString,
        "ResultSize": resultSize,
        "ScenarioCode": scenarioCode,
        "ScenarioDisplayMode": scenarioDisplayMode,
        "SearchGridFieldsShownOnResultsDTO":
            List<dynamic>.from(searchGridFieldsShownOnResultsDto.map((x) => x)),
        "SearchLabel": searchLabel,
        "SearchTerms": searchTerms,
        "SortField": sortField,
        "SortOrder": sortOrder,
        "TemplateParams": templateParams.toJson(),
        "Url": url,
        "UseSpellChecking": useSpellChecking,
      };
}

class TemplateParams {
  TemplateParams({
    required this.scenario,
    required this.scope,
    this.size,
    required this.source,
    required this.support,
    required this.useCompact,
  });

  String scenario;
  String scope;
  dynamic size;
  String source;
  String support;
  bool useCompact;

  factory TemplateParams.fromJson(Map<String, dynamic> json) => TemplateParams(
        scenario: json["Scenario"],
        scope: json["Scope"],
        size: json["Size"],
        source: json["Source"],
        support: json["Support"],
        useCompact: json["UseCompact"],
      );

  Map<String, dynamic> toJson() => {
        "Scenario": scenario,
        "Scope": scope,
        "Size": size,
        "Source": source,
        "Support": support,
        "UseCompact": useCompact,
      };
}

class User {
  String userDisplayname;
  String userRoleid;
  int userUid;

  User({
    required this.userDisplayname,
    required this.userRoleid,
    required this.userUid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        userDisplayname: json["UserDisplayname"],
        userRoleid: json["UserRoleid"],
        userUid: json["UserUid"],
      );

  Map<String, dynamic> toJson() => {
        "UserDisplayname": userDisplayname,
        "UserRoleid": userRoleid,
        "UserUid": userUid,
      };
}

class Label {
  int culture;
  String displayLabel;
  bool isSystem;
  int labelUid;
  int site;
  User? user;
  String whenAdded;
  int? count;

  Label({
    required this.culture,
    required this.displayLabel,
    required this.isSystem,
    required this.labelUid,
    required this.site,
    this.user,
    required this.whenAdded,
    this.count,
  });

  factory Label.fromJson(Map<String, dynamic> json) => Label(
        culture: json["Culture"],
        displayLabel: json["DisplayLabel"],
        isSystem: json["IsSystem"],
        labelUid: json["LabelUid"],
        site: json["Site"],
        user: json["User"] == null ? null : User.fromJson(json["User"]),
        whenAdded: json["WhenAdded"],
        count: json["Count"],
      );

  Map<String, dynamic> toJson() => {
        "Culture": culture,
        "DisplayLabel": displayLabel,
        "IsSystem": isSystem,
        "LabelUid": labelUid,
        "Site": site,
        "User": user?.toJson(),
        "WhenAdded": whenAdded,
        "Count": count,
      };
}

class Result {
  Result({
    this.compactResult,
    this.customResult,
    this.friendlyUrl,
    this.groupedResults,
    this.hasDigitalReady,
    this.hasPrimaryDocs,
    this.highLights,
    this.linkedResultsTwin,
    this.noIndexRobots,
    this.primaryDocs,
    this.resource,
    this.fieldList,
    this.seekForHoldings,
    this.templateLabel,
    this.worksKeyResults,
  });

  String? compactResult;
  String? customResult;
  String? friendlyUrl;
  List<dynamic>? groupedResults;
  bool? hasDigitalReady;
  bool? hasPrimaryDocs;
  Suggestions? highLights;
  LinkedResultsTwin? linkedResultsTwin;
  bool? noIndexRobots;
  PrimaryDoc? primaryDocs;
  Resource? resource;
  bool? seekForHoldings;
  FieldList? fieldList;
  TemplateLabel? templateLabel;
  List<dynamic>? worksKeyResults;

  factory Result.fromModel(Result result) {
    return Result(
        compactResult: result.compactResult,
        customResult: result.customResult,
        friendlyUrl: result.friendlyUrl,
        groupedResults: result.groupedResults,
        hasDigitalReady: result.hasDigitalReady,
        hasPrimaryDocs: result.hasPrimaryDocs,
        highLights: result.highLights,
        linkedResultsTwin: result.linkedResultsTwin,
        fieldList: result.fieldList,
        noIndexRobots: result.noIndexRobots,
        primaryDocs: result.primaryDocs,
        resource: result.resource,
        seekForHoldings: result.seekForHoldings,
        templateLabel: result.templateLabel,
        worksKeyResults: result.worksKeyResults);
  }

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        compactResult: json["CompactResult"],
        customResult: json["CustomResult"],
        friendlyUrl: json["FriendlyUrl"],
        groupedResults:
            List<dynamic>.from(json["GroupedResults"].map((x) => x)),
        hasDigitalReady: json["HasDigitalReady"],
        hasPrimaryDocs: json["HasPrimaryDocs"],
        highLights: Suggestions.fromJson(json["HighLights"]),
        linkedResultsTwin:
            LinkedResultsTwin.fromJson(json["LinkedResultsTwin"]),
        noIndexRobots: json["NoIndexRobots"],
        primaryDocs: json["PrimaryDocs"],
        resource: json["Resource"],
        seekForHoldings: json["SeekForHoldings"],
        templateLabel: templateLabelValues.map[json["TemplateLabel"]]!,
        worksKeyResults:
            List<dynamic>.from(json["WorksKeyResults"].map((x) => x)),
        fieldList: json["FieldList"],
      );

  Map<String, dynamic> toJson() => {
        "CompactResult": compactResult,
        "CustomResult": customResult,
        "FriendlyUrl": friendlyUrl,
        "GroupedResults": List<dynamic>.from(groupedResults!.map((x) => x)),
        "HasDigitalReady": hasDigitalReady,
        "HasPrimaryDocs": hasPrimaryDocs,
        "HighLights": highLights!.toJson(),
        "LinkedResultsTwin": linkedResultsTwin!.toJson(),
        "NoIndexRobots": noIndexRobots,
        "PrimaryDocs": primaryDocs,
        "Resource": Resource,
        "SeekForHoldings": seekForHoldings,
        "TemplateLabel": templateLabelValues.reverse[templateLabel],
        "WorksKeyResults": List<dynamic>.from(worksKeyResults!.map((x) => x)),
      };

  factory Result.fromMap(Map<String, dynamic> map) {
    return Result(
      compactResult: map['compactResult'] as String,
      customResult: map['customResult'] as String,
      friendlyUrl: map['friendlyUrl'] as String,
      groupedResults: map['GroupedResults'] as List<dynamic>,
      hasDigitalReady: map['hasDigitalReady'] as bool,
      hasPrimaryDocs: map['hasPrimaryDocs'] as bool,
      resource: map['Resource'] as Resource,
    );
  }
}

class FieldList {
  FieldList(
      {this.tITREP,
      this.typeOfDocument_exact,
      this.author,
      this.author_exact,
      this.funds,
      this.ean,
      this.date,
      this.thumbSmall,
      this.language,
      this.numberOfDigitalNotices,
      this.digitalReadyIsEntryPoint,
      this.urlViewerDR,
      this.zIPURL,
      this.hasZipUrl,
      this.getZipUri,
      this.getZipLabel,
      this.croppedTitle,
      this.image,
      this.reverseHaveImage,
      this.shortDesc,
      this.getPhysicalDescription,
      this.cMAMARTISTE,
      this.physicalDescription,
      this.subjectLocation,
      this.dateStart_idx,
      this.dateEnd_idx,
      this.dateTime_String,
      this.haveDateTime,
      this.thumbMedium,
      this.thumbLarge,
      this.subjectTopic_exact,
      this.subjectTopicFirstUpper,
      this.identifier});

  String? tITREP;
  String? typeOfDocument_exact;
  String? author;
  String? author_exact;
  String? funds;
  String? ean;
  String? date;
  String? thumbSmall;
  String? language;
  String? numberOfDigitalNotices;
  String? digitalReadyIsEntryPoint;
  String? urlViewerDR;
  String? zIPURL;
  bool? hasZipUrl;
  String? getZipUri;
  String? getZipLabel;
  String? croppedTitle;
  String? image;
  bool? reverseHaveImage;
  String? shortDesc;
  String? getPhysicalDescription;
  String? cMAMARTISTE;
  String? physicalDescription;
  String? subjectLocation;
  String? dateStart_idx;
  String? dateEnd_idx;
  String? dateTime_String;
  bool? haveDateTime;
  String? thumbMedium;
  String? thumbLarge;
  String? subjectTopic_exact;
  String? subjectTopicFirstUpper;
  String? identifier;

  factory FieldList.fromJson(Map<String, dynamic> json) =>
      FieldList(tITREP: json['TITREP'], thumbSmall: json['ThumbSmall']);
}

class Suggestions {
  Suggestions();

  factory Suggestions.fromJson(Map<String, dynamic> json) => Suggestions();

  Map<String, dynamic> toJson() => {};
}

class LinkedResultsTwin {
  LinkedResultsTwin({
    required this.listFormat,
    required this.notices,
  });

  List<dynamic> listFormat;
  List<dynamic> notices;

  factory LinkedResultsTwin.fromJson(Map<String, dynamic> json) =>
      LinkedResultsTwin(
        listFormat: List<dynamic>.from(json["ListFormat"].map((x) => x)),
        notices: List<dynamic>.from(json["Notices"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "ListFormat": List<dynamic>.from(listFormat.map((x) => x)),
        "Notices": List<dynamic>.from(notices.map((x) => x)),
      };
}

class PrimaryDoc {
  PrimaryDoc({
    this.glyphClass,
    this.label,
    this.link,
    this.resourceKey,
    this.resourceParameters,
  });

  String? glyphClass;
  String? label;
  String? link;
  String? resourceKey;
  dynamic? resourceParameters;

  factory PrimaryDoc.fromJson(Map<String, dynamic> json) => PrimaryDoc(
        glyphClass: json["GlyphClass"],
        label: json["Label"],
        link: json["Link"] as String,
        resourceKey: json["ResourceKey"],
        resourceParameters: json["ResourceParameters"],
      );

  Map<String, dynamic> toJson() => {
        "GlyphClass": glyphClass,
        "Label": label,
        "Link": link,
        "ResourceKey": resourceKey,
        "ResourceParameters": resourceParameters,
      };
}

class Resource {
  Resource({
    this.avNt,
    this.blogPostCategories,
    this.blogPostTags,
    this.cmts,
    this.cmtsCt,
    this.crtr,
    this.ctrb,
    this.culture,
    this.dt,
    this.frmt,
    this.iicub,
    this.id,
    this.pbls,
    this.rscBase,
    this.rscId,
    this.rscUid,
    this.site,
    this.status,
    this.subj,
    this.tags,
    this.ttl,
    this.type,
  });

  int? avNt;
  List<dynamic>? blogPostCategories;
  List<dynamic>? blogPostTags;
  List<Cmt>? cmts;
  int? cmtsCt;
  String? crtr;
  String? ctrb;
  int? culture;
  String? dt;
  Frmt? frmt;
  bool? iicub;
  String? id;
  Pbls? pbls;
  RscBase? rscBase;
  String? rscId;
  int? rscUid;
  int? site;
  int? status;
  String? subj;
  List<dynamic>? tags;
  String? ttl;
  String? type;

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        avNt: json["AvNt"],
        blogPostCategories:
            List<dynamic>.from(json["BlogPostCategories"].map((x) => x)),
        blogPostTags: List<dynamic>.from(json["BlogPostTags"].map((x) => x)),
        cmts: List<Cmt>.from(json["Cmts"].map((x) => Cmt.fromJson(x))),
        cmtsCt: json["CmtsCt"],
        crtr: json["Crtr"],
        ctrb: json["Ctrb"],
        culture: json["Culture"],
        dt: json["Dt"],
        frmt: frmtValues.map[json["Frmt"]]!,
        iicub: json["IICUB"],
        id: json["Id"],
        pbls: pblsValues.map[json["Pbls"]]!,
        rscBase: rscBaseValues.map[json["RscBase"]]!,
        rscId: json["RscId"],
        rscUid: json["RscUid"],
        site: json["Site"],
        status: json["Status"],
        subj: json["Subj"],
        tags: List<dynamic>.from(json["Tags"].map((x) => x)),
        ttl: json["Ttl"],
        type: json["Type"],
      );

  Map<String, dynamic> toJson() => {
        "AvNt": avNt,
        "BlogPostCategories":
            List<dynamic>.from(blogPostCategories!.map((x) => x)),
        "BlogPostTags": List<dynamic>.from(blogPostTags!.map((x) => x)),
        "Cmts": List<dynamic>.from(cmts!.map((x) => x.toJson())),
        "CmtsCt": cmtsCt,
        "Crtr": crtr,
        "Ctrb": ctrb,
        "Culture": culture,
        "Dt": dt,
        "Frmt": frmtValues.reverse[frmt],
        "IICUB": iicub,
        "Id": id,
        "Pbls": pblsValues.reverse[pbls],
        "RscBase": rscBaseValues.reverse[rscBase],
        "RscId": rscId,
        "RscUid": rscUid,
        "Site": site,
        "Status": status,
        "Subj": subj,
        "Tags": List<dynamic>.from(tags!.map((x) => x)),
        "Ttl": ttl,
        "Type": type,
      };
}

class Cmt {
  Cmt({
    required this.culture,
    required this.date,
    required this.displayDate,
    required this.factId,
    required this.isProfessional,
    required this.isUsedByUser,
    required this.message,
    required this.nickname,
    required this.note,
    this.notificationMessage,
    required this.promoted,
    required this.resourceId,
    required this.resourceTitle,
    required this.site,
    required this.status,
    required this.statusLabel,
    required this.title,
    required this.uid,
    required this.userPlace,
  });

  int culture;
  DateTime date;
  String displayDate;
  int factId;
  bool isProfessional;
  bool isUsedByUser;
  String message;
  String nickname;
  int note;
  dynamic notificationMessage;
  int promoted;
  int resourceId;
  String resourceTitle;
  int site;
  int status;
  String statusLabel;
  String title;
  int uid;
  String userPlace;

  factory Cmt.fromJson(Map<String, dynamic> json) => Cmt(
        culture: json["Culture"],
        date: DateTime.parse(json["Date"]),
        displayDate: json["DisplayDate"],
        factId: json["FactId"],
        isProfessional: json["IsProfessional"],
        isUsedByUser: json["IsUsedByUser"],
        message: json["Message"],
        nickname: json["Nickname"],
        note: json["Note"],
        notificationMessage: json["NotificationMessage"],
        promoted: json["Promoted"],
        resourceId: json["ResourceId"],
        resourceTitle: json["ResourceTitle"],
        site: json["Site"],
        status: json["Status"],
        statusLabel: json["StatusLabel"],
        title: json["Title"],
        uid: json["Uid"],
        userPlace: json["UserPlace"],
      );

  Map<String, dynamic> toJson() => {
        "Culture": culture,
        "Date": date.toIso8601String(),
        "DisplayDate": displayDate,
        "FactId": factId,
        "IsProfessional": isProfessional,
        "IsUsedByUser": isUsedByUser,
        "Message": message,
        "Nickname": nickname,
        "Note": note,
        "NotificationMessage": notificationMessage,
        "Promoted": promoted,
        "ResourceId": resourceId,
        "ResourceTitle": resourceTitle,
        "Site": site,
        "Status": status,
        "StatusLabel": statusLabel,
        "Title": title,
        "Uid": uid,
        "UserPlace": userPlace,
      };
}

enum Frmt { TITR, ALBM }

final frmtValues = EnumValues({"ALBM": Frmt.ALBM, "TITR": Frmt.TITR});

enum Pbls { EMPTY, PBLS, PURPLE }

final pblsValues = EnumValues(
    {"النغم": Pbls.EMPTY, "بيضافون": Pbls.PBLS, "البشيرالرصايصي": Pbls.PURPLE});

enum RscBase { SYRACUSE }

final rscBaseValues = EnumValues({"SYRACUSE": RscBase.SYRACUSE});

enum Type { TITRE, ALBUM }

final typeValues = EnumValues({"Album": Type.ALBUM, "Titre": Type.TITRE});

enum TemplateLabel { PORTAL_TEMPLATE_SHORT }

final templateLabelValues = EnumValues(
    {"PortalTemplate####SHORT": TemplateLabel.PORTAL_TEMPLATE_SHORT});

class ScenarioDisplayMode {
  ScenarioDisplayMode({
    required this.culture,
    required this.displayCode,
    required this.id,
    required this.isDefault,
    required this.libelleAffichageCf,
    required this.pageSize,
    required this.site,
    required this.sortOrder,
  });

  int culture;
  String displayCode;
  int id;
  bool isDefault;
  String libelleAffichageCf;
  String pageSize;
  int site;
  int sortOrder;

  factory ScenarioDisplayMode.fromJson(Map<String, dynamic> json) =>
      ScenarioDisplayMode(
        culture: json["Culture"],
        displayCode: json["DisplayCode"],
        id: json["Id"],
        isDefault: json["IsDefault"],
        libelleAffichageCf: json["LibelleAffichageCF"],
        pageSize: json["PageSize"],
        site: json["Site"],
        sortOrder: json["SortOrder"],
      );

  Map<String, dynamic> toJson() => {
        "Culture": culture,
        "DisplayCode": displayCode,
        "Id": id,
        "IsDefault": isDefault,
        "LibelleAffichageCF": libelleAffichageCf,
        "PageSize": pageSize,
        "Site": site,
        "SortOrder": sortOrder,
      };
}

class SearchInfo {
  SearchInfo({
    required this.availabilityScopes,
    required this.canUseDsi,
    required this.detailMode,
    required this.exportParamSets,
    required this.facetListInfo,
    required this.gridFilters,
    required this.groupingField,
    required this.menuCollapsedByDefault,
    required this.menuCollapsible,
    required this.nbResults,
    required this.page,
    required this.pageMax,
    required this.pageSizeResult,
    required this.pagination,
    required this.scenarioType,
    required this.searchTime,
    required this.solrInfo,
    required this.totalTime,
  });

  List<dynamic> availabilityScopes;
  bool canUseDsi;
  bool detailMode;
  List<ExportParamSet> exportParamSets;
  List<dynamic> facetListInfo;
  List<dynamic> gridFilters;
  String groupingField;
  bool menuCollapsedByDefault;
  bool menuCollapsible;
  int nbResults;
  int page;
  int pageMax;
  List<int> pageSizeResult;
  List<Pagination> pagination;
  int scenarioType;
  int searchTime;
  SolrInfo solrInfo;
  int totalTime;

  factory SearchInfo.fromJson(Map<String, dynamic> json) => SearchInfo(
        availabilityScopes:
            List<dynamic>.from(json["AvailabilityScopes"].map((x) => x)),
        canUseDsi: json["CanUseDsi"],
        detailMode: json["DetailMode"],
        exportParamSets: List<ExportParamSet>.from(
            json["ExportParamSets"].map((x) => ExportParamSet.fromJson(x))),
        facetListInfo: List<dynamic>.from(json["FacetListInfo"].map((x) => x)),
        gridFilters: List<dynamic>.from(json["GridFilters"].map((x) => x)),
        groupingField: json["GroupingField"],
        menuCollapsedByDefault: json["MenuCollapsedByDefault"],
        menuCollapsible: json["MenuCollapsible"],
        nbResults: json["NBResults"],
        page: json["Page"],
        pageMax: json["PageMax"],
        pageSizeResult: List<int>.from(json["PageSizeResult"].map((x) => x)),
        pagination: List<Pagination>.from(
            json["Pagination"].map((x) => Pagination.fromJson(x))),
        scenarioType: json["ScenarioType"],
        searchTime: json["SearchTime"],
        solrInfo: SolrInfo.fromJson(json["SolrInfo"]),
        totalTime: json["TotalTime"],
      );

  Map<String, dynamic> toJson() => {
        "AvailabilityScopes":
            List<dynamic>.from(availabilityScopes.map((x) => x)),
        "CanUseDsi": canUseDsi,
        "DetailMode": detailMode,
        "ExportParamSets":
            List<dynamic>.from(exportParamSets.map((x) => x.toJson())),
        "FacetListInfo": List<dynamic>.from(facetListInfo.map((x) => x)),
        "GridFilters": List<dynamic>.from(gridFilters.map((x) => x)),
        "GroupingField": groupingField,
        "MenuCollapsedByDefault": menuCollapsedByDefault,
        "MenuCollapsible": menuCollapsible,
        "NBResults": nbResults,
        "Page": page,
        "PageMax": pageMax,
        "PageSizeResult": List<dynamic>.from(pageSizeResult.map((x) => x)),
        "Pagination": List<dynamic>.from(pagination.map((x) => x.toJson())),
        "ScenarioType": scenarioType,
        "SearchTime": searchTime,
        "SolrInfo": solrInfo.toJson(),
        "TotalTime": totalTime,
      };
}

class ExportParamSet {
  ExportParamSet({
    required this.culture,
    required this.exportAssembly,
    required this.exportAssemblyId,
    required this.exportParams,
    required this.id,
    required this.name,
    required this.site,
    required this.sortOrder,
  });

  int culture;
  ExportAssembly exportAssembly;
  int exportAssemblyId;
  List<ExportParam> exportParams;
  int id;
  String name;
  int site;
  int sortOrder;

  factory ExportParamSet.fromJson(Map<String, dynamic> json) => ExportParamSet(
        culture: json["Culture"],
        exportAssembly: ExportAssembly.fromJson(json["ExportAssembly"]),
        exportAssemblyId: json["ExportAssemblyId"],
        exportParams: List<ExportParam>.from(
            json["ExportParams"].map((x) => ExportParam.fromJson(x))),
        id: json["Id"],
        name: json["Name"],
        site: json["Site"],
        sortOrder: json["SortOrder"],
      );

  Map<String, dynamic> toJson() => {
        "Culture": culture,
        "ExportAssembly": exportAssembly.toJson(),
        "ExportAssemblyId": exportAssemblyId,
        "ExportParams": List<dynamic>.from(exportParams.map((x) => x.toJson())),
        "Id": id,
        "Name": name,
        "Site": site,
        "SortOrder": sortOrder,
      };
}

class ExportAssembly {
  ExportAssembly({
    required this.assemblyName,
    required this.code,
    required this.culture,
    required this.id,
    required this.label,
    required this.site,
  });

  String assemblyName;
  String code;
  int culture;
  int id;
  String label;
  int site;

  factory ExportAssembly.fromJson(Map<String, dynamic> json) => ExportAssembly(
        assemblyName: json["AssemblyName"],
        code: json["Code"],
        culture: json["Culture"],
        id: json["Id"],
        label: json["Label"],
        site: json["Site"],
      );

  Map<String, dynamic> toJson() => {
        "AssemblyName": assemblyName,
        "Code": code,
        "Culture": culture,
        "Id": id,
        "Label": label,
        "Site": site,
      };
}

class ExportParam {
  ExportParam({
    required this.culture,
    required this.id,
    required this.name,
    required this.site,
    required this.value,
  });

  int culture;
  int id;
  String name;
  int site;
  String value;

  factory ExportParam.fromJson(Map<String, dynamic> json) => ExportParam(
        culture: json["Culture"],
        id: json["Id"],
        name: json["Name"],
        site: json["Site"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Culture": culture,
        "Id": id,
        "Name": name,
        "Site": site,
        "Value": value,
      };
}

class Pagination {
  Pagination({
    required this.type,
    required this.value,
  });

  int type;
  int value;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        type: json["Type"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Type": type,
        "Value": value,
      };
}

class SolrInfo {
  SolrInfo({
    required this.solrInitialization,
  });

  String solrInitialization;

  factory SolrInfo.fromJson(Map<String, dynamic> json) => SolrInfo(
        solrInitialization: json["SolrInitialization"],
      );

  Map<String, dynamic> toJson() => {
        "SolrInitialization": solrInitialization,
      };
}

class Sort {
  Sort({
    required this.culture,
    required this.defaultOrder,
    required this.field,
    required this.id,
    required this.isDefault,
    required this.label,
    required this.site,
    required this.sortOrder,
  });

  int culture;
  int defaultOrder;
  String field;
  int id;
  bool isDefault;
  String label;
  int site;
  int sortOrder;

  factory Sort.fromJson(Map<String, dynamic> json) => Sort(
        culture: json["Culture"],
        defaultOrder: json["DefaultOrder"],
        field: json["Field"],
        id: json["Id"],
        isDefault: json["IsDefault"],
        label: json["Label"],
        site: json["Site"],
        sortOrder: json["SortOrder"],
      );

  Map<String, dynamic> toJson() => {
        "Culture": culture,
        "DefaultOrder": defaultOrder,
        "Field": field,
        "Id": id,
        "IsDefault": isDefault,
        "Label": label,
        "Site": site,
        "SortOrder": sortOrder,
      };
}

class SpellChecking {
  SpellChecking({
    required this.collation,
    required this.suggestions,
  });

  String collation;
  Suggestions suggestions;

  factory SpellChecking.fromJson(Map<String, dynamic> json) => SpellChecking(
        collation: json["Collation"],
        suggestions: Suggestions.fromJson(json["Suggestions"]),
      );

  Map<String, dynamic> toJson() => {
        "Collation": collation,
        "Suggestions": suggestions.toJson(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
