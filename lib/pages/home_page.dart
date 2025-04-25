// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:logistic/models/document_model.dart';
// import 'package:logistic/models/ktlogistics_token.dart';
// import 'package:logistic/pages/seafclexport_page.dart';
// import 'package:logistic/pages/sealclexport_page.dart';
// import 'package:logistic/pages/sealclimport_page.dart';
// import 'package:logistic/services/logistics_services.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class HomePage extends StatefulWidget {
//   final KtLogisticsToken token;
//   const HomePage({super.key, required this.token});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   final service = LogisticsServices();
//   int? _recordCount;
//   Map<String, int> _recordCounts = {};


//   @override
//   void initState() {
//     super.initState();
//       final functions = getForwardSubFunctions();
//   for (var func in functions) {
//     if (func.actionName != null) {
//       _loadRecordCount(func.actionName!);
//     }
//   }  // Gọi API ngay khi trang được load
//   }


//   Future<void> _loadRecordCount(String actionName) async {
//   final prefs = await SharedPreferences.getInstance();
//   final token = prefs.getString('authenticateToken');
//   final tag = prefs.getString('funcsTagActive') ?? '';

//   if (token == null || tag.isEmpty) return;

//   try {
//     Map<String, dynamic>? rawData;

//     switch (actionName) {
//       case 'SeaFCLExport':
//         rawData = await service.seaFclExport(authenticateToken: token, funcsTagActive: tag);
//         break;
//       case 'SeaLCLExport':
//         rawData = await service.sealclExport(authenticateToken: token, funcsTagActive: tag);
//         break;
//       case 'SeaLCLImport':
//         rawData = await service.sealclImport(authenticateToken: token, funcsTagActive: tag);
//         break;
//       case 'SeaFCLImport':
//         rawData = await service.seafclImport(authenticateToken: token, funcsTagActive: tag);
//         break;
//       case 'AirExport':
//         rawData = await service.airExport(authenticateToken: token, funcsTagActive: tag);
//         break;
//       case 'AirImport':
//         rawData = await service.airImport(authenticateToken: token, funcsTagActive: tag);
//         break;
//     }

//     if (rawData != null) {
//       final data = FwDocumentationViewModel.fromJson(rawData);
//       setState(() {
//         _recordCounts[actionName] = data.items?.length ?? 0;
//       });
//     }
//   } catch (e) {
//     print('❌ Lỗi khi tải dữ liệu cho $actionName: $e');
//   }
// }


//   Future<void> _loadData() async {
//     final prefs = await SharedPreferences.getInstance();
//     final authenticateToken = prefs.getString('authenticateToken');
//     final funcsTagActive = prefs.getString('funcsTagActive') ?? '';

//     if (authenticateToken == null || authenticateToken.isEmpty || funcsTagActive.isEmpty) {
//       print('Lỗi: authenticateToken hoặc funcsTagActive không hợp lệ');
//       return;
//     }

//     try {
//       final rawData = await service.seaFclExport(
//         authenticateToken: authenticateToken,
//         funcsTagActive: funcsTagActive,
//       );

//       if (rawData != null) {
//         final data = FwDocumentationViewModel.fromJson(rawData);

//         setState(() {
//           // Kiểm tra xem data.items có null không và đếm số lượng record
//           _recordCount = data.items?.length ?? 0;
//         });
//       } else {
//         print('Lỗi khi gọi API SeaFCLExport');
//       }
//     } catch (e) {
//       print('Lỗi trong quá trình gọi API: $e');
//     }
//   }

//   List<FunctionModel> getForwardSubFunctions() {
//     final forwardFunction = widget.token.userLogisticsInfosModels.lstFunctions.firstWhere(
//       (func) => func.functionName == "Forward",
//       orElse: () => FunctionModel(
//         functionId: 0,
//         isShow: false,
//         isActive: false,
//         isNavMenuButtom: false,
//         displayOrder: 0,
//         menuButtomOrder: 0,
//         isPopup: false,
//         inverseParent: [],
//       ),
//     );
//     return forwardFunction.inverseParent.take(6).toList();
//   }

//   IconData getFunctionIcon(String? name) {
//     if (name == null) return Icons.device_unknown;
//     final lower = name.toLowerCase();
//     if (lower.contains("sea") && lower.contains("export")) return Icons.directions_boat;
//     if (lower.contains("sea") && lower.contains("import")) return Icons.anchor;
//     if (lower.contains("air") && lower.contains("export")) return Icons.flight_takeoff;
//     if (lower.contains("air") && lower.contains("import")) return Icons.flight_land;
//     if (lower.contains("warehouse") && lower.contains("in")) return Icons.inventory_2;
//     if (lower.contains("warehouse") && lower.contains("out")) return Icons.local_shipping;
//     return Icons.extension;
//   }

//   void _handleFunctionTap(FunctionModel func) {
//     if (func.controllerName == 'Forward') {
//       switch (func.actionName) {
//         case 'SeaFCLExport':
//           _navigateToSeaFCLExport();
//           break;
//         case 'SeaLCLExport':
//           _navigateToSeaLCLExport();
//           break;
//          case 'SeaLCLImport':
//           _navigateToSeaLCLImport();
//           break;
//         case 'SeaFCLImport':
//           _navigateToSeaFCLImport();
//           break;
//         case 'AirExport':
//           _navigateToAirExport();
//           break;
//          case 'AirExport':
//           _navigateToAirExport();
//          case 'AirImport':
//           _navigateToAirImport();
//           break;
//         default:
//           print('Chức năng không xác định');
//       }
//     }
//   }

//   Future<void> _navigateToSeaFCLExport() async {
//     final prefs = await SharedPreferences.getInstance();
//     final authenticateToken = prefs.getString('authenticateToken');
//     final funcsTagActive = prefs.getString('funcsTagActive') ?? '';

//     if (authenticateToken == null || authenticateToken.isEmpty || funcsTagActive.isEmpty) {
//       print('Lỗi: authenticateToken hoặc funcsTagActive không hợp lệ');
//       return;
//     }

//     try {
//       final rawData = await service.seaFclExport(
//         authenticateToken: authenticateToken,
//         funcsTagActive: funcsTagActive,
//       );

//       if (rawData != null) {
//         final data = FwDocumentationViewModel.fromJson(rawData);

//         setState(() {
//           _recordCount = data.items?.length ?? 0;
//         });

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SeaFCLExportPage(data: data),
//           ),
//         );
//       } else {
//         print('Lỗi khi gọi API SeaFCLExport');
//       }
//     } catch (e) {
//       print('Lỗi trong quá trình gọi API: $e');
//     }
//   }


//     Future<void> _navigateToSeaLCLExport() async {
//     final prefs = await SharedPreferences.getInstance();
//     final authenticateToken = prefs.getString('authenticateToken');
//     final funcsTagActive = prefs.getString('funcsTagActive') ?? '';

//     if (authenticateToken == null || authenticateToken.isEmpty || funcsTagActive.isEmpty) {
//       print('Lỗi: authenticateToken hoặc funcsTagActive không hợp lệ');
//       return;
//     }

//     try {
//       final rawData = await service.sealclExport(
//         authenticateToken: authenticateToken,
//         funcsTagActive: funcsTagActive,
//       );

//       if (rawData != null) {
//         final data = FwDocumentationViewModel.fromJson(rawData);

//         setState(() {
//           _recordCount = data.items?.length ?? 0;
//         });

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SeaLCLExportPage(data: data),
//           ),
//         );
//       } else {
//         print('Lỗi khi gọi API SeaLCLExport');
//       }
//     } catch (e) {
//       print('Lỗi trong quá trình gọi API: $e');
//     }
//   }


//     Future<void> _navigateToSeaLCLImport() async {
//     final prefs = await SharedPreferences.getInstance();
//     final authenticateToken = prefs.getString('authenticateToken');
//     final funcsTagActive = prefs.getString('funcsTagActive') ?? '';

//     if (authenticateToken == null || authenticateToken.isEmpty || funcsTagActive.isEmpty) {
//       print('Lỗi: authenticateToken hoặc funcsTagActive không hợp lệ');
//       return;
//     }

//     try {
//       final rawData = await service.sealclImport(
//         authenticateToken: authenticateToken,
//         funcsTagActive: funcsTagActive,
//       );

//       if (rawData != null) {
//         final data = FwDocumentationViewModel.fromJson(rawData);

//         setState(() {
//           _recordCount = data.items?.length ?? 0;
//         });

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => SeaLCLImportPage(data: data),
//           ),
//         );
//       } else {
//         print('Lỗi khi gọi API SeaLCLImport');
//       }
//     } catch (e) {
//       print('Lỗi trong quá trình gọi API: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//       statusBarColor: Colors.blueAccent,
//       statusBarIconBrightness: Brightness.light,
//     ));

//     final user = widget.token.userLogisticsInfosModels.oneUserLogisticsInfo;
//     final functions = getForwardSubFunctions();

//     return Scaffold(
//       backgroundColor: Colors.grey[100],
//       body: Column(
//         children: [
//           _buildHeader(user.fullName ?? 'Người dùng'),
//           _buildFunctionGrid(functions),
//           _buildFooter(),
//         ],
//       ),
//     );
//   }

//   Widget _buildHeader(String name) {
//     return Container(
//       width: double.infinity,
//       padding: const EdgeInsets.only(top: 50, bottom: 20, left: 20, right: 20),
//       decoration: const BoxDecoration(
//         color: Colors.blueAccent,
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(30),
//           bottomRight: Radius.circular(30),
//         ),
//       ),
//       child: Row(
//         children: [
//           const CircleAvatar(
//             radius: 30,
//             backgroundColor: Colors.white,
//             child: Icon(Icons.person, size: 40, color: Colors.blueAccent),
//           ),
//           const SizedBox(width: 15),
//           Text(
//             name,
//             style: const TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.w600,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildFunctionGrid(List<FunctionModel> functions) {
//     return Expanded(
//       child: GridView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: functions.length,
//         shrinkWrap: true,
//         gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 3,
//           crossAxisSpacing: 12,
//           mainAxisSpacing: 12,
//           childAspectRatio: 1,
//         ),
//         itemBuilder: (context, index) {
//           final func = functions[index];
//           return InkWell(
//             onTap: () => _handleFunctionTap(func),
//             child: Card(
//               elevation: 3,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Flexible(
//                     child: Icon(
//                       getFunctionIcon(func.functionName),
//                       size: 36,
//                       color: Colors.blueAccent,
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: Text(
//                       func.functionName ?? "Chức năng",
//                       textAlign: TextAlign.center,
//                       style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                  Text(
//   _recordCounts[func.actionName] == null
//       ? 'Đang tải...'
//       : 'Record: ${_recordCounts[func.actionName]}',
//                  )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFooter() {
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 12),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border(top: BorderSide(color: Colors.grey.shade300)),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children: [
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.home, color: Colors.blueAccent),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.settings, color: Colors.grey),
//           ),
//           IconButton(
//             onPressed: () {},
//             icon: const Icon(Icons.logout, color: Colors.red),
//           ),
//         ],
//       ),
//     );
//   }
// }
