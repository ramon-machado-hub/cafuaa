class CardModel3 {
  int numerator =0;
  int orderValue =0;
  String characters = "";
  int indice =0;
  String naipe="";
  String color="";
  int tpBaralho=0;
  int pontosCard=0;

  CardModel3(
      {
        required this.orderValue,
        required this.numerator,
        required this.characters,
        required this.indice,
        required this.naipe,
        required this.color,
        required this.tpBaralho,
        required this.pontosCard});

  CardModel3.fromJson(Map<String, dynamic> json) {
    orderValue = json['orderValue'];
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
    data['orderValue'] = this.orderValue;
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