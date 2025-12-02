import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/activity.dart';
import '../repositories/activity_repository.dart';


class ActivityProvider extends ChangeNotifier {
final ActivityRepository repo;
List<Activity> activities = [];
bool loading = false;


ActivityProvider({required this.repo});


Future<void> loadActivities() async {
loading = true; notifyListeners();
try {
activities = await repo.fetchAll();
} catch (e) {
activities = [];
}
loading = false; notifyListeners();
}


Future<void> createActivity({required double lat, required double lng, required String base64Image}) async {
final act = Activity(id: Uuid().v4(), latitude: lat, longitude: lng, base64Image: base64Image, timestamp: DateTime.now());
await repo.create(act);
// reload list
await loadActivities();
}


Future<void> deleteActivity(String id) async {
await repo.delete(id);
activities.removeWhere((a) => a.id == id);
notifyListeners();
}


Future<List<Activity>> loadRecentLocal() async => await repo.loadRecentLocal();
}