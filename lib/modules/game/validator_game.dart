import 'package:cafua/models/card_model3.dart';

class ValidatorGame {
  // final formKey = GlobalKey<FormState>();

  String? funcao(String value) {
    if (value.trim().length <= 2)
      return "O nome deve conter pelo menos duas letras";

    return null;
  }

  bool validatorCleanGame(List<CardModel3> cards){
    for (int i=0; i< cards.length-1; i++){
      if (cards[i].naipe!= cards[i+1].naipe){
        return false;
      } else if (cards[i].orderValue!=(cards[i+1].orderValue-1)){
        return false;
      }
    }
    return true;
  }

  bool isValid(List<CardModel3> cards,) {

    if (cards.length<3){
      return false;
    }
    bool containA = cards.any((element) => element.characters == "A");
    bool contain2 = cards.any((element) => element.characters == "2");
    bool containJoker = cards.any((element) => element.characters == "JOKER");
    cards.sort((a, b) => a.orderValue.compareTo(b.orderValue));
    if ((contain2)||(containJoker)){

    }
      for (int i =0; i<cards.length; i++){

      }
      return true;
  }



}
