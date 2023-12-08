import 'package:flutter/cupertino.dart';
import 'package:resume_builder/services/storage_servie.dart';
import 'api/api_client.dart';
import 'api_services.dart';

class Global {
  static late StorageServices storageServices;
  static late ApiClient apiClient;

  static Future init() async {
    WidgetsFlutterBinding.ensureInitialized();

    storageServices = await StorageServices().init();
    apiClient = ApiServices().init();
  }
}
