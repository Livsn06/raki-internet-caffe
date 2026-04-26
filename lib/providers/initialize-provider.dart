import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:raki_internet_cafe/providers/admin-auth-provider.dart';
import 'package:raki_internet_cafe/providers/admin-profile-provider.dart';
import 'package:raki_internet_cafe/providers/cart-provider.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/create-category-provider.dart';
import 'package:raki_internet_cafe/providers/create-product-provider.dart';
import 'package:raki_internet_cafe/providers/edit-category-provider.dart';
import 'package:raki_internet_cafe/providers/edit-product-provider.dart';
import 'package:raki_internet_cafe/providers/product-provider.dart';
import 'package:raki_internet_cafe/providers/splash-provider.dart';

import 'product-page-view-provider.dart';

class ProviderInitializer {
  ProviderInitializer._();

  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),
    ChangeNotifierProvider<ProductPageViewProvider>(
      create: (_) => ProductPageViewProvider(),
    ),
    // DATA PROVIDERS
    ChangeNotifierProvider<CategoryProvider>(create: (_) => CategoryProvider()),
    ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),
    ChangeNotifierProvider<AdminAuthProvider>(
      create: (_) => AdminAuthProvider(),
    ),
    ChangeNotifierProvider(create: (_) => AdminProfileProvider()),
    ChangeNotifierProvider(create: (_) => CreateCategoryProvider()),
    ChangeNotifierProvider(create: (_) => EditCategoryProvider()),
    ChangeNotifierProvider(create: (_) => CreateProductProvider()),
    ChangeNotifierProvider(create: (_) => EditProductProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
  ];
}
