// ignore_for_file: prefer_const_constructors

import 'package:calculator/button.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var userQuestion = '';
  var userAnswer = 'Answer';

  final myTextStyle = TextStyle(
    fontSize: 30,
    color: Colors.deepPurple[700],
  );

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '9',
    '8',
    '7',
    'x',
    '6',
    '5',
    '4',
    '-',
    '3',
    '2',
    '1',
    '+',
    '00',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(children: <Widget>[
        Expanded(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    userQuestion,
                    style: TextStyle(fontSize: 30, color: Colors.grey[800]),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: Text(
                    userAnswer,
                    style: TextStyle(fontSize: 40, color: Colors.grey[800]),
                  ),
                )
              ]),
        ),
        Expanded(
            flex: 2,
            child: GridView.builder(
                itemCount: buttons.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4),
                itemBuilder: (BuildContext context, int index) {
                  // Clear Button
                  if (index == 0) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = '';
                          userAnswer = 'Answer';
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.grey[500],
                      textColor: Colors.white,
                    );

                    // Delete Button
                  } else if (index == 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          userQuestion = userQuestion.substring(
                              0, userQuestion.length - 1);
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.grey[500],
                      textColor: Colors.white,
                    );

                    // Equal to button
                  } else if (index == buttons.length - 1) {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          equalPressed();
                        });
                      },
                      buttonText: buttons[index],
                      color: Colors.deepPurple,
                      textColor: Colors.white,
                    );
                    // Rest of the buttons
                  } else {
                    return MyButton(
                      buttonTapped: () {
                        setState(() {
                          // IF EMPTY
                          if (userQuestion.isEmpty) {
                            if (!isOperator(buttons[index])) {
                              userQuestion += buttons[index];
                            }
                          }
                          // HAS NO EXPTY
                          else {
                            var string =
                                userQuestion.characters.takeLast(1).toString();
                            // IF LAST CHAR IS AN OPERATOR
                            if (isOperator(string)) {
                              // IF BUTTON PRESSED IS AN OPERATOR
                              if (isOperator(buttons[index])) {
                                userQuestion = userQuestion.substring(
                                    0, userQuestion.length - 1);
                                userQuestion += buttons[index];
                              }
                              // IF BUTTON PRESSED IS A DIGIT
                              else {
                                userQuestion += buttons[index];
                              }
                            }
                            // IF LAST CHAR IS A DECIMAL
                            else if (string == '.') {
                              // IF BUTTON PRESSED IS A DECIMAL
                              if (buttons[index] == '.') {
                                userQuestion = userQuestion;
                              }
                              // IF BUTTON PRESSED IS A DIGIT
                              else {
                                userQuestion += buttons[index];
                              }
                            }
                            // IF LAST CHAR IS A DIGIT
                            else {
                              if (userQuestion.length <= 12) {
                                userQuestion += buttons[index];
                              }
                            }
                          }
                        });
                      },
                      buttonText: buttons[index],
                      color: isOperator(buttons[index])
                          ? Colors.deepPurple
                          : Colors.deepPurple[50],
                      textColor: isOperator(buttons[index])
                          ? Colors.white
                          : Colors.deepPurple,
                    );
                  }
                }))
      ]),
    );
  }

  bool isOperator(String x) {
    if (x == 'C' ||
        x == 'Del' ||
        x == '%' ||
        x == '/' ||
        x == 'x' ||
        x == '-' ||
        x == '+' ||
        x == '=') {
      return true;
    }
    return false;
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    // replacing x with *
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    var result = eval.toStringAsFixed(4);

    if (result.contains('e')) {
      var arr = result.split("e");
      var temp = double.parse(arr[0]);
      arr[0] = temp.toStringAsFixed(5);
      result = arr[0] + 'e' + arr[1];
    }

    userAnswer = result;
    userQuestion = '';
  }
}
