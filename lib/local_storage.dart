import 'package:hive_flutter/hive_flutter.dart';
import 'features/cart/data/models/cart_item_model.dart';
import '../../features/notifications/data/models/notification_model.dart';

class HiveHelper {
  static Future<void> clearHiveData() async {
    await Hive.deleteFromDisk();
  }

  static Future<void> initHive() async {
    try {
      // Clear existing Hive data to avoid type conflicts
      await clearHiveData();
      
      // Initialize Hive
      await Hive.initFlutter();
      
      // Register all adapters
      _registerAdapters();
      
      // Open boxes
      await _openBoxes();
    } catch (e) {
      print('Hive initialization error: $e');
      rethrow;
    }
  }

  static void _registerAdapters() {
    if (!Hive.isAdapterRegistered(2)) {
    //  Hive.registerAdapter(CartModelAdapter());
    }
    
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(NotificationModelAdapter());
    }
    // Add any other adapters here
  }

  static Future<void> _openBoxes() async {
    await Future.wait([
      Hive.openBox<CartItemModel>('cartBox'),
      Hive.openBox<NotificationModel>('notificationsBox'),
    ]);
  }

  static Future<void> closeBoxes() async {
    await Future.wait([
      Hive.box<CartItemModel>('cartBox').close(),
      Hive.box<NotificationModel>('notificationsBox').close(),
    ]);
  }
}
