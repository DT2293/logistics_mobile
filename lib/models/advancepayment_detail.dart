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
