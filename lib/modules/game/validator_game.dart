import 'package:cafua/models/card_model3.dart';
import 'package:flutter/material.dart';

class ValidatorGame {
  // final formKey = GlobalKey<FormState>();

  late List<CardModel3> game;

  void printGame(List<CardModel3> cards){
    for(int i = 0; i<cards.length; i++){
      print(cards[i].orderValue);
    }
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

  bool validateSuit(List<CardModel3> cards){
    String naipe;
    if (cards.any((element) => element.characters == "JOKER")){
      naipe = cards.first.naipe;
      for (int i =0; i<cards.length-1; i++){
        if (cards[i].naipe!=naipe){
          print("cards[$i].naipe = "+cards[i].naipe.toString());
          print("naipe = "+naipe.toString());
          return false;
        }
      }
    } else {
      if (cards.first.orderValue!=2){
        naipe = cards.first.naipe;
      } else {
        naipe = cards[2].naipe;
      }
      for (int i =0; i < cards.length; i++){
        if ((cards[i].naipe!=naipe)&&(cards[i].orderValue!=2)){
          print("naipe ="+naipe);
          print("cards[$i]"+cards[i].naipe);
          return false;
        }
      }
    }
    return true;
  }

  bool isValid(List<CardModel3> cards,) {

    if (cards.length<3){
      return false;
    }
    cards.sort((a, b) => a.orderValue.compareTo(b.orderValue));
    if (validateSuit(cards)==false){
      print("validatesuit false"+validateSuit(cards).toString());
      return false;
    }


    CardModel3 cardAux;
    bool usedTwo = false;
    bool usedJoker = false;
    bool containA = cards.any((element) => element.characters == "A");
    bool contain2 = cards.any((element) => element.characters == "2");
    bool containJoker = cards.any((element) => element.characters == "JOKER");
    cards.sort((a, b) => a.orderValue.compareTo(b.orderValue));
    print("entrou");
    if ((contain2)&&(containJoker)){
      print("jogo com 2 e JOKER");
      //jogo com 2 e JOKER
      usedTwo = true;
      if (containA){
        //A 2 JOKER
        print("A 2 JOKER");
        if (cards.length>3){
          for (int i = 2; i<cards.length; i++){
            if (cards[i].orderValue!=i+1){
              if (usedJoker==true){
                return false;
              } else {
                usedJoker=true;
                cards.insert(i, cards.last);
                cards.remove(cards.last);
              }
            }
          }
        }
      } else {
        print("jogo com 2 e JOKER sem A'");
          /*
            jogo com 2 e JOKER sem A'
            2 joker 4 | 2 3 joker
            iniciando pela 2° carta, é percorrido a lista
            testando se a carta do indice é diferente do indice + 2
            ex.
              2 - 3 - JOKER
         */

        for (int i =1; i<cards.length-1; i++){
          if (cards[i].orderValue != (cards[i-1].orderValue+1)){
            if (usedJoker){
              print("usou joker 2x");
              print("if (cards[i].orderValue != (cards[i-1].orderValue+1))");
              return false;
            } else {
              usedJoker=true;
              cards.insert(i, cards.last);
              cards.remove(cards.last);
            }
          }
        }

      }
    } else {
      //não contem [2 | JOKER]

      if ((containJoker==false)&&(contain2==false)){
        print("não contem [2 - JOKER]");
        if(containA){
          int value = 13;
          for (int i = cards.length-1; i>0; i--){
            if (cards[i].orderValue!=value){
              return false;
            }
            value--;
          }
          //game... insere A no fim do jogo;
          cards.add(cards.first);
          cards.removeAt(0);
        }else {
          for (int i =0; i< cards.length-1; i++){
            if (cards[i].orderValue!=(cards[i+1].orderValue-1)){
              print("i = $i ="+cards[i].orderValue.toString());
              print("i = $i+1 ="+cards[i+1].orderValue.toString());
              return false;
            }
          }
        }


      }else if (contain2){
        if (containA){
          print("Jogo com 2 e A");
          if ((cards.last.orderValue!=13)&&(cards.last.orderValue!=12)){
            //jogo sem K e Q
            for (int i=2; i<cards.length; i++) {
              if (cards[i].orderValue != cards[i - 1].orderValue + 1) {
                print("sequencia invalida");
                print("$i = ${cards[i].orderValue}");
                print("$i = ${cards[i - 1].orderValue}");
                return false;
              }
            }
          } else{
            print("jogo com K ou Q");
            // jogo com A 2 e [ K | Q ]
            int verificador = 13;
            for (int i =cards.length-1; i>1; i--){
              if (cards[i].orderValue!=verificador){
                if (usedTwo){
                  print(" Usou 2, 2 x");
                  return false;
                } else {
                  print("usou 2");
                  usedTwo = true;
                  // printGame(cards);
                  cards.insert(i+1, cards[1]);
                  cards.removeAt(1);
                  // printGame(cards);
                }
              }
              verificador--;
            }
            //adiciona A no ultimo indice
            cards.add(cards.first);
            cards.removeAt(0);
          }

        } else {
          // com 2 sem A
          print("com 2 sem A");
          for (int i =1; i<cards.length-1; i++){
            print(cards[i].orderValue.toString());
            print(cards[i+1].orderValue.toString());
            if (cards[i].orderValue!= cards[i+1].orderValue-1) {
              if ((cards[i+1].orderValue-cards[i].orderValue)==2) {
                print("used2"+usedTwo.toString());
                if (usedTwo) {
                  print("usou 2 duas x");
                  return false;
                } else {
                  printGame(cards);
                  print("i = "+i.toString());
                  cards.insert(i+1, cards.first);
                  printGame(cards);
                  cards.remove(cards.first);
                  printGame(cards);
                  usedTwo = true;
                }
              } else {
                print("distancia = "+(cards[i].orderValue-cards[i+1].orderValue).toString());
                return false;
              }
            }
          }
        }
      }else {
        // implicitamente contem JOKER

        print("contain Joker");
        if (containA){
          // contem A
          print("contain A");

          if (cards[1].orderValue==3){
            //insere o joker no lugar do 2
            cards.insert(1, cards.last);
            cards.remove(cards.last);
          } else {
            //deve conter [ K | Q ] para um jogo válido
            if ( (cards[cards.length-2].orderValue!=13)&&
                (cards[cards.length-2].orderValue!=12) ) {
              print("Jogo sem K e sem Q");
              return false;
            } else {
              //existe ao menos um [ K | Q ]
              int verificador = 13;
              for (int i =(cards.length-2); i>0; i--){
                if (cards[i].orderValue!=verificador){
                  if (usedJoker){
                    return false;
                  } else {
                    usedJoker = true;
                    if (i<cards.length-2){
                      //inssere o joker no indice
                      cards.insert(i, cards.last);
                      cards.remove(cards.last);
                    }
                  }
                }
                verificador--;
              }
              //insere A para última posição
              cards.add(cards.first);
              cards.remove(cards.first);
            }
          }

        } else {
          //não contem A
          /*
              como existe um JOKER testar apenas até o penultimo item ja que
              o ultimo é o JOKER.
           */
          for (int i =0; i< (cards.length-2); i++){
            if (cards[i].orderValue!= cards[i+1].orderValue-1){
              if (cards[i].orderValue!=(cards[i+1].orderValue-2)){
                print("(distancia > 1)   = "+(cards[i+1].orderValue-cards[i].orderValue).toString());
                return false;
              } else {
                if (usedJoker){
                  print("usou Joker 2 x");
                  return false;
                } else {
                  usedJoker = true;
                  cards.insert(i, cards.last);
                  cards.remove(cards.last);
                }

              }
            }

          }
        }
      }

    }
    game = cards;
    return true;
  }



}
