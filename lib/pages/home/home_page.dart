// home_page.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/models/document_model.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/home/widget/home_footer.dart';
import 'package:logistic/pages/home/widget/home_function_grid.dart';
import 'package:logistic/pages/home/widget/home_header.dart';
import 'package:logistic/provider/logistics_service_provider.dart';
import 'package:logistic/services/authservice.dart';
import 'package:logistic/services/logistics_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider cho LogisticsServices
class RecordCountsNotifier extends StateNotifier<Map<String, int>> {
  final LogisticsServices service;
  final KtLogisticsToken token; 

  RecordCountsNotifier(this.service, this.token) : super({}) {
    _init();
  }

  Future<void> _init() async {
    final authenticateToken = token.authenticateToken;
    final funcsTagActive = await AuthService.getFuncsTagActive();

    if (authenticateToken == null || funcsTagActive == null) {
      print("❌ Token hoặc funcsTagActive null");
      return;
    }

    final functions = _getForwardSubFunctions();
    for (var func in functions) {
      if (func.actionName != null) {
        final data = await _fetchData(authenticateToken, funcsTagActive, func.actionName!);
        if (data != null) {
          state = {...state, func.actionName!: data.items?.length ?? 0};
        }
      }
    }
  }

  Future<FwDocumentationViewModel?> _fetchData(String token, String tag, String actionName) async {
    try {
      Map<String, dynamic>? rawData;
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
      }
      if (rawData != null) {
        return FwDocumentationViewModel.fromJson(rawData);
      }
    } catch (e) {
      print('❌ Lỗi khi parse dữ liệu cho $actionName: $e');
    }
    return null;
  }

  List<FunctionModel> _getForwardSubFunctions() {
    final forwardFunction = token.userLogisticsInfosModels.lstFunctions.firstWhere(
      (func) => func.functionName == "Forward",
      orElse: () => FunctionModel(
        functionId: 0,
        isShow: false,
        isActive: false,
        isNavMenuButtom: false,
        displayOrder: 0,
        menuButtomOrder: 0,
        isPopup: false,
        inverseParent: [],
      ),
    );
    return forwardFunction.inverseParent.take(6).toList();
  }
}
final authenticateTokenProvider = FutureProvider<String?>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('authenticateToken'); // Assuming token is saved with this key
  return token; // Return the token directly from SharedPreferences
});


final funcsTagActiveProvider = FutureProvider<String?>((ref) async {
  return await AuthService.getFuncsTagActive();
});

final recordCountsProvider = StateNotifierProvider.family<RecordCountsNotifier, Map<String, int>, KtLogisticsToken>(
  (ref, token) => RecordCountsNotifier(LogisticsServices(), token),
);

class HomePage extends ConsumerWidget {
  final KtLogisticsToken token;

  const HomePage({super.key, required this.token});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Lắng nghe authenticateToken và funcsTagActive từ Provider
    final authenticateTokenAsync = ref.watch(authenticateTokenProvider);
    final funcsTagActiveAsync = ref.watch(funcsTagActiveProvider);

    return authenticateTokenAsync.when(
      data: (authenticateToken) {
        return funcsTagActiveAsync.when(
          data: (funcsTagActive) {
            if (authenticateToken == null || funcsTagActive == null) {
              return Center(child: Text("Lỗi: Token không hợp lệ"));
            }

            // Xử lý khi có authenticateToken và funcsTagActive hợp lệ
            final recordCounts = ref.watch(recordCountsProvider(token));

            final functions = token.userLogisticsInfosModels.lstFunctions
                .firstWhere((f) => f.functionName == 'Forward')
                .inverseParent
                .take(6)
                .toList();
            final user = token.userLogisticsInfosModels.oneUserLogisticsInfo;

            return Scaffold(
              backgroundColor: Colors.grey[100],
              body: Column(
                children: [
                  HomeHeader(name: user.fullName ?? 'Người dùng'),
                  HomeFunctionGrid(functions: functions, recordCounts: recordCounts),
                  const HomeFooter(),
                ],
              ),
            );
          },
          loading: () => const CircularProgressIndicator(),
          error: (e, stackTrace) => Text('❌ Lỗi khi lấy funcsTagActive: $e'),
        );
      },
      loading: () => const CircularProgressIndicator(),
      error: (e, stackTrace) => Text('❌ Lỗi khi lấy authenticateToken: $e'),
    );
  }
}
