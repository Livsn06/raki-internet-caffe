import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:raki_internet_cafe/providers/category-provider.dart';
import 'package:raki_internet_cafe/providers/splash-provider.dart';

import 'product-page-view-provider.dart';

class ProviderInitializer {
  ProviderInitializer._();

  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider<SplashProvider>(create: (_) => SplashProvider()),
    ChangeNotifierProvider<ProductPageViewProvider>(
      create: (_) => ProductPageViewProvider(),
    ),
    ChangeNotifierProvider<CategoryProvider>(create: (_) => CategoryProvider()),
  ];
}
