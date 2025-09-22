import 'package:get/get.dart';
import '../core/bindings/controller_binding.dart';
import '../features/products/views/screens/product_list_screen.dart';

/// Application routes configuration
/// Defines all routes and their bindings for GetX navigation
class AppRoutes {
  /// Route paths
  static const String productList = '/products';
  static const String initial = productList;

  /// Route definitions with bindings
  static List<GetPage> get routes => [
    GetPage(
      name: productList,
      page: () => const ProductListScreen(),
      binding: ControllerBinding(),
      transition: Transition.fade,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
