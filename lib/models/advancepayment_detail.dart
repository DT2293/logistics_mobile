// class AdvancePaymentDetail {
//   int id;
//   String description;
//   String hblNo;
//   double amountNumber;
//   String amountString;
//   String curencyType;
//   double exchangeRate;
//   double intoMoney;
//   String requestDate;
//   String contractNo;
//   bool isDM;
//   bool isHD;
//   bool isOther;

//   AdvancePaymentDetail({
//     this.id = 0,
//     this.description = '',
//     this.hblNo = '',
//     this.amountNumber = 0,
//     this.amountString = '',
//     this.curencyType = 'VND',
//     this.exchangeRate = 1,
//     this.intoMoney = 0,
//     this.requestDate = '',
//     this.contractNo = '',
//     this.isDM = false,
//     this.isHD = false,
//     this.isOther = false,
//   });

//   Map<String, dynamic> toJson() => {
//     'id': id,
//     'description': description,
//     'hblNo': hblNo,
//     'amountNumber': amountNumber,
//     'amountString': amountString,
//     'curencyType': curencyType,
//     'exchangeRate': exchangeRate,
//     'intoMoney': intoMoney,
//     'requestDate': requestDate,
//     'contractNo': contractNo,
//     'isDM': isDM,
//     'isHD': isHD,
//     'isOther': isOther,
//   };
// }

// class AdvancePaymentRequest {
//   int advancePaymentRequestId;
//   String advancePaymentNo;
//   int deparmentId;
//   String jobId;
//   String advancePaymentDate;
//   int advancePaymentType;
//   String curencyType;
//   double advanceAmountNumber;
//   String advanceAmountString;
//   String description;
//   String applicant;
//   String applicantDate;
//   List<AdvancePaymentDetail> lstDetail;

//   AdvancePaymentRequest({
//     this.advancePaymentRequestId = 0,
//     required this.advancePaymentNo,
//     required this.deparmentId,
//     required this.jobId,
//     required this.advancePaymentDate,
//     this.advancePaymentType = 0,
//     this.curencyType = "VND",
//     required this.advanceAmountNumber,
//     required this.advanceAmountString,
//     required this.description,
//     required this.applicant,
//     required this.applicantDate,
//     required this.lstDetail,
//   });

//   Map<String, dynamic> toJson() => {
//         "advancePaymentRequestId": advancePaymentRequestId,
//         "advancePaymentNo": advancePaymentNo,
//         "deparmentId": deparmentId,
//         "jobId": jobId,
//         "advancePaymentDate": advancePaymentDate,
//         "advancePaymentType": advancePaymentType,
//         "curencyType": curencyType,
//         "advanceAmountNumber": advanceAmountNumber,
//         "advanceAmountString": advanceAmountString,
//         "description": description,
//         "applicant": applicant,
//         "applicantDate": applicantDate,
//         "lstDetail": lstDetail.map((e) => e.toJson()).toList(),
//       };
// }


class AdvancePaymentDetail {
  int id;
  String description;
  String hblNo;
  double amountNumber;
  String amountString;
  String curencyType;
  double exchangeRate;
  double intoMoney;
  String requestDate;
  String contractNo;
  bool isDM;
  bool isHD;
  bool isOther;

  AdvancePaymentDetail({
    this.id = 0,
    this.description = '',
    this.hblNo = '',
    this.amountNumber = 0,
    this.amountString = '',
    this.curencyType = 'VND',
    this.exchangeRate = 1,
    this.intoMoney = 0,
    this.requestDate = '',
    this.contractNo = '',
    this.isDM = false,
    this.isHD = false,
    this.isOther = false,
  });

  /// Dùng khi thêm dòng mới
  static AdvancePaymentDetail defaultDetail() {
    return AdvancePaymentDetail(
      id: 0,
      description: '',
      hblNo: '',
      amountNumber: 0,
      amountString: '',
      curencyType: 'VND',
      exchangeRate: 1,
      intoMoney: 0,
      requestDate: DateTime.now().toIso8601String(), // set mặc định là ngày hiện tại
      contractNo: '',
      isDM: false,
      isHD: false,
      isOther: false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'description': description,
        'hblNo': hblNo,
        'amountNumber': amountNumber,
        'amountString': amountString,
        'curencyType': curencyType,
        'exchangeRate': exchangeRate,
        'intoMoney': intoMoney,
        'requestDate': requestDate,
        'contractNo': contractNo,
        'isDM': isDM,
        'isHD': isHD,
        'isOther': isOther,
      };
}
