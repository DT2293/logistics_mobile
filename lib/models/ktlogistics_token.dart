class KtLogisticsToken {
  final int messCode;
  final String message;
  final String authenticateToken;
  final String expiredAuthenticateToken;
  final String refreshToken;
  final String expiredRefreshToken;
  final UserLogisticsInfosModels userLogisticsInfosModels;
  final String service;

  KtLogisticsToken({
    required this.messCode,
    required this.message,
    required this.authenticateToken,
    required this.expiredAuthenticateToken,
    required this.refreshToken,
    required this.expiredRefreshToken,
    required this.userLogisticsInfosModels,
    required this.service,
  });

  factory KtLogisticsToken.fromJson(Map<String, dynamic> json) {
    return KtLogisticsToken(
      messCode: json['messCode'],
      message: json['message'],
      authenticateToken: json['authenticateToken'],
      expiredAuthenticateToken: json['expiredAuthenticateToken'],
      refreshToken: json['refreshToken'],
      expiredRefreshToken: json['expiredRefreshToken'],
      userLogisticsInfosModels: UserLogisticsInfosModels.fromJson(json['userLogisticsInfosModels']),
      service: json['service'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'messCode': messCode,
      'message': message,
      'authenticateToken': authenticateToken,
      'expiredAuthenticateToken': expiredAuthenticateToken,
      'refreshToken': refreshToken,
      'expiredRefreshToken': expiredRefreshToken,
      'userLogisticsInfosModels': userLogisticsInfosModels.toJson(),
      'service': service,
    };
  }
}

class UserLogisticsInfosModels {
  final UserLogisticsInfo oneUserLogisticsInfo;
  final OneDepartmentInfo oneDepartmentInfo;
  final List<DepartmentFunction> listDepartmentFunctions;
  final List<FunctionModel> lstFunctions;
  final CompanyInfo companyInfo;

  UserLogisticsInfosModels({
    required this.oneUserLogisticsInfo,
    required this.oneDepartmentInfo,
    required this.listDepartmentFunctions,
    required this.lstFunctions,
    required this.companyInfo,
  });

  factory UserLogisticsInfosModels.fromJson(Map<String, dynamic> json) {
    return UserLogisticsInfosModels(
      oneUserLogisticsInfo: UserLogisticsInfo.fromJson(json['oneUserLogisticsInfo']),
      oneDepartmentInfo: OneDepartmentInfo.fromJson(json['oneDepartmentInfo']),
      listDepartmentFunctions: (json['listDepartmentFunctions'] as List<dynamic>)
          .map((e) => DepartmentFunction.fromJson(e))
          .toList(),
      lstFunctions: (json['lstFunctions'] as List<dynamic>)
          .map((e) => FunctionModel.fromJson(e))
          .toList(),
      companyInfo: CompanyInfo.fromJson(json['companyInfo']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'oneUserLogisticsInfo': oneUserLogisticsInfo.toJson(),
      'oneDepartmentInfo': oneDepartmentInfo.toJson(),
      'listDepartmentFunctions': listDepartmentFunctions.map((e) => e.toJson()).toList(),
      'lstFunctions': lstFunctions.map((e) => e.toJson()).toList(),
      'companyInfo': companyInfo.toJson(),
    };
  }
}

class UserLogisticsInfo {
  final String? userId;
  final String? userName;
  final String? pass;
  final String? fullName;
  final String? email;
  final String? phone;
  final String? address;
  final String? avatar;
  final String? createDate;
  final String? editDate;
  final int departmentId;
  final int positionId;
  final bool isActive;

  UserLogisticsInfo({
    this.userId,
    this.userName,
    this.pass,
    this.fullName,
    this.email,
    this.phone,
    this.address,
    this.avatar,
    this.createDate,
    this.editDate,
    required this.departmentId,
    required this.positionId,
    required this.isActive,
  });

  factory UserLogisticsInfo.fromJson(Map<String, dynamic> json) {
    return UserLogisticsInfo(
      userId: json['userId'],
      userName: json['userName'],
      pass: json['pass'],
      fullName: json['fullName'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      avatar: json['avatar'],
      createDate: json['createDate'],
      editDate: json['editDate'],
      departmentId: json['departmentId'] ?? 0,
      positionId: json['positionId'] ?? 0,
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'userName': userName,
      'pass': pass,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'address': address,
      'avatar': avatar,
      'createDate': createDate,
      'editDate': editDate,
      'departmentId': departmentId,
      'positionId': positionId,
      'isActive': isActive,
    };
  }
}

class OneDepartmentInfo {
  final int userGrpId;
  final String? note;
  final String? description;

  OneDepartmentInfo({
    required this.userGrpId,
    this.note,
    this.description,
  });

  factory OneDepartmentInfo.fromJson(Map<String, dynamic> json) {
    return OneDepartmentInfo(
      userGrpId: json['userGrpId'] ?? 0,
      note: json['note'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userGrpId': userGrpId,
      'note': note,
      'description': description,
    };
  }
}

class DepartmentFunction {
  final String? component;
  final String? funcsTagActive;

  DepartmentFunction({
    this.component,
    this.funcsTagActive,
  });

  factory DepartmentFunction.fromJson(Map<String, dynamic> json) {
    return DepartmentFunction(
      component: json['component'],
      funcsTagActive: json['funcsTagActive'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'component': component,
      'funcsTagActive': funcsTagActive,
    };
  }
}

class FunctionModel {
  final int functionId;
  final int? parentFunctionId;
  final String? functionName;
  final String? controllerName;
  final String? actionName;
  final String? iconUrl;
  final String? description;
  final bool isShow;
  final bool isActive;
  final bool isNavMenuButtom;
  final int displayOrder;
  final int menuButtomOrder;
  final bool isPopup;
  final String? toolBarType;
  final Decentralization? decentralization;
  final List<FunctionModel> inverseParent;

  FunctionModel({
    required this.functionId,
    this.parentFunctionId,
    this.functionName,
    this.controllerName,
    this.actionName,
    this.iconUrl,
    this.description,
    required this.isShow,
    required this.isActive,
    required this.isNavMenuButtom,
    required this.displayOrder,
    required this.menuButtomOrder,
    required this.isPopup,
    this.toolBarType,
    this.decentralization,
    required this.inverseParent,
  });

  factory FunctionModel.fromJson(Map<String, dynamic> json) {
    return FunctionModel(
      functionId: json['functionId'],
      parentFunctionId: json['parentFunctionId'],
      functionName: json['functionName'],
      controllerName: json['controllerName'],
      actionName: json['actionName'],
      iconUrl: json['iconUrl'],
      description: json['description'],
      isShow: json['isShow'] ?? false,
      isActive: json['isActive'] ?? false,
      isNavMenuButtom: json['isNavMenuButtom'] ?? false,
      displayOrder: json['displayOrder'] ?? 0,
      menuButtomOrder: json['menuButtomOrder'] ?? 0,
      isPopup: json['isPopup'] ?? false,
      toolBarType: json['toolBarType'],
      decentralization: json['decentralization'] != null
          ? Decentralization.fromJson(json['decentralization'])
          : null,
      inverseParent: (json['inverseParent'] as List<dynamic>? ?? [])
          .map((e) => FunctionModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'functionId': functionId,
      'parentFunctionId': parentFunctionId,
      'functionName': functionName,
      'controllerName': controllerName,
      'actionName': actionName,
      'iconUrl': iconUrl,
      'description': description,
      'isShow': isShow,
      'isActive': isActive,
      'isNavMenuButtom': isNavMenuButtom,
      'displayOrder': displayOrder,
      'menuButtomOrder': menuButtomOrder,
      'isPopup': isPopup,
      'toolBarType': toolBarType,
      'decentralization': decentralization?.toJson(),
      'inverseParent': inverseParent.map((e) => e.toJson()).toList(),
    };
  }
}

class Decentralization {
  final int functionId;
  final bool isRead;
  final bool isDelete;
  final bool isUpdate;
  final bool isCreate;
  final bool isActive;

  Decentralization({
    required this.functionId,
    required this.isRead,
    required this.isDelete,
    required this.isUpdate,
    required this.isCreate,
    required this.isActive,
  });

  factory Decentralization.fromJson(Map<String, dynamic> json) {
    return Decentralization(
      functionId: json['functionId'],
      isRead: json['isRead'] ?? false,
      isDelete: json['isDelete'] ?? false,
      isUpdate: json['isUpdate'] ?? false,
      isCreate: json['isCreate'] ?? false,
      isActive: json['isActive'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'functionId': functionId,
      'isRead': isRead,
      'isDelete': isDelete,
      'isUpdate': isUpdate,
      'isCreate': isCreate,
      'isActive': isActive,
    };
  }
}

class CompanyInfo {
  final int companyID;
  final String? companyNameVN;
  final String? companyNameEN;
  final String? companyAddress;
  final String? address2;
  final String? province;
  final String? ward;
  final String? zipCode;
  final String? country;
  final String? telPhone;
  final String? taxNo;
  final String? taxCode;
  final String? accountInfo;
  final String? website;
  final String? email;
  final String? logo;

  CompanyInfo({
    required this.companyID,
    this.companyNameVN,
    this.companyNameEN,
    this.companyAddress,
    this.address2,
    this.province,
    this.ward,
    this.zipCode,
    this.country,
    this.telPhone,
    this.taxNo,
    this.taxCode,
    this.accountInfo,
    this.website,
    this.email,
    this.logo,
  });

  factory CompanyInfo.fromJson(Map<String, dynamic> json) {
    return CompanyInfo(
      companyID: json['companyID'] ?? 0,
      companyNameVN: json['companyNameVN'],
      companyNameEN: json['companyNameEN'],
      companyAddress: json['companyAddress'],
      address2: json['address2'],
      province: json['province'],
      ward: json['ward'],
      zipCode: json['zipCode'],
      country: json['country'],
      telPhone: json['telPhone'],
      taxNo: json['taxNo'],
      taxCode: json['taxCode'],
      accountInfo: json['accountInfo'],
      website: json['website'],
      email: json['email'],
      logo: json['logo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'companyID': companyID,
      'companyNameVN': companyNameVN,
      'companyNameEN': companyNameEN,
      'companyAddress': companyAddress,
      'address2': address2,
      'province': province,
      'ward': ward,
      'zipCode': zipCode,
      'country': country,
      'telPhone': telPhone,
      'taxNo': taxNo,
      'taxCode': taxCode,
      'accountInfo': accountInfo,
      'website': website,
      'email': email,
      'logo': logo,
    };
  }
}
