class AdvancePaymentRequestDetail {
  final int id;
  final int advancePaymentRequestId;
  final String description;
  final String hblNo;
  final double amountNumber;
  final String amountString;
  final String curencyType;
  final double exchangeRate;
  final double intoMoney;
  final String requestDate;
  final String contractNo;
  final bool isDM;
  final bool isHD;
  final bool isOther;

  AdvancePaymentRequestDetail({
    required this.id,
    required this.advancePaymentRequestId,
    required this.description,
    required this.hblNo,
    required this.amountNumber,
    required this.amountString,
    required this.curencyType,
    required this.exchangeRate,
    required this.intoMoney,
    required this.requestDate,
    required this.contractNo,
    required this.isDM,
    required this.isHD,
    required this.isOther,
  });

  factory AdvancePaymentRequestDetail.fromJson(Map<String, dynamic> json) {
    return AdvancePaymentRequestDetail(
      id: json['id'] ?? 0,
      advancePaymentRequestId: json['advancePaymentRequestId'] ?? 0,
      description: json['description'] ?? '',
      hblNo: json['hblNo'] ?? '',
      amountNumber: (json['amountNumber'] ?? 0).toDouble(),
      amountString: json['amountString'] ?? '',
      curencyType: json['curencyType'] ?? '',
      exchangeRate: (json['exchangeRate'] ?? 0).toDouble(),
      intoMoney: (json['intoMoney'] ?? 0).toDouble(),
      requestDate: json['requestDate'] ?? '',
      contractNo: json['contractNo'] ?? '',
      isDM: json['isDM'] ?? false,
      isHD: json['isHD'] ?? false,
      isOther: json['isOther'] ?? false,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'advancePaymentRequestId': advancePaymentRequestId,
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
class AdvancePaymentRequest {
  final int id;
  final String salaryAdvanceNo;
  final String salaryAdvanceDate;
  final int salaryAdvanceType;
  final double advanceAmountNumber;
  final String advanceAmountString;
  final String description;
  final String curencyType;
  final int deparmentId;
  final int jobId;
  final String director;
  final String chiefAccountant;
  final String headDepartment;
  final String documentRep;
  final String applicant;
  final String directorDate;
  final String chiefAccountantDate;
  final String headDepartmentDate;
  final String documentRepDate;
  final String applicantDate;
  final bool unclearAdvance;
  final bool isDeleted;
  final List<AdvancePaymentRequestDetail> advancePaymentRequestDetails;

  AdvancePaymentRequest({
    required this.id,
    required this.salaryAdvanceNo,
    required this.salaryAdvanceDate,
    required this.salaryAdvanceType,
    required this.advanceAmountNumber,
    required this.advanceAmountString,
    required this.description,
    required this.curencyType,
    required this.deparmentId,
    required this.jobId,
    required this.director,
    required this.chiefAccountant,
    required this.headDepartment,
    required this.documentRep,
    required this.applicant,
    required this.directorDate,
    required this.chiefAccountantDate,
    required this.headDepartmentDate,
    required this.documentRepDate,
    required this.applicantDate,
    required this.unclearAdvance,
    required this.isDeleted,
    required this.advancePaymentRequestDetails,
  });

  factory AdvancePaymentRequest.fromJson(Map<String, dynamic> json) {
    return AdvancePaymentRequest(
      id: json['id'] ?? 0,
      salaryAdvanceNo: json['salaryAdvanceNo'] ?? '',
      salaryAdvanceDate: json['salaryAdvanceDate'] ?? '',
      salaryAdvanceType: json['salaryAdvanceType'] ?? 0,
      advanceAmountNumber: (json['advanceAmountNumber'] ?? 0).toDouble(),
      advanceAmountString: json['advanceAmountString'] ?? '',
      description: json['description'] ?? '',
      curencyType: json['curencyType'] ?? '',
      deparmentId: json['deparmentId'] ?? 0,
      jobId: json['jobId'] ?? 0,
      director: json['director'] ?? '',
      chiefAccountant: json['chiefAccountant'] ?? '',
      headDepartment: json['headDepartment'] ?? '',
      documentRep: json['documentRep'] ?? '',
      applicant: json['applicant'] ?? '',
      directorDate: json['directorDate'] ?? '',
      chiefAccountantDate: json['chiefAccountantDate'] ?? '',
      headDepartmentDate: json['headDepartmentDate'] ?? '',
      documentRepDate: json['documentRepDate'] ?? '',
      applicantDate: json['applicantDate'] ?? '',
      unclearAdvance: json['unclearAdvance'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      advancePaymentRequestDetails: (json['advancePaymentRequestDetails'] as List<dynamic>?)
              ?.map((e) => AdvancePaymentRequestDetail.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'salaryAdvanceNo': salaryAdvanceNo,
        'salaryAdvanceDate': salaryAdvanceDate,
        'salaryAdvanceType': salaryAdvanceType,
        'advanceAmountNumber': advanceAmountNumber,
        'advanceAmountString': advanceAmountString,
        'description': description,
        'curencyType': curencyType,
        'deparmentId': deparmentId,
        'jobId': jobId,
        'director': director,
        'chiefAccountant': chiefAccountant,
        'headDepartment': headDepartment,
        'documentRep': documentRep,
        'applicant': applicant,
        'directorDate': directorDate,
        'chiefAccountantDate': chiefAccountantDate,
        'headDepartmentDate': headDepartmentDate,
        'documentRepDate': documentRepDate,
        'applicantDate': applicantDate,
        'unclearAdvance': unclearAdvance,
        'isDeleted': isDeleted,
        'advancePaymentRequestDetails':
            advancePaymentRequestDetails.map((e) => e.toJson()).toList(),
      };
}
class AdvancePaymentRequestDetailViewModel {
  final int id;
  final String description;
  final String hblNo;
  final double amountNumber;
  final String amountString;
  final String curencyType;
  final double exchangeRate;
  final double intoMoney;
  final String requestDate;
  final String contractNo;
  final bool isDM;
  final bool isHD;
  final bool isOther;

  AdvancePaymentRequestDetailViewModel({
    required this.id,
    required this.description,
    required this.hblNo,
    required this.amountNumber,
    required this.amountString,
    required this.curencyType,
    required this.exchangeRate,
    required this.intoMoney,
    required this.requestDate,
    required this.contractNo,
    required this.isDM,
    required this.isHD,
    required this.isOther,
  });

  factory AdvancePaymentRequestDetailViewModel.fromJson(Map<String, dynamic> json) {
    return AdvancePaymentRequestDetailViewModel(
      id: json['id'] ?? 0,
      description: json['description'] ?? '',
      hblNo: json['hblNo'] ?? '',
      amountNumber: (json['amountNumber'] ?? 0).toDouble(),
      amountString: json['amountString'] ?? '',
      curencyType: json['curencyType'] ?? '',
      exchangeRate: (json['exchangeRate'] ?? 0).toDouble(),
      intoMoney: (json['intoMoney'] ?? 0).toDouble(),
      requestDate: json['requestDate'] ?? '',
      contractNo: json['contractNo'] ?? '',
      isDM: json['isDM'] ?? false,
      isHD: json['isHD'] ?? false,
      isOther: json['isOther'] ?? false,
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
class AdvancePaymentRequestViewModel {
  final int advancePaymentRequestId;
  final String advancePaymentNo;
  final int deparmentId;
  final int jobId;
  final String advancePaymentDate;
  final int advancePaymentType;
  final String curencyType;
  final double advanceAmountNumber;
  final String advanceAmountString;
  final String description;
  final String director;
  final String chiefAccountant;
  final String headDepartment;
  final String documentRep;
  final String applicant;
  final String directorDate;
  final String chiefAccountantDate;
  final String headDepartmentDate;
  final String documentRepDate;
  final String applicantDate;
  final bool unclearAdvance;
  final bool isDeleted;
  final List<AdvancePaymentRequestDetailViewModel> lstDetail;

  AdvancePaymentRequestViewModel({
    required this.advancePaymentRequestId,
    required this.advancePaymentNo,
    required this.deparmentId,
    required this.jobId,
    required this.advancePaymentDate,
    required this.advancePaymentType,
    required this.curencyType,
    required this.advanceAmountNumber,
    required this.advanceAmountString,
    required this.description,
    required this.director,
    required this.chiefAccountant,
    required this.headDepartment,
    required this.documentRep,
    required this.applicant,
    required this.directorDate,
    required this.chiefAccountantDate,
    required this.headDepartmentDate,
    required this.documentRepDate,
    required this.applicantDate,
    required this.unclearAdvance,
    required this.isDeleted,
    required this.lstDetail,
  });

  factory AdvancePaymentRequestViewModel.fromJson(Map<String, dynamic> json) {
    return AdvancePaymentRequestViewModel(
      advancePaymentRequestId: json['advancePaymentRequestId'] ?? 0,
      advancePaymentNo: json['advancePaymentNo'] ?? '',
      deparmentId: json['deparmentId'] ?? 0,
      jobId: json['jobId'] ?? 0,
      advancePaymentDate: json['advancePaymentDate'] ?? '',
      advancePaymentType: json['advancePaymentType'] ?? 0,
      curencyType: json['curencyType'] ?? '',
      advanceAmountNumber: (json['advanceAmountNumber'] ?? 0).toDouble(),
      advanceAmountString: json['advanceAmountString'] ?? '',
      description: json['description'] ?? '',
      director: json['director'] ?? '',
      chiefAccountant: json['chiefAccountant'] ?? '',
      headDepartment: json['headDepartment'] ?? '',
      documentRep: json['documentRep'] ?? '',
      applicant: json['applicant'] ?? '',
      directorDate: json['directorDate'] ?? '',
      chiefAccountantDate: json['chiefAccountantDate'] ?? '',
      headDepartmentDate: json['headDepartmentDate'] ?? '',
      documentRepDate: json['documentRepDate'] ?? '',
      applicantDate: json['applicantDate'] ?? '',
      unclearAdvance: json['unclearAdvance'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      lstDetail: (json['lstDetail'] as List<dynamic>?)
              ?.map((e) => AdvancePaymentRequestDetailViewModel.fromJson(e))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() => {
        'advancePaymentRequestId': advancePaymentRequestId,
        'advancePaymentNo': advancePaymentNo,
        'deparmentId': deparmentId,
        'jobId': jobId,
        'advancePaymentDate': advancePaymentDate,
        'advancePaymentType': advancePaymentType,
        'curencyType': curencyType,
        'advanceAmountNumber': advanceAmountNumber,
        'advanceAmountString': advanceAmountString,
        'description': description,
        'director': director,
        'chiefAccountant': chiefAccountant,
        'headDepartment': headDepartment,
        'documentRep': documentRep,
        'applicant': applicant,
        'directorDate': directorDate,
        'chiefAccountantDate': chiefAccountantDate,
        'headDepartmentDate': headDepartmentDate,
        'documentRepDate': documentRepDate,
        'applicantDate': applicantDate,
        'unclearAdvance': unclearAdvance,
        'isDeleted': isDeleted,
        'lstDetail': lstDetail.map((e) => e.toJson()).toList(),
      };
}
