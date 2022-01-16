class CardModel2 {
  int numerator =0;
  String? characters;
  int? indice;
  String? naipe;
  String? color;
  int? tpBaralho;
  int? pontosCard;

  CardModel2(
      { required this.numerator,
        this.characters,
        this.indice,
        this.naipe,
        this.color,
        this.tpBaralho,
        this.pontosCard});

  CardModel2.fromJson(Map<String, dynamic> json) {
    numerator = json['number'];
    characters = json['characters'];
    indice = json['indice'];
    naipe = json['naipe'];
    color = json['color'];
    tpBaralho = json['tpBaralho'];
    pontosCard = json['pontosCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.numerator;
    data['characters'] = this.characters;
    data['indice'] = this.indice;
    data['naipe'] = this.naipe;
    data['color'] = this.color;
    data['tpBaralho'] = this.tpBaralho;
    data['pontosCard'] = this.pontosCard;
    return data;
  }
}