import 'dart:convert';

BasketResult basketResultFromJson(String str) =>
    BasketResult.fromJson(json.decode(str));

String basketResultToJson(BasketResult data) => json.encode(data.toJson());

class BasketResult {
  List<Timer> timers;
  List<dynamic> errors;
  dynamic message;
  bool success;
  D d;

  BasketResult({
    required this.timers,
    required this.errors,
    this.message,
    required this.success,
    required this.d,
  });

  factory BasketResult.fromJson(Map<String, dynamic> json) => BasketResult(
        timers: List<Timer>.from(json["Timers"].map((x) => Timer.fromJson(x))),
        errors: List<dynamic>.from(json["errors"].map((x) => x)),
        message: json["message"],
        success: json["success"],
        d: D.fromJson(json["d"]),
      );

  Map<String, dynamic> toJson() => {
        "Timers": List<dynamic>.from(timers.map((x) => x.toJson())),
        "errors": List<dynamic>.from(errors.map((x) => x)),
        "message": message,
        "success": success,
        "d": d.toJson(),
      };
}

class D {
  String htmlResult;
  Query query;
  List<Result> results;
  SearchInfo searchInfo;
  int totalBasketCount;
  List<Label> userLabels;

  D({
    required this.htmlResult,
    required this.query,
    required this.results,
    required this.searchInfo,
    required this.totalBasketCount,
    required this.userLabels,
  });

  factory D.fromJson(Map<String, dynamic> json) => D(
        htmlResult: json["HtmlResult"],
        query: Query.fromJson(json["Query"]),
        results:
            List<Result>.from(json["Results"].map((x) => Result.fromJson(x))),
        searchInfo: SearchInfo.fromJson(json["SearchInfo"]),
        totalBasketCount: json["TotalBasketCount"],
        userLabels:
            List<Label>.from(json["UserLabels"].map((x) => Label.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "HtmlResult": htmlResult,
        "Query": query.toJson(),
        "Results": List<dynamic>.from(results.map((x) => x.toJson())),
        "SearchInfo": searchInfo.toJson(),
        "TotalBasketCount": totalBasketCount,
        "UserLabels": List<dynamic>.from(userLabels.map((x) => x.toJson())),
      };
}

class Query {
  List<dynamic> labelFilter;
  int page;
  int resultSize;
  String searchInput;
  TemplateParams templateParams;

  Query({
    required this.labelFilter,
    required this.page,
    required this.resultSize,
    required this.searchInput,
    required this.templateParams,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
        labelFilter: List<dynamic>.from(json["LabelFilter"].map((x) => x)),
        page: json["Page"],
        resultSize: json["ResultSize"],
        searchInput: json["SearchInput"],
        templateParams: TemplateParams.fromJson(json["TemplateParams"]),
      );

  Map<String, dynamic> toJson() => {
        "LabelFilter": List<dynamic>.from(labelFilter.map((x) => x)),
        "Page": page,
        "ResultSize": resultSize,
        "SearchInput": searchInput,
        "TemplateParams": templateParams.toJson(),
      };
}

class TemplateParams {
  String scenario;
  String scope;
  dynamic size;
  String source;
  String support;
  bool useCompact;

  TemplateParams({
    required this.scenario,
    required this.scope,
    this.size,
    required this.source,
    required this.support,
    required this.useCompact,
  });

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

class Result {
  String compactResult;
  String customResult;
  String friendlyUrl;
  List<dynamic> groupedResults;
  bool hasDigitalReady;
  bool hasPrimaryDocs;
  HighLights highLights;
  LinkedResultsTwin linkedResultsTwin;
  List<dynamic> listKeyValueOfResource;
  bool noIndexRobots;
  List<PrimaryDoc> primaryDocs;
  Resource resource;
  bool seekForHoldings;
  String templateLabel;
  List<dynamic> worksKeyResults;
  List<Label> labels;

  Result({
    required this.compactResult,
    required this.customResult,
    required this.friendlyUrl,
    required this.groupedResults,
    required this.hasDigitalReady,
    required this.hasPrimaryDocs,
    required this.highLights,
    required this.linkedResultsTwin,
    required this.listKeyValueOfResource,
    required this.noIndexRobots,
    required this.primaryDocs,
    required this.resource,
    required this.seekForHoldings,
    required this.templateLabel,
    required this.worksKeyResults,
    required this.labels,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        compactResult: json["CompactResult"],
        customResult: json["CustomResult"],
        friendlyUrl: json["FriendlyUrl"],
        groupedResults:
            List<dynamic>.from(json["GroupedResults"].map((x) => x)),
        hasDigitalReady: json["HasDigitalReady"],
        hasPrimaryDocs: json["HasPrimaryDocs"],
        highLights: HighLights.fromJson(json["HighLights"]),
        linkedResultsTwin:
            LinkedResultsTwin.fromJson(json["LinkedResultsTwin"]),
        listKeyValueOfResource:
            List<dynamic>.from(json["ListKeyValueOfResource"].map((x) => x)),
        noIndexRobots: json["NoIndexRobots"],
        primaryDocs: List<PrimaryDoc>.from(
            json["PrimaryDocs"].map((x) => PrimaryDoc.fromJson(x))),
        resource: Resource.fromJson(json["Resource"]),
        seekForHoldings: json["SeekForHoldings"],
        templateLabel: json["TemplateLabel"],
        worksKeyResults:
            List<dynamic>.from(json["WorksKeyResults"].map((x) => x)),
        labels: List<Label>.from(json["Labels"].map((x) => Label.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "CompactResult": compactResult,
        "CustomResult": customResult,
        "FriendlyUrl": friendlyUrl,
        "GroupedResults": List<dynamic>.from(groupedResults.map((x) => x)),
        "HasDigitalReady": hasDigitalReady,
        "HasPrimaryDocs": hasPrimaryDocs,
        "HighLights": highLights.toJson(),
        "LinkedResultsTwin": linkedResultsTwin.toJson(),
        "ListKeyValueOfResource":
            List<dynamic>.from(listKeyValueOfResource.map((x) => x)),
        "NoIndexRobots": noIndexRobots,
        "PrimaryDocs": List<dynamic>.from(primaryDocs.map((x) => x.toJson())),
        "Resource": resource.toJson(),
        "SeekForHoldings": seekForHoldings,
        "TemplateLabel": templateLabel,
        "WorksKeyResults": List<dynamic>.from(worksKeyResults.map((x) => x)),
        "Labels": List<dynamic>.from(labels.map((x) => x.toJson())),
      };
}

class HighLights {
  HighLights();

  factory HighLights.fromJson(Map<String, dynamic> json) => HighLights();

  Map<String, dynamic> toJson() => {};
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

class LinkedResultsTwin {
  List<dynamic> listFormat;
  List<dynamic> notices;

  LinkedResultsTwin({
    required this.listFormat,
    required this.notices,
  });

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
  String glyphClass;
  String label;
  String link;
  String resourceKey;
  dynamic resourceParameters;

  PrimaryDoc({
    required this.glyphClass,
    required this.label,
    required this.link,
    required this.resourceKey,
    this.resourceParameters,
  });

  factory PrimaryDoc.fromJson(Map<String, dynamic> json) => PrimaryDoc(
        glyphClass: json["GlyphClass"],
        label: json["Label"],
        link: json["Link"],
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
  int avNt;
  List<dynamic> blogPostCategories;
  List<dynamic> blogPostTags;
  List<Cmt> cmts;
  int cmtsCt;
  String crtr;
  int culture;
  String? dt;
  String frmt;
  bool iicub;
  String id;
  String pbls;
  String rscBase;
  String rscId;
  int rscUid;
  int site;
  int status;
  String? subj;
  List<dynamic> tags;
  String ttl;
  String type;
  String? ctrb;

  Resource({
    required this.avNt,
    required this.blogPostCategories,
    required this.blogPostTags,
    required this.cmts,
    required this.cmtsCt,
    required this.crtr,
    required this.culture,
    this.dt,
    required this.frmt,
    required this.iicub,
    required this.id,
    required this.pbls,
    required this.rscBase,
    required this.rscId,
    required this.rscUid,
    required this.site,
    required this.status,
    this.subj,
    required this.tags,
    required this.ttl,
    required this.type,
    this.ctrb,
  });

  factory Resource.fromJson(Map<String, dynamic> json) => Resource(
        avNt: json["AvNt"],
        blogPostCategories:
            List<dynamic>.from(json["BlogPostCategories"].map((x) => x)),
        blogPostTags: List<dynamic>.from(json["BlogPostTags"].map((x) => x)),
        cmts: List<Cmt>.from(json["Cmts"].map((x) => Cmt.fromJson(x))),
        cmtsCt: json["CmtsCt"],
        crtr: json["Crtr"],
        culture: json["Culture"],
        dt: json["Dt"],
        frmt: json["Frmt"],
        iicub: json["IICUB"],
        id: json["Id"],
        pbls: json["Pbls"],
        rscBase: json["RscBase"],
        rscId: json["RscId"],
        rscUid: json["RscUid"],
        site: json["Site"],
        status: json["Status"],
        subj: json["Subj"],
        tags: List<dynamic>.from(json["Tags"].map((x) => x)),
        ttl: json["Ttl"],
        type: json["Type"],
        ctrb: json["Ctrb"],
      );

  Map<String, dynamic> toJson() => {
        "AvNt": avNt,
        "BlogPostCategories":
            List<dynamic>.from(blogPostCategories.map((x) => x)),
        "BlogPostTags": List<dynamic>.from(blogPostTags.map((x) => x)),
        "Cmts": List<dynamic>.from(cmts.map((x) => x.toJson())),
        "CmtsCt": cmtsCt,
        "Crtr": crtr,
        "Culture": culture,
        "Dt": dt,
        "Frmt": frmt,
        "IICUB": iicub,
        "Id": id,
        "Pbls": pbls,
        "RscBase": rscBase,
        "RscId": rscId,
        "RscUid": rscUid,
        "Site": site,
        "Status": status,
        "Subj": subj,
        "Tags": List<dynamic>.from(tags.map((x) => x)),
        "Ttl": ttl,
        "Type": type,
        "Ctrb": ctrb,
      };
}

class Cmt {
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

class SearchInfo {
  List<dynamic> availabilityScopes;
  bool canUseDsi;
  bool detailMode;
  List<ExportParamSet> exportParamSets;
  bool menuCollapsedByDefault;
  bool menuCollapsible;
  int nbResults;
  int page;
  int pageMax;
  dynamic pageSizeResult;
  List<Pagination> pagination;
  PazPar2Info pazPar2Info;
  int scenarioType;
  int searchTime;
  SolrInfo solrInfo;
  int totalTime;

  SearchInfo({
    required this.availabilityScopes,
    required this.canUseDsi,
    required this.detailMode,
    required this.exportParamSets,
    required this.menuCollapsedByDefault,
    required this.menuCollapsible,
    required this.nbResults,
    required this.page,
    required this.pageMax,
    this.pageSizeResult,
    required this.pagination,
    required this.pazPar2Info,
    required this.scenarioType,
    required this.searchTime,
    required this.solrInfo,
    required this.totalTime,
  });

  factory SearchInfo.fromJson(Map<String, dynamic> json) => SearchInfo(
        availabilityScopes:
            List<dynamic>.from(json["AvailabilityScopes"].map((x) => x)),
        canUseDsi: json["CanUseDsi"],
        detailMode: json["DetailMode"],
        exportParamSets: List<ExportParamSet>.from(
            json["ExportParamSets"].map((x) => ExportParamSet.fromJson(x))),
        menuCollapsedByDefault: json["MenuCollapsedByDefault"],
        menuCollapsible: json["MenuCollapsible"],
        nbResults: json["NBResults"],
        page: json["Page"],
        pageMax: json["PageMax"],
        pageSizeResult: json["PageSizeResult"],
        pagination: List<Pagination>.from(
            json["Pagination"].map((x) => Pagination.fromJson(x))),
        pazPar2Info: PazPar2Info.fromJson(json["PazPar2Info"]),
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
        "MenuCollapsedByDefault": menuCollapsedByDefault,
        "MenuCollapsible": menuCollapsible,
        "NBResults": nbResults,
        "Page": page,
        "PageMax": pageMax,
        "PageSizeResult": pageSizeResult,
        "Pagination": List<dynamic>.from(pagination.map((x) => x.toJson())),
        "PazPar2Info": pazPar2Info.toJson(),
        "ScenarioType": scenarioType,
        "SearchTime": searchTime,
        "SolrInfo": solrInfo.toJson(),
        "TotalTime": totalTime,
      };
}

class ExportParamSet {
  int culture;
  ExportAssembly exportAssembly;
  int exportAssemblyId;
  List<ExportParam> exportParams;
  int id;
  String name;
  int site;
  int sortOrder;

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
  String assemblyName;
  String code;
  int culture;
  int id;
  String label;
  int site;

  ExportAssembly({
    required this.assemblyName,
    required this.code,
    required this.culture,
    required this.id,
    required this.label,
    required this.site,
  });

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
  int culture;
  int id;
  String name;
  int site;
  String value;

  ExportParam({
    required this.culture,
    required this.id,
    required this.name,
    required this.site,
    required this.value,
  });

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
  int type;
  int value;

  Pagination({
    required this.type,
    required this.value,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        type: json["Type"],
        value: json["Value"],
      );

  Map<String, dynamic> toJson() => {
        "Type": type,
        "Value": value,
      };
}

class PazPar2Info {
  dynamic activeClients;
  List<dynamic> byTarget;
  dynamic guid;
  Stats stats;

  PazPar2Info({
    this.activeClients,
    required this.byTarget,
    this.guid,
    required this.stats,
  });

  factory PazPar2Info.fromJson(Map<String, dynamic> json) => PazPar2Info(
        activeClients: json["ActiveClients"],
        byTarget: List<dynamic>.from(json["ByTarget"].map((x) => x)),
        guid: json["Guid"],
        stats: Stats.fromJson(json["Stats"]),
      );

  Map<String, dynamic> toJson() => {
        "ActiveClients": activeClients,
        "ByTarget": List<dynamic>.from(byTarget.map((x) => x)),
        "Guid": guid,
        "Stats": stats.toJson(),
      };
}

class Stats {
  int activeClients;
  int clients;
  int connecting;
  int error;
  int failed;
  int hits;
  int idle;
  int progress;
  int records;
  int unconnected;
  int working;

  Stats({
    required this.activeClients,
    required this.clients,
    required this.connecting,
    required this.error,
    required this.failed,
    required this.hits,
    required this.idle,
    required this.progress,
    required this.records,
    required this.unconnected,
    required this.working,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        activeClients: json["ActiveClients"],
        clients: json["Clients"],
        connecting: json["Connecting"],
        error: json["Error"],
        failed: json["Failed"],
        hits: json["Hits"],
        idle: json["Idle"],
        progress: json["Progress"],
        records: json["Records"],
        unconnected: json["Unconnected"],
        working: json["Working"],
      );

  Map<String, dynamic> toJson() => {
        "ActiveClients": activeClients,
        "Clients": clients,
        "Connecting": connecting,
        "Error": error,
        "Failed": failed,
        "Hits": hits,
        "Idle": idle,
        "Progress": progress,
        "Records": records,
        "Unconnected": unconnected,
        "Working": working,
      };
}

class SolrInfo {
  dynamic solrInitialization;

  SolrInfo({
    this.solrInitialization,
  });

  factory SolrInfo.fromJson(Map<String, dynamic> json) => SolrInfo(
        solrInitialization: json["SolrInitialization"],
      );

  Map<String, dynamic> toJson() => {
        "SolrInitialization": solrInitialization,
      };
}

class Timer {
  int duration;
  String label;
  List<TimerChild>? timerChildren;

  Timer({
    required this.duration,
    required this.label,
    this.timerChildren,
  });

  factory Timer.fromJson(Map<String, dynamic> json) => Timer(
        duration: json["Duration"],
        label: json["Label"],
        timerChildren: json["TimerChildren"] == null
            ? []
            : List<TimerChild>.from(
                json["TimerChildren"]!.map((x) => TimerChild.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Duration": duration,
        "Label": label,
        "TimerChildren": timerChildren == null
            ? []
            : List<dynamic>.from(timerChildren!.map((x) => x.toJson())),
      };
}

class TimerChild {
  String? type;
  int duration;
  String label;

  TimerChild({
    this.type,
    required this.duration,
    required this.label,
  });

  factory TimerChild.fromJson(Map<String, dynamic> json) => TimerChild(
        type: json["__type"],
        duration: json["Duration"],
        label: json["Label"],
      );

  Map<String, dynamic> toJson() => {
        "__type": type,
        "Duration": duration,
        "Label": label,
      };
}
