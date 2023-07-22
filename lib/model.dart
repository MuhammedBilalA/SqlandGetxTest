class DetailsModel {
  String name;
  String age;
  int? id;
  DetailsModel({required this.age, required this.name, this.id});

  static DetailsModel fromMap(Map<String, Object?> map) {
    final String age = map['age'] as String;
    final String name = map['name'] as String;
    final int id = map['id'] as int;
    return DetailsModel(age: age, name: name,id: id);
  }
}
