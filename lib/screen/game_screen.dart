import 'dart:math';

import 'package:flutter/material.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int totalCorrectAnswer = 0;
  int totalInCorrectAnswer = 0;

  int userPlayedCount = 0;

  int firstNumber = 0;
  int secondNumber = 0;

  void generateNumbers(int number) {
    setState(() {
      int correctAnswer = randomCorrectAnswer();
      if(number == correctAnswer){
        totalCorrectAnswer++;
      }else{
        totalInCorrectAnswer++;
      }
      List<int> numbers = generateTwoRandomNumbers();
      firstNumber = numbers[0];
      secondNumber = numbers[1];
    });
  }

  List<int> generateTwoRandomNumbers() {
    Random random = Random();
    int firstNumber = random.nextInt(10) + 1; // Generates a number between 1 and 10
    int secondNumber = random.nextInt(10) + 1; // Generates another number between 1 and 10
    return [firstNumber, secondNumber];
  }

  int randomCorrectAnswer() {
    List<int> numbers = generateTwoRandomNumbers();
    Random random = Random();
    int index = random.nextInt(numbers.length); // Generates a random index (0 or 1)
    return numbers[index];
  }

  void restartGame() {
    setState(() {
      userPlayedCount = 0;
      totalCorrectAnswer = 0;
      totalInCorrectAnswer = 0;
      firstNumber = 0;
      secondNumber = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Number Game'),
      ),
      body:
      Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if(userPlayedCount >= 10){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Limit Exceeded.')),
                        );
                      }else{
                        userPlayedCount++;
                        generateNumbers(firstNumber);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const BeveledRectangleBorder(), backgroundColor: Colors.white70
                    ),
                    child: Text(
                      '$firstNumber',
                      style: const TextStyle(
                          fontSize: 50, color: Colors.black, fontWeight: FontWeight.w300
                      ), // Adjust the style as desired
                    ),
                  ),
                ),
                SizedBox(
                  height: 200,
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      if(userPlayedCount >= 10){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Limit Exceeded.')),
                        );
                      }else{
                        userPlayedCount++;
                        generateNumbers(secondNumber);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        shape: const BeveledRectangleBorder(), backgroundColor: Colors.white70
                    ),
                    child: Text(
                      '$secondNumber',
                      style: const TextStyle(
                          fontSize: 50, color: Colors.black, fontWeight: FontWeight.w300
                      ), // Adjust the style as desired
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 50),
            Container(
              alignment: Alignment.center,
              height: 400,
              width: 400,
              // color: Colors.white70,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.black,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const Text('Game Stats', style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold
                  )),
                  Text('Correct Answer: $totalCorrectAnswer'),
                  Text('Incorrect Answer: $totalInCorrectAnswer'),
                  ElevatedButton(onPressed: (){
                    restartGame();
                  },
                    child: const Text(
                      'Restart Game',
                       style: TextStyle(
                         color: Colors.black
                       ),
                       // Adjust the style as desired
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )

    );
  }
}
