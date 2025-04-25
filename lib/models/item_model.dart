class ItemModel {
  final String? functionName;
  final int? id;
  
  // Constructor
  ItemModel({this.functionName, this.id});
  
  // You might need to define a fromJson method if you are parsing data from JSON
  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      functionName: json['functionName'],
      id: json['id'],
    );
  }
}
