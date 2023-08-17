class Yokai {
  final int number;
  final String name;
  final String rank;
  final String yokaiClass;

  Yokai(this.number, this.name, this.rank, this.yokaiClass);

  factory Yokai.fromJson(Map<String, dynamic> json) {
    return Yokai(
      json['number'],
      json['name'],
      json['rank'],
      json['class'],
    );
  }
}
