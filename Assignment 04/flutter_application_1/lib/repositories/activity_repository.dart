import '../models/activity.dart';
import '../services/api_service.dart';
import '../services/local_storage_service.dart';


class ActivityRepository {
final ApiService api;
final LocalStorageService local;
ActivityRepository({required this.api, required this.local});


Future<List<Activity>> fetchAll() async {
return await api.fetchActivities();
}


Future<Activity> create(Activity a) async {
final created = await api.createActivity(a);


// update local cache: keep most recent 5
final recent = await local.loadRecentActivities();
recent.insert(0, created);
if (recent.length > 5) recent.removeLast();
await local.saveRecentActivities(recent);


return created;
}


Future<void> delete(String id) async {
await api.deleteActivity(id);
final recent = (await local.loadRecentActivities()).where((r) => r.id != id).toList();
await local.saveRecentActivities(recent);
}


Future<List<Activity>> loadRecentLocal() async => await local.loadRecentActivities();
}