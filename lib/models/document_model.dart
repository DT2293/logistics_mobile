class FwDocumentationViewModel {
   final List<dynamic> items;
  int? jobId;
  String? jobNo;
  int? typesImpExpId;
  String? createdDate;
  String? etaDate;
  String? bookingNo;
  int? controlOfGoodId;
  String? freightType;
  String? billNo;
  int? typeMBL;
  String? poltsId;
  String? podtsId;
  String? tsName;
  String? polId;
  String? polName;
  String? podId;
  String? podName;
  String? podischargeId;
  String? podischargeName;
  int? customerShipperId;
  String? customerShipperInfo;
  String? realShipperInfo;
  int? customerConsigneeId;
  String? customerConsigneeInfo;
  String? realConsigneeInfo;
  String? service;
  String? etd;
  String? eta;
  String? etats;
  String? etdts;
  int? carrierId;
  String? carrierName;
  int? agentId;
  String? agentName;
  String? vessel;
  String? voy;
  String? oVessel;
  String? oVoy;
  String? delivery;
  bool? fullJob;
  int? qty;
  double? gw;
  double? nw;
  double? cbm;
  String? containers;
  int? commodityId;
  String? commodityName;
  String? poNo;
  String? notes;
  bool? isActive;
  int? jobStatus;
  String? attn;
  int? notifyParty;
  String? notifyPartyInfo;
  String? shipmmentGeneral;
  String? shipmmentBlClause;
  String? attachedList;
  String? dataEcusNo;
  String? containerAndSealNo;
  String? descriptionOfGood;
  String? packages;
  double? gwContainer;
  double? cbmContainer;
  String? moveType;
  String? userId;
  String? routingAir;
  int? unitId;
  String? coLoader;
  String? scn;
  List<FwDocumentationUser>? fwDocumentationUsers;
  List<FwHouseBillViewModel>? fwHouseBills;
  List<FwLGBuyingViewModel>? fwLGBuyings;
  List<FwOtherDebitViewModel>? fwOtherDebit;
  List<FwOtherCreditViewModel>? fwOtherCredit;
  List<FwLGSellingViewModel>? fwLGSellings;
  String? salesmanId;
  String? csUsersId;

  FwDocumentationViewModel({
    this.jobId,
    this.jobNo,
    this.typesImpExpId,
    this.createdDate,
    this.etaDate,
    this.bookingNo,
    this.controlOfGoodId,
    this.freightType,
    this.billNo,
    this.typeMBL,
    this.poltsId,
    this.podtsId,
    this.tsName,
    this.polId,
    this.polName,
    this.podId,
    this.podName,
    this.podischargeId,
    this.podischargeName,
    this.customerShipperId,
    this.customerShipperInfo,
    this.realShipperInfo,
    this.customerConsigneeId,
    this.customerConsigneeInfo,
    this.realConsigneeInfo,
    this.service,
    this.etd,
    this.eta,
    this.etats,
    this.etdts,
    this.carrierId,
    this.carrierName,
    this.agentId,
    this.agentName,
    this.vessel,
    this.voy,
    this.oVessel,
    this.oVoy,
    this.delivery,
    this.fullJob,
    this.qty,
    this.gw,
    this.nw,
    this.cbm,
    this.containers,
    this.commodityId,
    this.commodityName,
    this.poNo,
    this.notes,
    this.isActive,
    this.jobStatus,
    this.attn,
    this.notifyParty,
    this.notifyPartyInfo,
    this.shipmmentGeneral,
    this.shipmmentBlClause,
    this.attachedList,
    this.dataEcusNo,
    this.containerAndSealNo,
    this.descriptionOfGood,
    this.packages,
    this.gwContainer,
    this.cbmContainer,
    this.moveType,
    this.userId,
    this.routingAir,
    this.unitId,
    this.coLoader,
    this.scn,
    this.fwDocumentationUsers,
    this.fwHouseBills,
    this.fwLGBuyings,
    this.fwOtherDebit,
    this.fwOtherCredit,
    this.fwLGSellings,
    this.salesmanId,
    this.csUsersId,
    required this.items
  });

  factory FwDocumentationViewModel.fromJson(Map<String, dynamic> json) {
    return FwDocumentationViewModel(
      jobId: json['jobId'],
      jobNo: json['jobNo'],
      typesImpExpId: json['typesImpExpId'],
      createdDate: json['createdDate'],
      etaDate: json['etaDate'],
      bookingNo: json['bookingNo'],
      controlOfGoodId: json['controlOfGoodId'],
      freightType: json['freightType'],
      billNo: json['billNo'],
      typeMBL: json['typeMBL'],
      poltsId: json['poltsId'],
      podtsId: json['podtsId'],
      tsName: json['tsName'],
      polId: json['polId'],
      polName: json['polName'],
      podId: json['podId'],
      podName: json['podName'],
      podischargeId: json['podischargeId'],
      podischargeName: json['podischargeName'],
      customerShipperId: json['customerShipperId'],
      customerShipperInfo: json['customerShipperInfo'],
      realShipperInfo: json['realShipperInfo'],
      customerConsigneeId: json['customerConsigneeId'],
      customerConsigneeInfo: json['customerConsigneeInfo'],
      realConsigneeInfo: json['realConsigneeInfo'],
      service: json['service'],
      etd: json['etd'],
      eta: json['eta'],
      etats: json['etats'],
      etdts: json['etdts'],
      carrierId: json['carrierId'],
      carrierName: json['carrierName'],
      agentId: json['agentId'],
      agentName: json['agentName'],
      vessel: json['vessel'],
      voy: json['voy'],
      oVessel: json['oVessel'],
      oVoy: json['oVoy'],
      delivery: json['delivery'],
      fullJob: json['fullJob'],
      qty: json['qty'],
      gw: (json['gw'] as num?)?.toDouble(),
      nw: (json['nw'] as num?)?.toDouble(),
      cbm: (json['cbm'] as num?)?.toDouble(),
      containers: json['containers'],
      commodityId: json['commodityId'],
      commodityName: json['commodityName'],
      poNo: json['poNo'],
      notes: json['notes'],
      isActive: json['isActive'],
      jobStatus: json['jobStatus'],
      attn: json['attn'],
      notifyParty: json['notifyParty'],
      notifyPartyInfo: json['notifyPartyInfo'],
      shipmmentGeneral: json['shipmmentGeneral'],
      shipmmentBlClause: json['shipmmentBlClause'],
      attachedList: json['attachedList'],
      dataEcusNo: json['dataEcusNo'],
      containerAndSealNo: json['containerAndSealNo'],
      descriptionOfGood: json['descriptionOfGood'],
      packages: json['packages'],
      gwContainer: (json['gwContainer'] as num?)?.toDouble(),
      cbmContainer: (json['cbmContainer'] as num?)?.toDouble(),
      moveType: json['moveType'],
      userId: json['userId'],
      routingAir: json['routingAir'],
      unitId: json['unitId'],
      coLoader: json['coLoader'],
      scn: json['scn'],
      items: json['items'] ?? [],
      fwDocumentationUsers: (json['fwDocumentationUsers'] as List?)?.map((e) => FwDocumentationUser.fromJson(e)).toList(),
      fwHouseBills: (json['fwHouseBills'] as List?)?.map((e) => FwHouseBillViewModel.fromJson(e)).toList(),
      fwLGBuyings: (json['fwLGBuyings'] as List?)?.map((e) => FwLGBuyingViewModel.fromJson(e)).toList(),
      fwOtherDebit: (json['fwOtherDebit'] as List?)?.map((e) => FwOtherDebitViewModel.fromJson(e)).toList(),
      fwOtherCredit: (json['fwOtherCredit'] as List?)?.map((e) => FwOtherCreditViewModel.fromJson(e)).toList(),
      fwLGSellings: (json['fwLGSellings'] as List?)?.map((e) => FwLGSellingViewModel.fromJson(e)).toList(),
      salesmanId: json['salesmanId'],
      csUsersId: json['csUsersId'],
    );
  }
}

class FwDocumentationUser {
  String? userId;
  String? departmentName;

  FwDocumentationUser({this.userId, this.departmentName});

  factory FwDocumentationUser.fromJson(Map<String, dynamic> json) {
    return FwDocumentationUser(
      userId: json['userId'],
      departmentName: json['departmentName'],
    );
  }
}

class FwHouseBillViewModel {
  String? billNo;
  String? billDate;

  FwHouseBillViewModel({this.billNo, this.billDate});

  factory FwHouseBillViewModel.fromJson(Map<String, dynamic> json) {
    return FwHouseBillViewModel(
      billNo: json['billNo'],
      billDate: json['billDate'],
    );
  }
}

class FwLGBuyingViewModel {
  String? buyingNo;

  FwLGBuyingViewModel({this.buyingNo});

  factory FwLGBuyingViewModel.fromJson(Map<String, dynamic> json) {
    return FwLGBuyingViewModel(
      buyingNo: json['buyingNo'],
    );
  }
}

class FwOtherDebitViewModel {
  String? debitNo;

  FwOtherDebitViewModel({this.debitNo});

  factory FwOtherDebitViewModel.fromJson(Map<String, dynamic> json) {
    return FwOtherDebitViewModel(
      debitNo: json['debitNo'],
    );
  }
}

class FwOtherCreditViewModel {
  String? creditNo;

  FwOtherCreditViewModel({this.creditNo});

  factory FwOtherCreditViewModel.fromJson(Map<String, dynamic> json) {
    return FwOtherCreditViewModel(
      creditNo: json['creditNo'],
    );
  }
}

class FwLGSellingViewModel {
  String? sellingNo;

  FwLGSellingViewModel({this.sellingNo});

  factory FwLGSellingViewModel.fromJson(Map<String, dynamic> json) {
    return FwLGSellingViewModel(
      sellingNo: json['sellingNo'],
    );
  }
}
