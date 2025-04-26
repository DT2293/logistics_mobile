import 'package:flutter/material.dart';
import 'package:logistic/models/ktlogistics_token.dart';
import 'package:logistic/pages/home/widget/home_footer.dart';

abstract class BaseListPage<T> extends StatefulWidget {
  final String title;
 final KtLogisticsToken token; // Thêm token vào constructor
  const BaseListPage({super.key, required this.title, required this.token});

  /// API fetch khác nhau giữa các trang
  Future<List<T>> fetchItems();

  /// Render từng row của DataTable
  List<DataCell> buildCells(T item);

  /// Popup detail của mỗi item
  Widget buildDetailPopup(T item);

  /// Column header chung
  List<DataColumn> get columns;

  /// Xử lý khi xoá item
  void onDeleteItem(T item);

  @override
  State<BaseListPage<T>> createState() => _BaseListPageState<T>();
}

class _BaseListPageState<T> extends State<BaseListPage<T>> {
  List<T> allItems = [];
  List<T> filteredItems = [];
  bool isLoading = true;
  T? selectedItem;

  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.fetchItems().then((items) {
      setState(() {
        allItems = items;
        filteredItems = items;
        isLoading = false;
      });
    });
    searchController.addListener(_filterItems);
  }

  void _filterItems() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredItems =
          allItems.where((item) {
            return widget
                .buildCells(item)
                .any(
                  (cell) =>
                      cell.child is Text &&
                      (cell.child as Text).data!.toLowerCase().contains(query),
                );
          }).toList();
    });
  }

  void _showDetail(T item) async {
    await showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Chi tiết'),
            content: widget.buildDetailPopup(item),
            actions: [
              TextButton(
                child: const Text('Đóng'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
    );

    // 🧼 Sau khi đóng dialog thì reset selectedItem
    setState(() {
      selectedItem = null;
    });
  }

  void _confirmDelete(T item) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Xác nhận xóa'),
            content: const Text('Bạn có chắc chắn muốn xóa mục này?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  setState(() {
                    allItems.remove(item);
                    filteredItems.remove(item);
                  });
                  widget.onDeleteItem(item);
                },
                child: const Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        labelText: 'Tìm kiếm',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: [
                          ...widget.columns,
                          const DataColumn(label: Text('')), // Cột cho nút xoá
                        ],
                        rows:
                            filteredItems.map((item) {
                              final isSelected = selectedItem == item;

                              return DataRow(
                                color:
                                    MaterialStateProperty.resolveWith<Color?>(
                                      (states) =>
                                          isSelected
                                              ? Colors.blue.withOpacity(0.1)
                                              : null,
                                    ),
                                // ❌ Đừng xử lý onTap từng cell
                                // ✅ Gọi detail và chọn row khi click vào bất kỳ cell (trừ nút delete)
                                cells: [
                                  ...widget
                                      .buildCells(item)
                                      .map(
                                        (cell) => DataCell(
                                          GestureDetector(
                                            behavior:
                                                HitTestBehavior
                                                    .opaque, // Bắt cả vùng trống
                                            onTap: () {
                                              setState(() {
                                                selectedItem = item;
                                              });
                                              _showDetail(item);
                                            },
                                            child: cell.child,
                                          ),
                                        ),
                                      ),
                                  DataCell(
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () => _confirmDelete(item),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
      bottomNavigationBar: HomeFooter(token: widget.token),

    );
  }
}
