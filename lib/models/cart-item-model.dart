class CartItemFillable {
  static String table = "cart_items";

  static String id = "id";
  static String productId = "product_id";
  static String variantLabel = "variant_label";
  static String productName = "product_name";
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
}
