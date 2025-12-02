import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/activity.dart';


class LocalStorageService {
static const String _kRecent = 'recent_activities';


Future<void> saveRecentActivities(List<Activity> activities) async {
final prefs = await SharedPreferences.getInstance();
final jsonList = activities.map((a) => a.toJson()).toList();
await prefs.setStringList(_kRecent, jsonList);
}


Future<List<Activity>> loadRecentActivities() async {
final prefs = await SharedPreferences.getInstance();
final list = prefs.getStringList(_kRecent) ?? [];
return list.map((s) => Activity.fromJson(s)).toList();
}
}