import 'dart:convert';
import 'package:riddles_resorts/models.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Riddles?>?riddle ;
  void clickGetButton(){
  setState(() {
    riddle=fetchRiddles();
  });
}
  Future<Riddles> fetchRiddles() async {
    final uri = Uri.parse("https://api.api-ninjas.com/v1/riddles");
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return Riddles.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('failed to load riddle');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SafeArea(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FutureBuilder(
              future: fetchRiddles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.none) {
                  return Container();
                } else {
                  if (snapshot.hasData) {
                    return buildDataWidget(context, snapshot);
                  } else if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else {
                    return Container();
                  }
                }
              },
            ),
             SizedBox(
            width: 200,
            child: ElevatedButton(onPressed: () => clickGetButton(), child:  const Text("get riddle"),
           ))
          ],
        ),
      ),
    );
  }
}
