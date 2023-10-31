import 'dart:async';

import 'package:flappybird/utils/barriers.dart';
import 'package:flappybird/utils/bird.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static double fluppyJump = 0;
  double time = 0;
  double height = 0;
  double initialheight = fluppyJump;
  bool gameHasStarted = false;

  static double barrierX1 = 1;
  double barrierX2 = barrierX1 + 1.5;

  void jump() {
    setState(() {
      time = 0;
      initialheight = fluppyJump;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(
      const Duration(milliseconds: 100),
      (timer) {
        time += 0.04;
        height = -4.9 * time * time + 3 * time;
        setState(() {
          fluppyJump = initialheight - height;
        });
        setState(() {
          if (barrierX1 < -1.5) {
            barrierX1 += 3;
          } else {
            barrierX1 -= 0.05;
          }
        });
        setState(() {
          if (barrierX2 < -1.5) {
            barrierX1 += 3;
          } else {
            barrierX2 -= 0.05;
          }
        });
        if (fluppyJump > 1) {
          timer.cancel();
          gameHasStarted = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
          jump();
        } else {
          startGame();
        }
      },
      child: Scaffold(
          body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                AnimatedContainer(
                  alignment: Alignment(0, fluppyJump),
                  duration: const Duration(milliseconds: 4),
                  color: Colors.blue,
                  child: const Bird(),
                ),
                Container(
                  alignment: const Alignment(0, -0.3),
                  child: gameHasStarted
                      ? const SizedBox()
                      : const Text(
                          "T A P  T O  S T A R T",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierX1, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierX1, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 200.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierX2, 1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 150.0,
                  ),
                ),
                AnimatedContainer(
                  alignment: Alignment(barrierX2, -1.1),
                  duration: Duration(milliseconds: 0),
                  child: MyBarrier(
                    size: 250.0,
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 15,
            color: Colors.green,
          ),
          Expanded(
            child: Container(
              color: Colors.brown,
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Score",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "0",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Best Score",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "10",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
