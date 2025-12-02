import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/activity.dart';


class ApiService {
// Replace baseUrl with your mock or real server URL
final String baseUrl;
ApiService({required this.baseUrl});


Future<List<Activity>> fetchActivities() async {
final res = await http.get(Uri.parse('\$baseUrl/activities'));
if (res.statusCode == 200) {
final List data = json.decode(res.body);
return data.map((e) => Activity.fromMap(e)).toList();
}
throw Exception('Failed to load activities');
}


Future<Activity> createActivity(Activity act) async {
final res = await http.post(Uri.parse('\$baseUrl/activities'), body: json.encode(act.toMap()), headers: {'Content-Type': 'application/json'});
if (res.statusCode == 201 || res.statusCode == 200) {
return Activity.fromMap(json.decode(res.body));
}
throw Exception('Failed to create');
}


Future<void> deleteActivity(String id) async {
final res = await http.delete(Uri.parse('\$baseUrl/activities/\$id'));
if (res.statusCode != 200 && res.statusCode != 204) throw Exception('Delete failed');
}
}