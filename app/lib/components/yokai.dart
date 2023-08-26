class Yokai {
  final int number;
  final String name;
  final String rank;
  final String yokaiClass;
  final String strength;
  final String HP;
  final String technique;
  final String soultimate;

  Yokai(this.number, this.name, this.rank, this.yokaiClass, this.strength,
      this.HP, this.technique, this.soultimate);

  factory Yokai.fromJson(Map<String, dynamic> json) {
    return Yokai(
      json['number'],
      json['name'],
      json['rank'],
      json['class'],
      json['stats']['strength'][0],
      json['stats']['HP'][0],
      json['attacks']['technique']["name"],
      json['attacks']['soultimate']["name"],
    );
  }
}
