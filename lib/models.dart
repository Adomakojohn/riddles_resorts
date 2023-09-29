import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

class Riddles {
    String question;
    String answer;

    Riddles({
        required this.question,
        required this.answer,
    });

    factory Riddles.fromJson(Map<String ,dynamic> json) => Riddles(
        question: json["question"],
        answer: json["answer"],
    );

   
}

Widget buildDataWidget(context , snapshot)=>  Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
              padding: const EdgeInsets.all(10),
              child: FlipCard(
                direction: FlipDirection.HORIZONTAL,
                flipOnTouch: true,
                front: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    alignment: Alignment.center,
                    height: 600,
                    width: 650,
                    color: const Color(0xFF006666),
                    child:Text(snapshot.data.question) ,
                  ),
                ),
                back: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Container(
                    alignment: Alignment.center,
                    height: 600,
                    width: 650,
                    color: const Color(0xFF006666),
                    child: Text(snapshot.data.answer),
                  ),
                ),
              )),
        ],
      );


