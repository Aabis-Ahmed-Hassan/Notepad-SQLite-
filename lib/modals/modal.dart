class ModalClass {
  String title;
  String subtitle;
  int? id;

  ModalClass({
    this.id,
    required this.title,
    required this.subtitle,
  });

  factory ModalClass.fromMap(Map<String, dynamic> map) {
    return ModalClass(
      id: map['id'],
      title: map['title'],
      subtitle: map['subtitle'],
    );
  }

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title, 'subtitle': subtitle};
  }
}
