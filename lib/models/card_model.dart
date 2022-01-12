class CardModel {
  String? characters;
  int? indice;
  String? naipe;
  String? color;
  int? tpBaralho;
  int? pontosCard;

  CardModel(
      {this.characters,
        this.indice,
        this.naipe,
        this.color,
        this.tpBaralho,
        this.pontosCard});

  CardModel.fromJson(Map<String, dynamic> json) {
    characters = json['characters'];
    indice = json['indice'];
    naipe = json['naipe'];
    color = json['color'];
    tpBaralho = json['tpBaralho'];
    pontosCard = json['pontosCard'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['characters'] = this.characters;
    data['indice'] = this.indice;
    data['naipe'] = this.naipe;
    data['color'] = this.color;
    data['tpBaralho'] = this.tpBaralho;
    data['pontosCard'] = this.pontosCard;
    return data;
  }
}