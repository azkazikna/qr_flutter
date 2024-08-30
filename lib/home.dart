import 'package:first_app/scanner.dart';
import 'package:flutter/material.dart';
import 'package:mssql_connection/mssql_connection.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

MssqlConnection mssqlConnection = MssqlConnection.getInstance();

class _HomeState extends State<Home> {
  String? _result;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qr Code Scanner'),
      ),
      body: Center(
        child: Text(
          _result ?? 'Data',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.center_focus_strong),
        onPressed: () => _openScanner(context),
      ),
    );
  }

  Future _openScanner(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (c) => const Scanner()));
    _result = result;
  }
}
