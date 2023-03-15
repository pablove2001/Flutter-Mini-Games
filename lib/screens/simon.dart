import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_games/providers/simon_provider.dart';
import 'package:provider/provider.dart';

class Simon extends StatelessWidget {
  final double boardPadding = 35;
  final int thickness = 10;
  const Simon({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simon'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<SimonProvider>().setStart();
            },
            icon: const Icon(Icons.play_arrow),
          ),
          IconButton(
            onPressed: () {
              context.read<SimonProvider>().setStatus0();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  context.watch<SimonProvider>().getStatus == 0
                      ? 'Points:~'
                      : 'Points:${context.watch<SimonProvider>().getPoints}',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Record: ${context.watch<SimonProvider>().getRecord}',
                  style: GoogleFonts.pressStart2p(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        context.watch<SimonProvider>().getStatus == 0
                            ? 'Level ~'
                            : 'Level ${context.watch<SimonProvider>().getLevel}',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 25,
                        ),
                      ),
                      SimonBoard(
                          boardPadding: boardPadding, thickness: thickness),
                      Text(
                        context.watch<SimonProvider>().getStatus == 0
                            ? ''
                            : context.read<SimonProvider>().getStatus == 1
                                ? 'Watch!'
                                : 'Repeat!',
                        style: GoogleFonts.pressStart2p(
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SimonBoard extends StatelessWidget {
  final double boardPadding;
  final int thickness;
  const SimonBoard(
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
          // color: Colors.black,
          child: BoardColumns(
            thickness: thickness,
          ),
        ),
      ),
    );
  }
}

class BoardColumns extends StatelessWidget {
  final int thickness;
  const BoardColumns({super.key, required this.thickness});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          BoardRows(thickness: thickness, numColumn: 0),
          Expanded(
            flex: thickness,
            child: Container(),
          ),
          BoardRows(thickness: thickness, numColumn: 1),
        ],
      ),
    );
  }
}

class BoardRows extends StatelessWidget {
  final int thickness;
  final int numColumn;
  const BoardRows(
      {super.key, required this.thickness, required this.numColumn});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: (100 - thickness) ~/ 2,
      child: Row(
        children: [
          NoughtsCrosses(numId: (numColumn * 2), thickness: thickness),
          Expanded(
            flex: thickness,
            child: Container(),
          ),
          NoughtsCrosses(numId: (numColumn * 2) + 1, thickness: thickness),
        ],
      ),
    );
  }
}

class NoughtsCrosses extends StatelessWidget {
  final int thickness;
  final int numId;

  static List<List<Color?>> colorPairs = [
    [Colors.green[500], Colors.green[200]],
    [Colors.red[500], Colors.red[200]],
    [Colors.yellow[500], Colors.yellow[200]],
    [Colors.blue[500], Colors.blue[200]],
  ];

  const NoughtsCrosses(
      {super.key, required this.numId, required this.thickness});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: (100 - thickness) ~/ 2,
      child: GestureDetector(
        onTap: () {
          context.read<SimonProvider>().setClick(numId);
        },
        child: Container(
          decoration: BoxDecoration(
            color: colorPairs[numId]
                [context.watch<SimonProvider>().getMap[numId]],
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.black, width: 5),
          ),
        ),
      ),
    );
  }
}
