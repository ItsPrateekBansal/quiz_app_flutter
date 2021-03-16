import 'package:flutter/material.dart';

void main() => runApp(QuizApp());

class QuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Quizzler",
      home: HomePage(),
    );
  }
}

class Question {
  String question;
  bool answer;
  Question(ques, ans) {
    this.question = ques;
    this.answer = ans;
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget correct = Icon(
    Icons.check,
    color: Colors.green,
  );
  Widget wrong = Icon(
    Icons.close,
    color: Colors.red,
  );
  void increaseScore() {
    if (idx == questions.length) return;
    scoreKeeper.add(correct);
    score += 1;
    setState(() {});
  }

  void decreaseScore() {
    if (idx == questions.length) return;
    print(questions);
    scoreKeeper.add(wrong);
    setState(() {});
  }

  void checkCorrect(ans) {
    if (idx <= questions.length - 1) {
      if (questions[idx].answer == ans) {
        increaseScore();
      } else {
        decreaseScore();
      }
      idx += 1;
    }
  }

  showAlertDialog(BuildContext context, bool ans) {
    // ignore: deprecated_member_use
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    // ignore: deprecated_member_use
    Widget continueButton = FlatButton(
      child: Text("Continue"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        checkCorrect(ans);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("CONFIRMATION"),
      content: Text("ARE YOU SURE ?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  restartGame(BuildContext context) {
    // ignore: deprecated_member_use
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    // ignore: deprecated_member_use
    Widget continueButton = FlatButton(
      child: Text("Yes"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
        score = 0;
        idx = 0;
        scoreKeeper.clear();
        setState(() {});
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text("PLAY AGAIN ?"),
      content: Text(
          "You have already completed the quiz with $score correct answers!"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  int idx = 0;
  int score = 0;
  List<Widget> scoreKeeper = [];
  List<Question> questions = [
    Question("Prateek Bansal is Best Flutter Developer ?", true),
    Question('India lies in Asia ?', true),
    Question('America is in Europe', false)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      // appBar: AppBar(
      //   title: Text("Quizzler"),
      // ),
      body: new Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Center(
                  child: Text(
                    (idx <= questions.length - 1)
                        ? "${questions[idx].question}?"
                        : "Your score is $score",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    "TRUE",
                  ),
                  onPressed: () {
                    if (idx == questions.length) {
                      restartGame(context);
                      return;
                    }
                    showAlertDialog(context, true);
                  },
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(15.0),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  color: Colors.red,
                  child: Text("FALSE"),
                  onPressed: () {
                    if (idx == questions.length) {
                      restartGame(context);
                      return;
                    }
                    showAlertDialog(context, false);
                  },
                ),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: scoreKeeper,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
