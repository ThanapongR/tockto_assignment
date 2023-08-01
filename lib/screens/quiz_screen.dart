import 'dart:convert';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_shakemywidget/flutter_shakemywidget.dart';
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

            GlobalKey<ShakeWidgetState> shakeKey =
                GlobalKey<ShakeWidgetState>();

            return ShakeMe(
              key: shakeKey,
              shakeCount: 3,
              shakeOffset: 10,
              shakeDuration: const Duration(milliseconds: 500),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const QuizQuestion(),
                  const SizedBox(height: 48.0),
                  QuizChoice(
                    shakeKey: shakeKey,
                  ),
                ],
              ),
            );
          } on Exception catch (_) {
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
    List<String> questionWords = quizData.getQuestion();

    List<InlineSpan> list = [];
    int bsIndex = 0; //Store blank space index

    for (String word in questionWords) {
      if (word == '_') {
        if (quizData.getAnswerByIndex(bsIndex) == null) {
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
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                height: 28.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: ((() {
                    if (quizData.getAnswerCount() != 4) {
                      return const Color(0xffe9e6f3);
                    } else {
                      if (quizData.checkAnswer(bsIndex)) {
                        return const Color(0xffb5ffaf);
                      } else {
                        return const Color(0xffffccd2);
                      }
                    }
                  })()),
                ),
                child: Text(
                  quizData.getAnswerByIndex(bsIndex)!,
                  style: const TextStyle(
                    fontSize: 22.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        }
        bsIndex++;
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
  final GlobalKey<ShakeWidgetState> shakeKey;

  const QuizChoice({
    super.key,
    required this.shakeKey,
  });

  @override
  Widget build(BuildContext context) {
    QuizData quizData = Provider.of<QuizData>(context);
    List choices = quizData.getChoice();
    List<Widget> list = [];

    for (int i = 0; i < choices.length; i++) {
      list.add(
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            backgroundColor: quizData.getChoicesState()[i]
                ? const Color(0xff7e64dc)
                : const Color(0xffe9e6f3),
          ),
          child: Text(
            choices[i],
            style: TextStyle(
              fontSize: 20.0,
              color: quizData.getChoicesState()[i]
                  ? Colors.white
                  : Colors.deepPurple,
            ),
          ),
          onPressed: () {
            final player = AudioPlayer();
            player.play(AssetSource('vfx_tap.mp3'));
            context.read<QuizData>().toggleChoiceState(i);

            if (quizData.getAnswerCount() == 4) {
              if (quizData.checkAllAnswer()) {
                player.play(AssetSource('vfx_correct.mp3'));
              } else {
                player.play(AssetSource('vfx_wrong.mp3'));
                shakeKey.currentState?.shake();
              }
            }
          },
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
