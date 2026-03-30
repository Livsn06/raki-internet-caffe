class AssetHelper {
  AssetHelper._();

  static String getAssetPath(String path) {
    return "assets/$path";
  }
}

class AssetItems {
  AssetItems._();
  static const String appIcon = "images/logo.png";
  static const String burgers = "categories/burgers.jpg";
  static const String hotCoffee = "categories/hot_coffee.png";
  static const String icedCoffee = "categories/iced_coffee.png";
  static const String milkTea = "categories/milk_tea.jpg";
  static const String milkShake = "categories/milk_shake.jpg";
  static const String fruitSoda = "categories/fruit_soda.jpg";
}
