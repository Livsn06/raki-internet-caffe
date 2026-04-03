class AssetHelper {
  AssetHelper._();

  static String getAssetPath(String path) {
    return "assets/$path";
  }
}

class AssetItems {
  AssetItems._();
  static const String appIcon = "images/logo.png";

  // ----------- Categories ---------//
  static const String burgers = "categories/burgers.jpg";
  static const String hotdog = "categories/hotdog.png";
  static const String fries = "categories/fries.jpg";
  static const String hotCoffee = "categories/hot_coffee.png";
  static const String icedCoffee = "categories/iced_coffee.png";
  static const String milkTea = "categories/milk_tea.jpg";
  static const String milkShake = "categories/milk_shake.jpg";
  static const String fruitSoda = "categories/fruit_soda.jpg";

  // ----------- Products ---------//
  // Hot Coffees
  static const String cafe = "products/cafe.png";
  static const String arabic = "products/arabic.png";

  // Iced Coffees
  static const String icedLatte = "products/iced_latte.png";
  static const String icedMocha = "products/iced_mocha.png";
  static const String icedBrownSugarLatte =
      "products/iced_brown_sugar_latte.png";

  // Burgers
  static const String classicBurger = "products/classic_burger.png";
  static const String cheeseBurger = "products/cheese_burger.png";
  static const String burgerWithEgg = "products/burger_with_egg.png";
  static const String burgerOverload = "products/burger_overload.png";
}
