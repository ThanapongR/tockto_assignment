import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tockto_assignment/models/quiz_data.dart';

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
            List<dynamic> data = snapshot.data!;
            context.read<QuizData>().addQuiz(data);

            return const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                QuizQuestion(),
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

class QuizQuestion extends StatelessWidget {
  const QuizQuestion({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    QuizData quizData = Provider.of<QuizData>(context);
    List<String> questionWords = quizData.getQuestion().split('|');

    List<InlineSpan> list = [];
    int i = 0; //Store blank space index

    for (String word in questionWords) {
      if (word == '_') {
        if (quizData.getAnswer()[i] == null) {
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
            WidgetSpan(
              child: Container(
                margin: const EdgeInsets.only(left: 4.0, right: 4.0),
                width: 40.0,
                height: 28.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: const Color(0xffe9e6f3),
                ),
                child: Text(quizData.getChoice()[quizData.getAnswer()[i] ?? 0]),
              ),
            ),
          );
        }
        i++;
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
    QuizData quizData = Provider.of<QuizData>(context);
    List choices = quizData.getChoice();
    List<Widget> list = [];

    int i = 0;
    for (String choice in choices) {
      final index = i;
      list.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: quizData.getChoicesState()[index]
                ? const Color(0xff7e64dc)
                : const Color(0xffe9e6f3),
          ),
          child: Text(
            choice,
            style: TextStyle(
              fontSize: 20.0,
              color: quizData.getChoicesState()[index]
                  ? Colors.white
                  : Colors.deepPurple,
            ),

            // style: const TextStyle(fontSize: 20.0, color: Colors.deepPurple),
          ),
          onPressed: () {
            final player = AudioPlayer();
            player.play(AssetSource('vfx_tap.mp3'));
            context.read<QuizData>().toggleChoiceState(index);
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
