import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

int _quizNumber = 0;
List data = [];

Future<List<dynamic>> getJson() async {
  final String response = await rootBundle.loadString('assets/data.json');
  final data = json.decode(response);
  return data;
}

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeeeeee),
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
      body: const Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 320.0,
            child: Quiz(),
          ),
        ),
      ),
    );
  }
}

class Quiz extends StatelessWidget {
  const Quiz({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getJson(),
      builder: (context, snapshot) {
        if (snapshot.data == null || snapshot.hasData == false) {
          return const Center(
            child: Text("Opp something error!"),
          );
        } else {
          try {
            data = snapshot.data!;

            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuizCard(),
                SizedBox(height: 48.0),
                QuizChoice(),
              ],
            );
          } on Exception catch (e) {
            // print(e);
            return const Center(child: Text('err'));
          }
        }
      },
    );
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String question = data[_quizNumber]['text'];
    List<String> questionWords = question.split('|');

    List<InlineSpan> list = [];

    for (String word in questionWords) {
      if (word == '_') {
        list.add(
          WidgetSpan(
            child: Container(
              margin: const EdgeInsets.only(left: 4.0, right: 4.0),
              width: 40.0,
              height: 28.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: const Color(0xffe9e6f3),
              ),
            ),
          ),
        );
      } else {
        list.add(
          TextSpan(
            text: word,
          ),
        );
      }
    }

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.0),
        color: Colors.white,
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(
            fontSize: 22.0,
            color: Colors.black,
            height: 1.5,
          ),
          children: list,
        ),
      ),
    );
  }
}

class QuizChoice extends StatelessWidget {
  const QuizChoice({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List choices = data[_quizNumber]['choices'];
    List<Widget> list = [];

    for (String choice in choices) {
      list.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: const Color(0xffe9e6f3)),
          child: Text(
            choice,
            style: const TextStyle(fontSize: 20.0, color: Colors.deepPurple),
          ),
          onPressed: () {},
        ),
      );
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: list,
    );
  }
}
