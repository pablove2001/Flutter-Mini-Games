import 'package:flutter/material.dart';
import 'package:mini_games/providers/simon_provider.dart';
import 'package:mini_games/screens/simon.dart';
import 'package:mini_games/screens/tic_tac_toe.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mini Games'),
      ),
      body: Center(
        child: TextButton(
          child: const Text('Button'),
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => ChangeNotifierProvider(
            //       create: (context) => TicTacToeProvider(),
            //       child: const TicTacToe(),
            //     ),
            //   ),
            // );
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => SimonProvider(),
                  child: const Simon(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
