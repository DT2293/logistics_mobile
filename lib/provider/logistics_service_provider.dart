import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logistic/services/logistics_services.dart';


final logisticsServiceProvider = Provider<LogisticsServices>((ref) {
  return LogisticsServices();
});
