class CategoryFillable {
  static const table = 'category';
  static const id = 'id';
  static const name = 'name';
  static const imagePath = 'image_path';
  static const createdAt = 'created_at';
  static const updatedAt = 'updated_at';
}

class Category {
  late int id;
  late String name;
  late String imagePath;
  late String createdAt;
  late String updatedAt;
  Category({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      CategoryFillable.id: id,
      CategoryFillable.name: name,
      CategoryFillable.imagePath: imagePath,
      CategoryFillable.createdAt: createdAt,
      CategoryFillable.updatedAt: updatedAt,
    };
  }

  Category.fromMap(Map<String, dynamic> map) {
    id = map[CategoryFillable.id];
    name = map[CategoryFillable.name];
    imagePath = map[CategoryFillable.imagePath];
    createdAt = map[CategoryFillable.createdAt];
    updatedAt = map[CategoryFillable.updatedAt];
  }

  Map<String, dynamic> newItemMap() {
    return {
      CategoryFillable.name: name,
      CategoryFillable.imagePath: imagePath,
      CategoryFillable.createdAt: createdAt,
      CategoryFillable.updatedAt: updatedAt,
    };
  }
}
