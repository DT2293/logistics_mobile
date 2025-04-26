import 'package:flutter/material.dart';
import 'package:logistic/models/document_model.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/home/air_export/air_import_page.dart';
import 'package:logistic/pages/home/air_import/air_export_page.dart';
import 'package:logistic/pages/home/sea_fcl_export/sea_fcl_export_page.dart';
import 'package:logistic/pages/home/sea_fcl_import/sea_fcl_import_page.dart';
import 'package:logistic/pages/home/sea_lcl_Import/sea_lcl_Import.dart';
import 'package:logistic/pages/home/sea_lcl_export/sea_lcl_export_page.dart';
import 'package:logistic/services/authservice.dart';
import 'package:logistic/services/logistics_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFunctionGrid extends StatefulWidget {
  final List<FunctionModel> functions;
  final Map<String, int> recordCounts;

  const HomeFunctionGrid({
    super.key,
    required this.functions,
    required this.recordCounts,
  });

  @override
  State<HomeFunctionGrid> createState() => _HomeFunctionGridState();
}

class _HomeFunctionGridState extends State<HomeFunctionGrid> {
  final LogisticsServices service = LogisticsServices();

  IconData _getIcon(String? name) {
    if (name == null) return Icons.device_unknown;
    final lower = name.toLowerCase();
    if (lower.contains("sea") && lower.contains("export")) return Icons.directions_boat;
    if (lower.contains("sea") && lower.contains("import")) return Icons.anchor;
    if (lower.contains("air") && lower.contains("export")) return Icons.flight_takeoff;
    if (lower.contains("air") && lower.contains("import")) return Icons.flight_land;
    if (lower.contains("warehouse") && lower.contains("in")) return Icons.inventory_2;
    if (lower.contains("warehouse") && lower.contains("out")) return Icons.local_shipping;
    return Icons.extension;
  }

  void _handleFunctionTap(FunctionModel func) {
    if (func.controllerName == 'Forward') {
      switch (func.actionName) {
        case 'SeaFCLExport':
          _navigateToSeaFCLExport();
          break;
        case 'SeaLCLExport':
          _navigateToSeaLCLExport();
          break;
        case 'SeaLCLImport':
          _navigateToSeaLCLImport();
          break;
        case 'SeaFCLImport':
          _navigateToSeaFCLImport();
          break;
        case 'AirExport':
          _navigateToAirExport();
          break;
        case 'AirImport':
          _navigateToAirImport();
          break;
        default:
          print('❌ Chức năng không xác định');
      }
    }
  }

 Future<void> navigateToDocumentationPage({
  required BuildContext context,
  required Future<dynamic> Function({required String authenticateToken, required String funcsTagActive}) fetchFunction,
  required Widget Function(FwDocumentationViewModel data) pageBuilder,
}) async {
  final prefs = await SharedPreferences.getInstance();
  final authenticateToken = prefs.getString('authenticateToken');
  final funcsTagActive = prefs.getString('funcsTagActive') ?? '';

  if (authenticateToken == null || authenticateToken.isEmpty || funcsTagActive.isEmpty) {
    print('❌ Token hoặc Tag không hợp lệ');
    return;
  }

  try {
    final rawData = await fetchFunction(
      authenticateToken: authenticateToken,
      funcsTagActive: funcsTagActive,
    );

    if (rawData != null) {
      final data = FwDocumentationViewModel.fromJson(rawData);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => pageBuilder(data),
        ),
      );
    } else {
      print('❌ API trả về null');
    }
  } catch (e) {
    print('❌ Lỗi khi gọi API: $e');
  }
}
Future<void> _navigateToSeaFCLExport() async {
  await navigateToDocumentationPage(
    context: context,
    fetchFunction: service.seaFclExport,
    pageBuilder: (data) => SeaFCLExportPage(data: data),
  );
}

Future<void> _navigateToSeaLCLExport() async {
  await navigateToDocumentationPage(
    context: context,
    fetchFunction: service.sealclExport,
    pageBuilder: (data) => SeaLCLExportPage(data: data),
  );
}

Future<void> _navigateToSeaLCLImport() async {
  await navigateToDocumentationPage(
    context: context,
    fetchFunction: service.sealclImport,
    pageBuilder: (data) => SeaLCLImportPage(data: data),
  );
}

Future<void> _navigateToSeaFCLImport() async {
  await navigateToDocumentationPage(
    context: context,
    fetchFunction: service.seafclImport,
    pageBuilder: (data) => SeaFCLImportPage(data: data),
  );
}

Future<void> _navigateToAirExport() async {
  await navigateToDocumentationPage(
    context: context,
    fetchFunction: service.airExport,
    pageBuilder: (data) => AirExportPage(data: data),
  );
}

Future<void> _navigateToAirImport() async {
  await navigateToDocumentationPage(
    context: context,
    fetchFunction: service.airImport,
    pageBuilder: (data) => AirImportPage(data: data),
  );
}


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: widget.functions.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final func = widget.functions[index];
          return InkWell(
            onTap: () => _handleFunctionTap(func),
            child: Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Icon(
                      _getIcon(func.functionName),
                      size: 36,
                      color: Colors.blueAccent,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(
                      func.functionName ?? "Chức năng",
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    widget.recordCounts[func.actionName] == null
                        ? 'Đang tải...'
                        : 'Record: ${widget.recordCounts[func.actionName]}',
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
