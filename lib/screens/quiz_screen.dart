import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      appBar: AppBar(
        title: const Text("Quiz"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: 320.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32.0),
                    color: Colors.white,
                  ),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 22.0, color: Colors.black, height: 1.5),
                      children: [
                        const TextSpan(
                          text: 'Oh!',
                        ),
                        WidgetSpan(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            width: 40.0,
                            height: 28.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color(0x226041b0),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            width: 40.0,
                            height: 28.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color(0x226041b0),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            width: 40.0,
                            height: 28.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color(0x226041b0),
                            ),
                          ),
                        ),
                        WidgetSpan(
                          child: Container(
                            margin:
                                const EdgeInsets.only(left: 4.0, right: 4.0),
                            width: 40.0,
                            height: 28.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color(0x226041b0),
                            ),
                          ),
                        ),
                        const TextSpan(
                          text:
                              ', Emily. I\'m exited to learn more about your interests.',
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 48.0,
                ),
                const Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: <Widget>[
                    Chip(
                      padding: EdgeInsets.all(12.0),
                      backgroundColor: Color(0x226041b0),
                      label: Text(
                        'Very long word',
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.deepPurple),
                      ),
                    ),
                    Chip(
                      padding: EdgeInsets.all(12.0),
                      backgroundColor: Color(0x226041b0),
                      label: Text(
                        'Wrong',
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.deepPurple),
                      ),
                    ),
                    Chip(
                      padding: EdgeInsets.all(12.0),
                      backgroundColor: Color(0x226041b0),
                      label: Text(
                        'Nice',
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.deepPurple),
                      ),
                    ),
                    Chip(
                      padding: EdgeInsets.all(12.0),
                      backgroundColor: Color(0x226041b0),
                      label: Text(
                        'to',
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.deepPurple),
                      ),
                    ),
                    Chip(
                      padding: EdgeInsets.all(12.0),
                      backgroundColor: Color(0x226041b0),
                      label: Text(
                        'meet',
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.deepPurple),
                      ),
                    ),
                    Chip(
                      padding: EdgeInsets.all(12.0),
                      backgroundColor: Color(0x226041b0),
                      label: Text(
                        'you',
                        style:
                            TextStyle(fontSize: 20.0, color: Colors.deepPurple),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
