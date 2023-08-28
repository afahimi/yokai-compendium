class Yokai {
  final int number;
  final String name;
  final String rank;
  final String yokaiClass;
  final String element;
  final String food;
  final String phrase;

  // Stats
  final List<String> HP;
  final List<String> strength;
  final List<String> spirit;
  final List<String> defense;
  final List<String> speed;

  // Attacks
  final Map<String, dynamic> normalAttack;
  final Map<String, dynamic> technique;
  final Map<String, dynamic> soultimate;
  final Map<String, dynamic> inspirit;
  final Map<String, dynamic> skill;

  Yokai(
    this.number,
    this.name,
    this.rank,
    this.yokaiClass,
    this.element,
    this.food,
    this.phrase,
    this.HP,
    this.strength,
    this.spirit,
    this.defense,
    this.speed,
    this.normalAttack,
    this.technique,
    this.soultimate,
    this.inspirit,
    this.skill,
  );

  factory Yokai.fromJson(Map<String, dynamic> json) {
    return Yokai(
      json['number'],
      json['name'],
      json['rank'],
      json['class'],
      json['element'],
      json['food'],
      json['phrase'],
      List<String>.from(json['stats']['HP']),
      List<String>.from(json['stats']['strength']),
      List<String>.from(json['stats']['spirit']),
      List<String>.from(json['stats']['defense']),
      List<String>.from(json['stats']['speed']),
      json['attacks']['normal'],
      json['attacks']['technique'],
      json['attacks']['soultimate'],
      json['attacks']['inspirit'],
      json['attacks']['skill'],
    );
  }
}
