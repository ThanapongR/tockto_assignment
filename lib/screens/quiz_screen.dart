import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tockto_assignment/models/quiz.dart';

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
            child: QuizCard(),
          ),
        ),
      ),
    );
  }
}

class QuizCard extends StatelessWidget {
  const QuizCard({
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
            List data = snapshot.data!;

            Quiz quiz = Quiz(data[0]);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuizQuestion(quiz: quiz),
                const SizedBox(height: 48.0),
                QuizChoice(quiz: quiz),
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

class QuizQuestion extends StatefulWidget {
  final Quiz quiz;

  const QuizQuestion({
    super.key,
    required this.quiz,
  });

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  @override
  Widget build(BuildContext context) {
    List<String> questionWords = widget.quiz.getQuestion().split('|');

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

class QuizChoice extends StatefulWidget {
  final Quiz quiz;

  const QuizChoice({
    super.key,
    required this.quiz,
  });

  @override
  State<QuizChoice> createState() => _QuizChoiceState();
}

class _QuizChoiceState extends State<QuizChoice> {
  @override
  Widget build(BuildContext context) {
    List choices = widget.quiz.getChoice();
    List<Widget> list = [];

    int i = 0;
    for (String choice in choices) {
      final index = i;
      list.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: widget.quiz.getChoicesState()[index]
                ? const Color(0xff7e64dc)
                : const Color(0xffe9e6f3),
          ),
          child: Text(
            choice,
            style: const TextStyle(fontSize: 20.0, color: Colors.deepPurple),
          ),
          onPressed: () {
            final player = AudioPlayer();
            player.play(AssetSource('vfx_tap.mp3'));
            setState(() {
              widget.quiz.toggleChoiceState(index);
            });
          },
        ),
      );
      i++;
    }

    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 8.0,
      runSpacing: 8.0,
      children: list,
    );
  }
}
