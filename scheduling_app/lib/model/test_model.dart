class TestModel {
  // 様々な型を用意しました
  final String id;
  String category;
  int number;
  bool isAccepted = false;
  List<dynamic> titles;

  TestModel(
      {required this.id,
      required this.category,
      required this.number,
      required this.isAccepted,
      required this.titles});

  /// Map型に変換
  Map toJson() => {
        'id': id,
        'category': category,
        'number': number,
        'isAccepted': isAccepted,
        'titles': titles,
      };

  /// JSONオブジェクトを代入
  TestModel.fromJson(Map json)
      : id = json['id'],
        category = json['category'],
        number = json['number'],
        isAccepted = json['isAccepted'],
        titles = json['titles'];
}
