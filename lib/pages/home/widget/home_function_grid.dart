import 'package:flutter/material.dart';
import 'package:logistic/models/ktlogistics_token.dart';

class HomeFunctionGrid extends StatelessWidget {
  final List<FunctionModel> functions;
  final Map<String, int> recordCounts;
  const HomeFunctionGrid({super.key, required this.functions, required this.recordCounts});

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

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: functions.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1,
        ),
        itemBuilder: (context, index) {
          final func = functions[index];
          return InkWell(
            onTap: () {
              // Xử lý navigation tại đây nếu cần
            },
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
                    recordCounts[func.actionName] == null
                        ? 'Đang tải...'
                        : 'Record: ${recordCounts[func.actionName]}',
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
