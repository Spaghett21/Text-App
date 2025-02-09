import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TextStoragePage()
    );
  }
}

class TextStoragePage extends StatefulWidget {
  const TextStoragePage({super.key});

  @override
  _TextStoragePageState createState() => _TextStoragePageState();
}

class _TextStoragePageState extends State<TextStoragePage> {
  final TextEditingController _controller = TextEditingController();
  String _storedText = "";

  @override
  void initState() {
    super.initState();
    _loadText();
  }

  _loadText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _storedText = prefs.getString('storedText') ?? "";
    });
  }

  _saveText() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('storedText', _controller.text);
    _loadText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Text Speicher App')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(labelText: 'Gib einen Text ein'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _saveText,
              child: const Text('Speichern'),
            ),
            const SizedBox(height: 20),
            Text('Gespeicherter Text: $_storedText'),
          ],
        ),
      ),
    );
  }
}
