class CartItemFillable {
  static String table = "cart_items";

  static String id = "id";
  static String productId = "product_id";
  static String variantLabel = "variant_label";
  static String productName = "product_name";
  static String productImagePath = "product_image_path";
  static String quantity = "quantity";
  static String price = "price";
}

class CartItem {
  late int id;
  late int productId;
  late String productName;
  late String productImagePath;
  late String variantLabel;
  late int quantity;
  late double price;

  CartItem({
    required this.id,
    required this.productId,
    required this.productName,
    required this.productImagePath,
    required this.variantLabel,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toMap() {
    return {
      CartItemFillable.id: id,
      CartItemFillable.productId: productId,
      CartItemFillable.productName: productName,
      CartItemFillable.variantLabel: variantLabel,
      CartItemFillable.productImagePath: productImagePath,
      CartItemFillable.quantity: quantity,
      CartItemFillable.price: price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map[CartItemFillable.id],
      productId: map[CartItemFillable.productId],
      productName: map[CartItemFillable.productName],
      variantLabel: map[CartItemFillable.variantLabel],
      quantity: map[CartItemFillable.quantity],
      price: map[CartItemFillable.price],
      productImagePath: map[CartItemFillable.productImagePath],
    );
  }
}
