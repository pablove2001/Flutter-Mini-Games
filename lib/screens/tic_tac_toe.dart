import 'package:flutter/material.dart';
import 'package:mini_games/providers/tic_tac_toe_provider.dart';
import 'package:provider/provider.dart';

class TicTacToe extends StatelessWidget {
  final double boardPadding = 25;
  final double thickness = 5;
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Tic Tac Toe'),
          actions: [
            IconButton(
                onPressed: () {
                  context.read<TicTacToeProvider>().setRestart();
                },
                icon: const Icon(Icons.refresh))
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              context.watch<TicTacToeProvider>().getWinner == 0
                  ? 'Turn of: ${context.watch<TicTacToeProvider>().getIsNoughts ? 'O' : 'X'}'
                  : context.watch<TicTacToeProvider>().getWinner == 3
                      ? 'It was a tie'
                      : 'The winner is ${context.read<TicTacToeProvider>().getWinner == 1 ? 'O' : 'X'}',
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(
              height: 20,
            ),
            TicTacToeBoard(
              boardPadding: boardPadding,
              thickness: thickness,
            ),
          ],
        ));
  }
}

class TicTacToeBoard extends StatelessWidget {
  final double boardPadding;
  final double thickness;
  const TicTacToeBoard(
      {super.key, required this.boardPadding, required this.thickness});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(boardPadding),
        child: Container(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.width - boardPadding * 2,
            minWidth: double.infinity,
            maxHeight: MediaQuery.of(context).size.width - boardPadding * 2,
            maxWidth: double.infinity,
          ),
          color: Colors.black,
          child: BoardColumns(
            thickness: thickness,
          ),
        ),
      ),
    );
  }
}

class BoardColumns extends StatelessWidget {
  final double thickness;
  const BoardColumns({super.key, required this.thickness});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          BoardRows(thickness: thickness, numColumn: 0),
          SizedBox(height: thickness),
          BoardRows(thickness: thickness, numColumn: 1),
          SizedBox(height: thickness),
          BoardRows(thickness: thickness, numColumn: 2),
        ],
      ),
    );
  }
}

class BoardRows extends StatelessWidget {
  final double thickness;
  final int numColumn;
  const BoardRows(
      {super.key, required this.thickness, required this.numColumn});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          NoughtsCrosses(numId: (numColumn * 3)),
          SizedBox(width: thickness),
          NoughtsCrosses(numId: (numColumn * 3) + 1),
          SizedBox(width: thickness),
          NoughtsCrosses(numId: (numColumn * 3) + 2),
        ],
      ),
    );
  }
}

class NoughtsCrosses extends StatelessWidget {
  final int numId;
  const NoughtsCrosses({super.key, required this.numId});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          context.read<TicTacToeProvider>().setClick(context, numId);
        },
        child: Container(
          color: Colors.grey,
          child: Center(
            child: Text(
              context.watch<TicTacToeProvider>().getMap[numId] == 0
                  ? ''
                  : context.read<TicTacToeProvider>().getMap[numId] == 1
                      ? 'O'
                      : 'X',
              style: const TextStyle(fontSize: 50),
            ),
          ),
        ),
      ),
    );
  }
}
