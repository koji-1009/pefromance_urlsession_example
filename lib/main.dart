import 'package:cupertino_http/cupertino_http.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Demo', home: const MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _httpResponse = '';
  String _cupertinoHttpResponse = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('HTTP Request Example')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              Text('http package'),
              ElevatedButton(
                onPressed: () async {
                  final client = Client();
                  try {
                    final response = await client
                        .get(Uri.parse('https://httpbin.org/get'))
                        .timeout(const Duration(seconds: 5));
                    setState(() {
                      _httpResponse = response.body;
                    });
                  } on Exception catch (e) {
                    setState(() {
                      _httpResponse = e.toString();
                    });
                  } finally {
                    client.close();
                  }
                },
                child: const Text('Make HTTP Request'),
              ),
              Text('http package response:'),
              Text(_httpResponse),
              const SizedBox(height: 16),
              Text('cupertino_http package'),
              ElevatedButton(
                onPressed: () async {
                  final client = CupertinoClient.defaultSessionConfiguration();
                  try {
                    final response = await client
                        .get(Uri.parse('https://httpbin.org/get'))
                        .timeout(const Duration(seconds: 5));
                    setState(() {
                      _cupertinoHttpResponse = response.body;
                    });
                  } on Exception catch (e) {
                    setState(() {
                      _cupertinoHttpResponse = e.toString();
                    });
                  } finally {
                    client.close();
                  }
                },
                child: const Text('Make HTTP Request'),
              ),
              Text('cupertino_http package response:'),
              Text(_cupertinoHttpResponse),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
