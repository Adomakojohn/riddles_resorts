import 'dart:convert';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:riddles_resorts/models.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Riddle> getRiddle() async {
    final response =
        await http.get(Uri.parse('https://api-ninjas.com/api/riddles'));
    if (response.statusCode == 200) {
      final Riddle = jsonDecode(response.body);
      return Riddle.fromJson(Riddle);
    } else {
      throw Exception('Failed to load the riddle');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<Riddle>(
          future: getRiddle(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading...");
            }
            if (snapshot.hasData) {
              final riddle = snapshot.data;
              return FlipCard(
                direction: FlipDirection.HORIZONTAL,
                front: Card(
                  child: Text(
                    '${riddle!.question}',
                  ),
                ),
                back: Container(
                  child: Text('${riddle.answer}'),
                ),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
