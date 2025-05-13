
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
//   int carrierID;
//   String carrierName;
//   String containers;
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
//     this.carrierID = 0,
//     this.carrierName = '',
//     this.containers = '',
//   });

//   /// Dùng khi thêm dòng mới
//   static AdvancePaymentDetail defaultDetail() {
//     return AdvancePaymentDetail(
//       id: 0,
//       description: '',
//       hblNo: '',
//       amountNumber: 0,
//       amountString: '',
//       curencyType: 'VND',
//       exchangeRate: 1,
//       intoMoney: 0,
//       requestDate: DateTime.now().toIso8601String(), // set mặc định là ngày hiện tại
//       contractNo: '',
//       isDM: false,
//       isHD: false,
//       isOther: false,
//       carrierID: 0,
//       carrierName: '',
//       containers: '',
//     );
//   }

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'description': description,
//         'hblNo': hblNo,
//         'amountNumber': amountNumber,
//         'amountString': amountString,
//         'curencyType': curencyType,
//         'exchangeRate': exchangeRate,
//         'intoMoney': intoMoney,
//         'requestDate': requestDate,
//         'contractNo': contractNo,
//         'isDM': isDM,
//         'isHD': isHD,
//         'isOther': isOther,
//         'carrierID':carrierID,
//         'carrierName':carrierName,
//         'containers' : containers,
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
  int jobId;
  int carrierId;
 String carrierName; // Thêm carrierName vào model chính


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
    this.carrierId = 0,
    this.jobId = 0,

    this.carrierName = ''
  });

  static AdvancePaymentDetail defaultDetail() {
    return AdvancePaymentDetail(
      requestDate: DateTime.now().toIso8601String(),
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
        'jobId': jobId,
        'carrierName':carrierName,
        'carrierId':carrierId
      };
}
