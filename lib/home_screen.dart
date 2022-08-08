import 'package:flutter/material.dart';
import 'package:tic_tac_game/cubit/cubit.dart';
import 'package:tic_tac_game/game_logic.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: MediaQuery.of(context).orientation == Orientation.portrait ? Column(
          children: [
            ...firstBlock(context),
            buildExpanded(context),
            ...lastBlock(context),
          ],
        ):Row(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...firstBlock(context),
                  const SizedBox(height: 15.0,),
                  ...lastBlock(context),
                ],
              ),
            ),
            buildExpanded(context),
          ],
        ),
      ),
    );
  }

  Expanded buildExpanded(BuildContext context) {
    return Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(
                12.0,
              ),
              mainAxisSpacing: 5.0,
              crossAxisSpacing: 5.0,
              childAspectRatio: 1.0,
              crossAxisCount: 3,
              children: List.generate(
                9,
                (index) => InkWell(
                  borderRadius: BorderRadius.circular(
                    13.0,
                  ),
                  onTap: TicTacGameCubit.get(context).gameOver == true
                      ? null
                      : () => TicTacGameCubit.get(context).onnTap(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(
                        13.0,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        Player.playerX.contains(
                          index,
                        )
                            ? 'X'
                            : Player.playerO.contains(
                                index,
                              )
                                ? 'O'
                                : '',
                        style: TextStyle(
                          color: Player.playerX.contains(
                            index,
                          )
                              ? Colors.blue
                              : Colors.pink,
                          fontSize: 42.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  List firstBlock(context)
  {
    return
      [
        SwitchListTile.adaptive(
          title: Text(
            'Turn On/Off Two Player',
            style: TextStyle(
              color: Colors.white,
              fontSize: 28.0,
            ),
            textAlign: TextAlign.center,
          ),
          value: TicTacGameCubit.get(context).isSwitched,
          onChanged: (bool newValue) {
            TicTacGameCubit.get(context).Switched(newValue);
          },
        ),
        Text(
          'It\'s ${TicTacGameCubit.get(context).activePlayer} turn'
              .toUpperCase(),
          style: TextStyle(
            color: Colors.white,
            fontSize: 42.0,
          ),
          textAlign: TextAlign.center,
        ),
      ];
  }

  List<Widget> lastBlock(context)
  {
    return
      [
        Text(
          TicTacGameCubit.get(context).result,
          style: TextStyle(
            color: Colors.white,
            fontSize: 42.0,
          ),
          textAlign: TextAlign.center,
        ),
        ElevatedButton.icon(
          onPressed: () {
            TicTacGameCubit.get(context).isRepeat();
          },
          icon: Icon(
            Icons.replay,
          ),
          label: Text(
            'Repeat The Game',
          ),
          style: ButtonStyle(
            backgroundColor:
            MaterialStateProperty.all(Theme.of(context).splashColor),
          ),
        ),
      ];
  }
}
