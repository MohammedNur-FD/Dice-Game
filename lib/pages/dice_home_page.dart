import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class DiceHomePage extends StatefulWidget {
  const DiceHomePage({super.key});

  @override
  State<DiceHomePage> createState() => _DiceHomePageState();
}

class _DiceHomePageState extends State<DiceHomePage> {
  List diceList = <String>[
    'assets/images/one.png',
    'assets/images/two.png',
    'assets/images/three.png',
    'assets/images/four.png',
    'assets/images/five.png',
    'assets/images/six.png',
  ];

  int index1 = 0, index2 = 0, sumDice = 0, target = 0;
  final random = Random.secure();
  String status = '';
  bool isGameOver = false;
  bool isStatusColor = false;
  bool isStart = true;
  final _audioPlayer = AudioPlayer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Dice Game',
          style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontSize: 20,
                color: Colors.white,
              ),
        ),
      ),
      body: AnimatedCrossFade(
        duration: const Duration(milliseconds: 300),
        crossFadeState:
            isStart ? CrossFadeState.showFirst : CrossFadeState.showSecond,
        firstChild: startBody(),
        secondChild: gameBody(context),
      ),
    );
  }

  Widget startBody() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Game Master',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 100,
            ),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _startTheGame,
                child: const Text('START'),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _theGameRoll,
                child: const Text('HOW TO PLAY'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget gameBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                diceList[index1],
                height: 100,
                width: 100,
                color: Colors.black,
              ),
              const SizedBox(
                width: 20,
              ),
              Image.asset(
                diceList[index2],
                height: 100,
                width: 100,
                color: Colors.black,
              ),
            ],
          ),
          const SizedBox(
            height: 100,
          ),
          Text(
            'Dice Sum : $sumDice',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 100,
          ),
          if (target > 0)
            Text(
              'Your target is: $target',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          const SizedBox(
            height: 20,
          ),
          if (target > 0)
            Text(
              'Keep rolling until you match your target ponit is $target',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
            ),
          const SizedBox(
            height: 29,
          ),
          if (!isGameOver)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _rollTheButton,
                    child: Text(
                      'Roll',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                    )),
              ),
            ),
          const SizedBox(
            height: 30,
          ),
          if (isGameOver)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: _reset,
                    child: Text(
                      'Reset',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                    )),
              ),
            ),
          const SizedBox(
            height: 50,
          ),
          Text(
            status,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: isStatusColor ? Colors.green : Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  void _rollTheButton() {
    setState(() {
      index1 = random.nextInt(6);
      index2 = random.nextInt(6);
      sumDice = index1 + index2 + 2;
      _playSound('audios/roll_sound.mp3');
      if (target > 0) {
        if (target == sumDice) {
          status = 'Palyer Wins!';
          _playSound('audios/win_sound.mp3');

          isStatusColor = true;
          isGameOver = true;
        } else if (sumDice == 7) {
          status = 'Player Lost!';
          _playSound('audios/lost_sound.mp3');
          isStatusColor = false;
          isGameOver = true;
        }
      } else {
        if (sumDice == 7 || sumDice == 12) {
          status = 'Player Wins!';
          _playSound('audios/win_sound.mp3');

          isStatusColor = true;
          isGameOver = true;
        } else if (sumDice == 2 || sumDice == 3 || sumDice == 12) {
          status = 'Player Lost!';
          _playSound('audios/lost_sound.mp3');
          isStatusColor = false;
          isGameOver = true;
        } else {
          target = sumDice;
        }
      }
    });
  }

  void _playSound(String soundPath) async {
    await _audioPlayer.play(AssetSource(soundPath));
  }

  void _reset() {
    setState(() {
      index1 = 0;
      index2 = 0;
      sumDice = 0;
      isGameOver = false;
      status = '';
      target = 0;
      isStart = true;
      _audioPlayer.stop();
    });
  }

  void _startTheGame() {
    setState(() {
      isStart = false;
    });
  }

  void _theGameRoll() {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Game Rols'),
          content: const Text(rols),
          actions: [
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("CLOSE"),
            ),
          ],
        );
      },
    );
  }
}

const rols = '''
1. At the first roll, if the Dice Sum is 7 or 11, Player wins!
2. At the first roll, if the Dice Sum is 2, 3 or 12, Player lose
3. At the first roll, if the Dice Sum is 4, 5, 6, 8, 9 or 10, Dice Sum will be the target point
4. If the dice sum matches the target point, player wins
5. if the dice sum is 7 while chasing the target, player loses.
''';
