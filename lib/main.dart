import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0 * 60; // Menit awal
  bool _isStarted = false;
  late Timer _timer;
  bool _isTimeUp = false;

  void _startTimer() {
    setState(() {
      _isStarted = true;
      _isTimeUp = false;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_counter > 0) {
        setState(() {
          _counter--;
        });
      } else {
        _timer.cancel();
        setState(() {
          _isStarted = false;
          _isTimeUp = true;
        });
      }
    });
  }

  void _stopTimer() {
    setState(() {
      _isStarted = false;
      _timer.cancel();
    });
  }

  void _resetTimer() {
    setState(() {
      _counter = 0 * 60;
      _isStarted = false;
      _timer.cancel();
      _isTimeUp = false;
    });
  }

  String _formatTime(int seconds) {
    int minutes = seconds ~/ 60;
    seconds = seconds % 60;
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TIMER",
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 174, 164, 71),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                color: const Color.fromARGB(255, 174, 164, 71),
                width: 10,
              ),
            ),
            child: const ListTile(
              title: Row(
                children: [
                  Text('Nama : Fadhila Fathin Anisatuz Zuhro'),
                ],
              ),
              subtitle: Text(
                'NIM : 222410102006',
              ),
            ),
          ),
          const SizedBox(height: 100),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: <Widget>[
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: "Masukkan Menit",
                        hintStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          _counter = int.parse(value) * 60;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_isTimeUp)
            const Center(
              child: Text(
                "Waktu Habis",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: Colors.red),
              ),
            ),
          const SizedBox(height: 16.0),
          Text(
            _formatTime(_counter),
            style: const TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                onPressed: _isStarted ? null : _startTimer,
                child: const Text("START"),
              ),
              ElevatedButton(
                onPressed: _isStarted ? _stopTimer : null,
                child: const Text("STOP"),
              ),
              ElevatedButton(
                onPressed: _resetTimer,
                child: const Text("RESET"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
