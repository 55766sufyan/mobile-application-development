import 'package:flutter/material.dart';

void main() {
  runApp(SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Home Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DashboardScreen(),
    );
  }
}

class Device {
  String name;
  String type;
  bool isOn;
  double value; // brightness/speed
  Device({required this.name, required this.type, this.isOn = false, this.value = 0.5});
}

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  List<Device> devices = [
    Device(name: 'Living Room Light', type: 'Light', isOn: true),
    Device(name: 'Ceiling Fan', type: 'Fan'),
    Device(name: 'Air Conditioner', type: 'AC'),
    Device(name: 'Security Camera', type: 'Camera', isOn: true),
  ];

  IconData getDeviceIcon(String type) {
    switch (type) {
      case 'Light':
        return Icons.lightbulb;
      case 'Fan':
        return Icons.toys; // fan icon alternative
      case 'AC':
        return Icons.ac_unit;
      case 'Camera':
        return Icons.videocam;
      default:
        return Icons.device_unknown;
    }
  }

  void _addDevice() {
    String deviceName = '';
    String deviceType = 'Light';
    String roomName = '';
    bool deviceStatus = false;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add New Device'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Device Name'),
                onChanged: (value) => deviceName = value,
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Room Name'),
                onChanged: (value) => roomName = value,
              ),
              DropdownButton<String>(
                value: deviceType,
                items: ['Light', 'Fan', 'AC', 'Camera']
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) setState(() => deviceType = value);
                },
              ),
            ],
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context), child: Text('Cancel')),
            ElevatedButton(
              onPressed: () {
                if (deviceName.isNotEmpty) {
                  setState(() {
                    devices.add(Device(name: deviceName, type: deviceType));
                  });
                  Navigator.pop(context);
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final crossAxisCount = width > 600 ? 3 : 2;

    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Home Dashboard'),
        leading: Icon(Icons.menu),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(child: Icon(Icons.person)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          itemCount: devices.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.0,
          ),
          itemBuilder: (context, index) {
            final device = devices[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => DeviceDetailScreen(
                            device: device,
                          )),
                ).then((_) => setState(() {})); // refresh on return
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Icon(getDeviceIcon(device.type),
                          size: 50,
                          color: device.isOn ? Colors.teal : Colors.grey),
                      Text(device.name,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16)),
                      Switch(
                        value: device.isOn,
                        onChanged: (value) {
                          setState(() {
                            device.isOn = value;
                          });
                        },
                        activeColor: Colors.teal,
                      ),
                      Text('${device.type} is ${device.isOn ? "ON" : "OFF"}'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addDevice,
        child: Icon(Icons.add),
      ),
    );
  }
}

class DeviceDetailScreen extends StatefulWidget {
  final Device device;

  DeviceDetailScreen({required this.device});

  @override
  _DeviceDetailScreenState createState() => _DeviceDetailScreenState();
}

class _DeviceDetailScreenState extends State<DeviceDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.device.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.devices,
              size: 100,
              color: widget.device.isOn ? Colors.teal : Colors.grey,
            ),
            SizedBox(height: 20),
            Text('${widget.device.type} is ${widget.device.isOn ? "ON" : "OFF"}',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            if (widget.device.type == 'Light' || widget.device.type == 'Fan')
              Column(
                children: [
                  Text(
                      widget.device.type == 'Light'
                          ? 'Brightness'
                          : 'Speed',
                      style: TextStyle(fontSize: 18)),
                  Slider(
                    value: widget.device.value,
                    onChanged: (val) {
                      setState(() {
                        widget.device.value = val;
                      });
                    },
                  ),
                ],
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Back to Dashboard'),
            )
          ],
        ),
      ),
    );
  }
}
