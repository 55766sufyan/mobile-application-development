
import 'package:flutter/material.dart';
import 'package:flutter_application_1/scrolling.dart';
import 'sjahkd.dart';
void main() {
  runApp(MyAPp());
}

class MyAPp extends StatefulWidget {
  const MyAPp({super.key});

  @override
  State<MyAPp> createState() => _MyAPpState();
}

class _MyAPpState extends State<MyAPp> {
  @override
  Widget build(BuildContext context) {
    var names = [
      "Ali",
      "Umer",
      "Ryaz",
      "Amir",
      "Liaqat",
      "Nabeel",
      "Shakeel",
      "Usman",
    ];
    var numbers = [
      "032256823678",
      "032256823678",
      "032256823678",
      "032256823678",
      "032256823678",
      "032256823678",
      "032256823678",
      "032256823678",
    ];
    
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("List View")),
        body: ListPratice(names, numbers)
        // Column(
        //   children: [
        //     Expanded(child: ListPratice(names, numbers)),
        //     // PaddingMarginPratice(),
        //     // Expanded(child: Scrolling()),
        //     // Checking(),
        //   ],
        // ),
      ),
    );
  }

  Center PaddingMarginPratice() {
    return Center(
      child: Container(
        color: Colors.green,
        child: Container(
          margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
          decoration: BoxDecoration(
            color: Colors.yellow,
            border: Border.all(width: 2, color: Colors.black),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Hello",
              style: TextStyle(fontSize: 19, color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }

  ListView ListPratice(List<String> names, List numbers) {
    return ListView.separated(
      itemCount: names.length,
      scrollDirection: Axis.vertical,
      separatorBuilder: (context, index) {
        return Divider();
      },
      itemBuilder: (context, index) {
        return ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.black,
            child: Icon(Icons.person, color: Colors.white),
            maxRadius: 30,
            minRadius: 30,
          ),
          title: Text(names[index]),
          subtitle: Text(numbers[index]),
          trailing: Icon(Icons.add),
        );
      },
    );
  }
}

