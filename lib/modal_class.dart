class ModalClass {
  int? id;
  String name;
  int age;

  ModalClass({
    this.id,
    required this.name,
    required this.age,
  });

  factory ModalClass.fromMap(Map<String, dynamic> map) {
    return ModalClass(id: map['id'], name: map['name'], age: map['age']);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }
}
