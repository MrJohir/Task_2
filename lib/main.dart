import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize GetStorage for local data persistence
  await GetStorage.init();

  // Register GetStorage instance
  Get.put(GetStorage());

  runApp(const ProductStoreApp());
}
