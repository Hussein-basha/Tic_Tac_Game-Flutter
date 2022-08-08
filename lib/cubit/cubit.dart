import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_game/cubit/states.dart';
import 'package:tic_tac_game/game_logic.dart';

class TicTacGameCubit extends Cubit<TicTacGameStates> {
  TicTacGameCubit() : super(TicTacGameInitialState());

  static TicTacGameCubit get(context) => BlocProvider.of(context);
  String activePlayer = 'X';
  bool gameOver = false;
  int turn = 0;
  String result = 'xxxxxxxx';
  Game game = Game();
  bool isSwitched = false;

  void Switched(bool newValue) {
    isSwitched = newValue;
    emit(TicTacGameSwitchedState());
  }

  void isRepeat()   {
    result = '';
    activePlayer = 'X';
    gameOver = false;
    turn = 0;
    emit(TicTacGameRepeatState());
    Player.playerX = [];
    Player.playerO = [];
  }

  onnTap(int index) async {
    if ((Player.playerX.isEmpty ||
            !Player.playerX.contains(
              index,
            )) &&
        (Player.playerO.isEmpty ||
            !Player.playerO.contains(
              index,
            ))
    ) {
      Game.playGame(index, activePlayer);
      updateState();
      if (!isSwitched && !gameOver && turn != 9) {
        await game.autoPlay(activePlayer);
        updateState();
      }
    }
  }

  void updateState() {
    activePlayer = (activePlayer == 'X') ? 'O' : 'X';
    turn++;
    emit(TicTacGameTapState());
    String winnerPlayer = game.checkWinner();
    if(winnerPlayer != '')
      {
        gameOver = true;
        result = '$winnerPlayer is the winner';
      }
    else if(!gameOver && turn == 9)
      {
        result = 'It\'s Draw!';
      }

  }
}
