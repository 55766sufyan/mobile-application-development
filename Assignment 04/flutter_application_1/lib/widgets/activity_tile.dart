import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/activity.dart';

class ActivityTile extends StatelessWidget {
  final Activity activity;
  final VoidCallback onDelete;

  const ActivityTile({
    super.key,
    required this.activity,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: activity.base64Image.isNotEmpty
            ? Image.memory(
                base64Decode(activity.base64Image),
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              )
            : const Icon(Icons.image),
        title: Text(activity.timestamp.toLocal().toString()),
        subtitle: Text("Lat: ${activity.latitude} | Lng: ${activity.longitude}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
