import 'dart:convert';


class Activity {
final String id;
final double latitude;
final double longitude;
final String base64Image; // store base64 string for simplicity
final DateTime timestamp;


Activity({
required this.id,
required this.latitude,
required this.longitude,
required this.base64Image,
required this.timestamp,
});


Map<String, dynamic> toMap() {
return {
'id': id,
'latitude': latitude,
'longitude': longitude,
'base64Image': base64Image,
'timestamp': timestamp.toIso8601String(),
};
}


factory Activity.fromMap(Map<String, dynamic> map) {
return Activity(
id: map['id'],
latitude: (map['latitude'] as num).toDouble(),
longitude: (map['longitude'] as num).toDouble(),
base64Image: map['base64Image'] ?? '',
timestamp: DateTime.parse(map['timestamp']),
);
}


String toJson() => json.encode(toMap());
factory Activity.fromJson(String source) => Activity.fromMap(json.decode(source));
}