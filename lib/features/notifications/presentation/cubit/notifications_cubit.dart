import 'package:bloc/bloc.dart';
import 'package:electro/features/notifications/data/models/notification_model.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final Box<NotificationModel> notificationsBox;

  NotificationsCubit(this.notificationsBox) : super(NotificationsInitial()) {
    print('🔔 NotificationsCubit initialized');
    loadNotifications();
  }

  Future<void> loadNotifications() async {
    try {
      print('🔔 Loading notifications from Hive box...');
      final notifications = notificationsBox.values.toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));
      print('🔔 Loaded ${notifications.length} notifications');
      emit(NotificationsLoaded(notifications));
    } catch (e, stackTrace) {
      print('❌ Error loading notifications: $e\n$stackTrace');
      emit(NotificationsError('فشل في تحميل الإشعارات'));
    }
  }

  Future<void> addNotification(NotificationModel notification) async {
    try {
      print('🔔 Adding new notification to Hive box...');
      print('Title: ${notification.title}');
      print('Body: ${notification.body}');
      print('Timestamp: ${notification.timestamp}');

      await notificationsBox.add(notification);
      print('✅ Notification added successfully');

      await loadNotifications();
    } catch (e, stackTrace) {
      print('❌ Error adding notification: $e\n$stackTrace');
      emit(NotificationsError('فشل في إضافة الإشعار'));
    }
  }

  Future<void> deleteNotification(int index) async {
    try {
      print('🔔 Deleting notification at index: $index');
      final notifications = notificationsBox.values.toList()
        ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

      if (index >= 0 && index < notifications.length) {
        final notification = notifications[index];
        await notification.delete();
        print('✅ Notification deleted successfully');
        await loadNotifications();
      } else {
        print('❌ Invalid notification index: $index');
      }
    } catch (e, stackTrace) {
      print('❌ Error deleting notification: $e\n$stackTrace');
      emit(NotificationsError('فشل في حذف الإشعار'));
    }
  }

  Future<void> clearNotifications() async {
    try {
      print('🔔 Clearing all notifications...');
      await notificationsBox.clear();
      emit(const NotificationsLoaded([]));
      print('✅ Notifications cleared successfully');
    } catch (e, stackTrace) {
      print('❌ Error clearing notifications: $e\n$stackTrace');
      emit(NotificationsError('فشل في مسح الإشعارات'));
    }
  }

  @override
  Future<void> close() async {
    print('🔔 Closing NotificationsCubit...');
    await notificationsBox.close();
    return super.close();
  }
}
