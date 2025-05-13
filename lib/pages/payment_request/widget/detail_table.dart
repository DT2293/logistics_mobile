import 'package:flutter/material.dart';
import 'package:logistic/models/advancepayment_detail.dart';
import 'detail_row_widget.dart';

class DetailTable extends StatelessWidget {
  final List<AdvancePaymentDetail> details;
  final Function(List<AdvancePaymentDetail>) onDetailsChanged;
  final List<String> jobNoList;
  final List<JobCarrier> jobCarrierList; 
  final void Function(String jobNo)? onJobNoSelected; // ✅ THÊM dòng này

  const DetailTable({
    super.key,
    required this.details,
    required this.onDetailsChanged,
    required this.jobNoList,
   required this.jobCarrierList,
    this.onJobNoSelected,
  });

  void _updateDetail(int index, AdvancePaymentDetail newDetail) {
    final updated = [...details];
    updated[index] = newDetail;
    onDetailsChanged(updated);
  }

  void _removeDetail(int index) {
    final updated = [...details]..removeAt(index);
    onDetailsChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(details.length, (index) {
        return DetailRowWidget(
          detail: details[index],
          onChanged: (newDetail) => _updateDetail(index, newDetail),
          onRemove: () => _removeDetail(index),
          jobNoList: jobNoList,
            jobCarrierList: jobCarrierList, 
          onJobNoSelected: onJobNoSelected, // ✅ Truyền xuống
        );
      }),
    );
  }
}
