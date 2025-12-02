import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/activity_provider.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String query = '';

  @override
  void initState() {
    super.initState();
    Provider.of<ActivityProvider>(context, listen: false).loadActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ActivityProvider>(
      builder: (context, prov, _) {
        var list = prov.activities.where((a) {
          return a.timestamp.toString().contains(query);
        }).toList();

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: const InputDecoration(labelText: "Search by date"),
                onChanged: (v) => setState(() => query = v),
              ),
            ),
            if (prov.loading) const LinearProgressIndicator(),
            Expanded(
              child: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, i) {
                  final a = list[i];
                  return ListTile(
                    leading: a.base64Image.isNotEmpty
                        ? Image.memory(base64Decode(a.base64Image))
                        : null,
                    title: Text(a.timestamp.toString()),
                    subtitle:
                        Text("Lat: ${a.latitude}, Lng: ${a.longitude}"),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await prov.deleteActivity(a.id);
                      },
                    ),
                  );
                },
              ),
            )
          ],
        );
      },
    );
  }
}
