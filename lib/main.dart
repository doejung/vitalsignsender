import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: UserFormScreen(),
    );
  }
}

class UserFormScreen extends StatefulWidget {
  const UserFormScreen({super.key});

  @override
  _UserFormScreenState createState() => _UserFormScreenState();
}

class _UserFormScreenState extends State<UserFormScreen> {
  final TextEditingController hnController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  int weight = 50;
  int height = 160;
  int systolic = 120;
  int diastolic = 80;

  Future<void> sendData() async {
    try {
      final uri = Uri.parse("http://192.168.24.36:5000/add_data");
      print("Sending data: ${{
        'hn': hnController.text,
        'name': nameController.text,
        'weight': weight.toString(),
        'height': height.toString(),
        'bp': "$systolic/$diastolic",
      }}");

      final response = await http.post(uri, body: {
        'hn': hnController.text,
        'name': nameController.text,
        'weight': weight.toString(),
        'height': height.toString(),
        'bp': "$systolic/$diastolic",
      });

      if (response.statusCode == 200) {
        print("Data sent successfully!");
      } else {
        print("Failed to send data. Status code: ${response.statusCode}");
        print("Response body: ${response.body}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Information')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: hnController,
              decoration: const InputDecoration(labelText: 'HN'),
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name Surname'),
            ),
            Row(
              children: [
                Text('Weight: $weight kg'),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => setState(() => weight--),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => weight++),
                ),
              ],
            ),
            Row(
              children: [
                Text('Height: $height cm'),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => setState(() => height--),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => height++),
                ),
              ],
            ),
            Row(
              children: [
                Text('Blood Pressure: $systolic/$diastolic mmHg'),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => setState(() => systolic--),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => systolic++),
                ),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: () => setState(() => diastolic--),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () => setState(() => diastolic++),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: sendData,
              child: const Text('Send'),
            ),
          ],
        ),
      ),
    );
  }
}
