import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/models/document_model.dart';
import 'package:logistic/services/logistics_services.dart';
import 'package:shared_preferences/shared_preferences.dart';



class RecordCountsNotifier extends StateNotifier<Map<String, int>> {
  final LogisticsServices service;

  RecordCountsNotifier(this.service) : super({});

  Future<void> loadRecordCount(String actionName) async {
    // Kiểm tra nếu actionName đã có trong state
    if (state.containsKey(actionName)) {
      print('✅ Dữ liệu $actionName đã tồn tại, không cần gọi API');
      return; // Nếu đã có dữ liệu, không cần tải lại
    }

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('authenticateToken');
    final tag = prefs.getString('funcsTagActive') ?? '';

    if (token == null || tag.isEmpty) {
      print('❌ Không có token hoặc tag');
      return;
    }

    try {
      Map<String, dynamic>? rawData;

      // Gọi API tương ứng với actionName
      switch (actionName) {
        case 'SeaFCLExport':
          rawData = await service.seaFclExport(authenticateToken: token, funcsTagActive: tag);
          break;
        case 'SeaLCLExport':
          rawData = await service.sealclExport(authenticateToken: token, funcsTagActive: tag);
          break;
        case 'SeaLCLImport':
          rawData = await service.sealclImport(authenticateToken: token, funcsTagActive: tag);
          break;
        case 'SeaFCLImport':
          rawData = await service.seafclImport(authenticateToken: token, funcsTagActive: tag);
          break;
        case 'AirExport':
          rawData = await service.airExport(authenticateToken: token, funcsTagActive: tag);
          break;
        case 'AirImport':
          rawData = await service.airImport(authenticateToken: token, funcsTagActive: tag);
          break;
        default:
          print('❌ Không có API tương ứng với actionName: $actionName');
          return;
      }

      // Nếu gọi API thành công
      if (rawData != null) {
        final data = FwDocumentationViewModel.fromJson(rawData);
        state = {
          ...state,
          actionName: data.items?.length ?? 0, // Cập nhật số lượng item từ response
        };
        print('✅ Cập nhật dữ liệu cho $actionName: ${data.items?.length ?? 0}');
      }
    } catch (e) {
      print('❌ Lỗi khi load $actionName: $e');
    }
  }

  
}
