class ProductFillable {
  static const table = 'products';
  static const id = 'id';
  static const name = 'name';
  static const catId = 'cat_id';
  static const variantLabel = 'variant_label';
  static const price = 'price';
  static const imagePath = 'image_path';
}

class Product {
  late int id;
  late int catId;
  late String name;
  late String variantLabel;
  late double price;
  late String imagePath;

  Product({
    required this.id,
    required this.catId,
    required this.name,
    required this.imagePath,
    required this.variantLabel,
    required this.price,
  });

  Map<String, dynamic> toMap() => {
    ProductFillable.id: id,
    ProductFillable.name: name,
    ProductFillable.catId: catId,
    ProductFillable.variantLabel: variantLabel,
    ProductFillable.price: price,
    ProductFillable.imagePath: imagePath,
  };

  Product.fromMap(Map<String, dynamic> map) {
    id = map[ProductFillable.id];
    name = map[ProductFillable.name];
    catId = map[ProductFillable.catId];
    variantLabel = map[ProductFillable.variantLabel];
    price = map[ProductFillable.price];
    imagePath = map[ProductFillable.imagePath];
  }
}
