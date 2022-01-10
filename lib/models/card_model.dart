import 'package:flutter/material.dart';

class CardModel {
  final String characters;
  final int indice;
  final String naipe;
  final Color color;
  final int tpBaralho;
  final int pontosCard;

  CardModel({
    required this.characters,
    required this.indice,
    required this.naipe,
    required this.color,
    required this.tpBaralho,
    required this.pontosCard,
  });
}
