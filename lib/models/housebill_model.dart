class FwHouseBill {
  int mblId;
  String mblNo;
  String mblType;
  int hblType;
  int jobId;
  String bookingReferenceNo;
  double freightAmount;
  int exRef;
  String referenceNo;
  String containers;
  int qty;
  int unitId;
  double gw;
  double nt;
  double cbm;
  String descriptionMBL;
  String closeDate;
  String sallingDate;
  int commodityId;
  String commodityDetail;
  int sourceId;
  String quotationNo;
  bool isDelete;
  int customerPayerId;
  String customerPayerInfo;
  bool isOwnerShipper;
  int customerShipperId;
  String customerShipperInfo;
  int customerConsigneeId;
  String customerConsigneeInfo;
  int notifyParty;
  String notifyPartyInfo;
  String porId;
  String porName;
  String finalDestimation;
  String plr;
  String pld;
  String countryOriginId;
  String typeOfMovie;
  String freightpayable;
  int numberOfOriginalB;
  int deliveryOfGoodId;
  String deliveryOfGoodInfo;
  String containerNoSeaNo;
  String onBoardStatus;
  String shippingMark;
  String inword;
  String hsCode;
  String pkgs;
  String listContainers;
  List<LstHouseBillDetail> lstHouseBillDetails;

  FwHouseBill({
    required this.mblId,
    required this.mblNo,
    required this.mblType,
    required this.hblType,
    required this.jobId,
    required this.bookingReferenceNo,
    required this.freightAmount,
    required this.exRef,
    required this.referenceNo,
    required this.containers,
    required this.qty,
    required this.unitId,
    required this.gw,
    required this.nt,
    required this.cbm,
    required this.descriptionMBL,
    required this.closeDate,
    required this.sallingDate,
    required this.commodityId,
    required this.commodityDetail,
    required this.sourceId,
    required this.quotationNo,
    required this.isDelete,
    required this.customerPayerId,
    required this.customerPayerInfo,
    required this.isOwnerShipper,
    required this.customerShipperId,
    required this.customerShipperInfo,
    required this.customerConsigneeId,
    required this.customerConsigneeInfo,
    required this.notifyParty,
    required this.notifyPartyInfo,
    required this.porId,
    required this.porName,
    required this.finalDestimation,
    required this.plr,
    required this.pld,
    required this.countryOriginId,
    required this.typeOfMovie,
    required this.freightpayable,
    required this.numberOfOriginalB,
    required this.deliveryOfGoodId,
    required this.deliveryOfGoodInfo,
    required this.containerNoSeaNo,
    required this.onBoardStatus,
    required this.shippingMark,
    required this.inword,
    required this.hsCode,
    required this.pkgs,
    required this.listContainers,
    required this.lstHouseBillDetails,
  });

  factory FwHouseBill.fromJson(Map<String, dynamic> json) {
    return FwHouseBill(
      mblId: json['mblId'],
      mblNo: json['mblNo'],
      mblType: json['mblType'],
      hblType: json['hblType'],
      jobId: json['jobId'],
      bookingReferenceNo: json['bookingReferenceNo'],
      freightAmount: (json['freightAmount'] as num).toDouble(),
      exRef: json['exRef'],
      referenceNo: json['referenceNo'],
      containers: json['containers'],
      qty: json['qty'],
      unitId: json['unitId'],
      gw: (json['gw'] as num).toDouble(),
      nt: (json['nt'] as num).toDouble(),
      cbm: (json['cbm'] as num).toDouble(),
      descriptionMBL: json['descriptionMBL'],
      closeDate: json['closeDate'],
      sallingDate: json['sallingDate'],
      commodityId: json['commodityId'],
      commodityDetail: json['commodityDetail'],
      sourceId: json['sourceId'],
      quotationNo: json['quotationNo'],
      isDelete: json['isDelete'],
      customerPayerId: json['customerPayerId'],
      customerPayerInfo: json['customerPayerInfo'],
      isOwnerShipper: json['isOwnerShipper'],
      customerShipperId: json['customerShipperId'],
      customerShipperInfo: json['customerShipperInfo'],
      customerConsigneeId: json['customerConsigneeId'],
      customerConsigneeInfo: json['customerConsigneeInfo'],
      notifyParty: json['notifyParty'],
      notifyPartyInfo: json['notifyPartyInfo'],
      porId: json['porId'],
      porName: json['porName'],
      finalDestimation: json['finalDestimation'],
      plr: json['plr'],
      pld: json['pld'],
      countryOriginId: json['countryOriginId'],
      typeOfMovie: json['typeOfMovie'],
      freightpayable: json['freightpayable'],
      numberOfOriginalB: json['numberOfOriginalB'],
      deliveryOfGoodId: json['deliveryOfGoodId'],
      deliveryOfGoodInfo: json['deliveryOfGoodInfo'],
      containerNoSeaNo: json['containerNoSeaNo'],
      onBoardStatus: json['onBoardStatus'],
      shippingMark: json['shippingMark'],
      inword: json['inword'],
      hsCode: json['hsCode'],
      pkgs: json['pkgs'],
      listContainers: json['listContainers'],
      lstHouseBillDetails: (json['lstHouseBillDetails'] as List)
          .map((e) => LstHouseBillDetail.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'mblId': mblId,
        'mblNo': mblNo,
        'mblType': mblType,
        'hblType': hblType,
        'jobId': jobId,
        'bookingReferenceNo': bookingReferenceNo,
        'freightAmount': freightAmount,
        'exRef': exRef,
        'referenceNo': referenceNo,
        'containers': containers,
        'qty': qty,
        'unitId': unitId,
        'gw': gw,
        'nt': nt,
        'cbm': cbm,
        'descriptionMBL': descriptionMBL,
        'closeDate': closeDate,
        'sallingDate': sallingDate,
        'commodityId': commodityId,
        'commodityDetail': commodityDetail,
        'sourceId': sourceId,
        'quotationNo': quotationNo,
        'isDelete': isDelete,
        'customerPayerId': customerPayerId,
        'customerPayerInfo': customerPayerInfo,
        'isOwnerShipper': isOwnerShipper,
        'customerShipperId': customerShipperId,
        'customerShipperInfo': customerShipperInfo,
        'customerConsigneeId': customerConsigneeId,
        'customerConsigneeInfo': customerConsigneeInfo,
        'notifyParty': notifyParty,
        'notifyPartyInfo': notifyPartyInfo,
        'porId': porId,
        'porName': porName,
        'finalDestimation': finalDestimation,
        'plr': plr,
        'pld': pld,
        'countryOriginId': countryOriginId,
        'typeOfMovie': typeOfMovie,
        'freightpayable': freightpayable,
        'numberOfOriginalB': numberOfOriginalB,
        'deliveryOfGoodId': deliveryOfGoodId,
        'deliveryOfGoodInfo': deliveryOfGoodInfo,
        'containerNoSeaNo': containerNoSeaNo,
        'onBoardStatus': onBoardStatus,
        'shippingMark': shippingMark,
        'inword': inword,
        'hsCode': hsCode,
        'pkgs': pkgs,
        'listContainers': listContainers,
        'lstHouseBillDetails': lstHouseBillDetails.map((e) => e.toJson()).toList(),
      };
}

class LstHouseBillDetail {
  int mblDetailId;
  int mblId;
  String containerNo;
  String sealNo;
  String packageStyle;
  String pkgs;
  String descriptionOfGoods;
  String size;
  int qty;
  double aw;
  double dw;
  double pw;
  int unitId;
  int containerId;
  String commodityStatistics;
  String shippingMark;
  String remarks;
  bool isDelete;
  String markNo;

  LstHouseBillDetail({
    required this.mblDetailId,
    required this.mblId,
    required this.containerNo,
    required this.sealNo,
    required this.packageStyle,
    required this.pkgs,
    required this.descriptionOfGoods,
    required this.size,
    required this.qty,
    required this.aw,
    required this.dw,
    required this.pw,
    required this.unitId,
    required this.containerId,
    required this.commodityStatistics,
    required this.shippingMark,
    required this.remarks,
    required this.isDelete,
    required this.markNo,
  });

  factory LstHouseBillDetail.fromJson(Map<String, dynamic> json) {
    return LstHouseBillDetail(
      mblDetailId: json['mblDetailId'],
      mblId: json['mblId'],
      containerNo: json['containerNo'],
      sealNo: json['sealNo'],
      packageStyle: json['packageStyle'],
      pkgs: json['pkgs'],
      descriptionOfGoods: json['descriptionOfGoods'],
      size: json['size'],
      qty: json['qty'],
      aw: (json['aw'] as num).toDouble(),
      dw: (json['dw'] as num).toDouble(),
      pw: (json['pw'] as num).toDouble(),
      unitId: json['unitId'],
      containerId: json['containerId'],
      commodityStatistics: json['commodityStatistics'],
      shippingMark: json['shippingMark'],
      remarks: json['remarks'],
      isDelete: json['isDelete'],
      markNo: json['markNo'],
    );
  }

  Map<String, dynamic> toJson() => {
        'mblDetailId': mblDetailId,
        'mblId': mblId,
        'containerNo': containerNo,
        'sealNo': sealNo,
        'packageStyle': packageStyle,
        'pkgs': pkgs,
        'descriptionOfGoods': descriptionOfGoods,
        'size': size,
        'qty': qty,
        'aw': aw,
        'dw': dw,
        'pw': pw,
        'unitId': unitId,
        'containerId': containerId,
        'commodityStatistics': commodityStatistics,
        'shippingMark': shippingMark,
        'remarks': remarks,
        'isDelete': isDelete,
        'markNo': markNo,
      };
}
