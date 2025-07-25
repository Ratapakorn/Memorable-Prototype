import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  Location location = new Location();
  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        channelDescription: 'channel description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    final iOS = IOSInitializationSettings();
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
      settings,
      onSelectNotification: (payload) async {
        onNotifications.add(payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async => 
      _notifications.show(id, title, body, await _notificationDetails(), payload: payload);

  static void showNonEScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    int? hour,
    int? minute,
    //required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(id, title, body, _scheduleOnce(Time(hour!, minute!)), await _notificationDetails(), payload: payload, androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);

  static void showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    int? hour,
    int? minute,
    //required DateTime scheduledDate,
  }) async =>
      _notifications.zonedSchedule(id, title, body, _scheduleDaily(Time(hour!, minute!)), await _notificationDetails(), payload: payload, androidAllowWhileIdle: true, uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime, matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);

  static tz.TZDateTime _scheduleDaily(Time time) {
    // final now = tz.TZDateTime.now(tz.local);
    final now = DateTime.now();
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      0,
    );

    return scheduledDate.isBefore(now)
      ? scheduledDate.add(Duration(days: 1))
      : scheduledDate;

  }

  static tz.TZDateTime _scheduleOnce(Time time) {
    // final now = tz.TZDateTime.now(tz.local);
    final now = DateTime.now();
    final scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      0,
    );

    return scheduledDate;

  }
}