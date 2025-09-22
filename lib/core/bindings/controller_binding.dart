import 'package:get/get.dart';
import '../../features/products/controllers/product_controller.dart';
import '../services/storage_service.dart';

/// Controller bindings for dependency injection
/// Manages controller lifecycle and dependencies
class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    // Register storage service as a singleton
    Get.put<StorageService>(StorageService(), permanent: true);

    // Register product controller
    Get.lazyPut<ProductController>(() => ProductController());
  }
}
