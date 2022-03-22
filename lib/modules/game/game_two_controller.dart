
import 'package:flutter/material.dart';

class GameTwoController {

  bool isMyTurn;
  bool snoopCard;
  bool discard;
  bool takeTrash;
  bool showAnimationSnoop;
  bool showAnimationTrash;
  late SnackBar snack;

  GameTwoController({
    required this.isMyTurn,
    required this.discard,
    required this.snoopCard,
    required this.takeTrash,
    required this.showAnimationSnoop,
    required this.showAnimationTrash,
  });

  void changeMyTurn(){
    if (isMyTurn){
      isMyTurn = false;
      snoopCard = false;
      takeTrash = false;
      discard = false;
    } else {
      isMyTurn = true;
      snoopCard = true;
      takeTrash = true;
    }
  }

  void startGame(){
    isMyTurn = true;
    snoopCard = true;
    takeTrash = true;
  }

  void snoopedCard(){
      snoopCard = false;
      discard = true;
      takeTrash = false;
  }

  void takeTrashCards(){
      takeTrash = false;
      snoopCard = false;
      discard = true;
  }

  void discardCard(){
    isMyTurn = false;
    snoopCard = false;
    takeTrash = false;
    discard = false;
  }



  void setIsMyTurn(){
    isMyTurn = !isMyTurn;
  }

  void setDiscard(){
    discard = !discard;
  }
  void setShowAnimationSnoop(){
    isMyTurn = !isMyTurn;
  }
  void setShowAnimationTrash(){
    showAnimationTrash = !showAnimationTrash;
  }
}