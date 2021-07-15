class AllPokemon {
  final int count;
  final String next;
  final String previous;
  final List<Result> results;

  AllPokemon(
     this.count,
     this.next,
     this.previous,
     this.results,
  );

  factory AllPokemon.fromJson(Map<String, dynamic> json){
    return AllPokemon(json['count'], json['next'],json['previous'],
    List<Result>.from(json['results'].map((x) => Result.fromJson(x))),
    );
  } 

}
  
class Result {
  final String name;
  final String url;

  Result({
    required this.name,
    required this.url,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    name: json['name'],
    url: json['url'],
  );

}

class PokemonDetails {
  List<AbilityElement> abilities;
  int baseExperience;
  int height;
  int id;
  String name;
  Sprites sprites;
  List<Stat> stats;
  List<Type> types;
  int weight;

  PokemonDetails({
    required this.abilities,
    required this.baseExperience,
    required this.height,
    required this.id,
    required this.name,
    required this.sprites,
    required this.stats,
    required this.types,
    required this.weight,
  });

  factory PokemonDetails.fromJson(Map<String, dynamic> json) => PokemonDetails(
    abilities: List<AbilityElement>.from(json["abilities"].map((x) => AbilityElement.fromJson(x))),
    baseExperience: json["base_experience"],
    height: json["height"],
    id: json["id"],
    name: json["name"],
    sprites: Sprites.fromJson(json["sprites"]),
    stats: List<Stat>.from(json["stats"].map((x) => Stat.fromJson(x))),
    types: List<Type>.from(json["types"].map((x) => Type.fromJson(x))),
    weight: json["weight"],
  );

}

class AbilityElement {
  AbilityElement({
      required this.ability,
      required this.isHidden,
  });

  StatClass ability;
  bool isHidden;

  factory AbilityElement.fromJson(Map<String, dynamic> json) => AbilityElement(
      ability: StatClass.fromJson(json["ability"]),
      isHidden: json["is_hidden"],
  );
}

class StatClass {
  StatClass({
    required this.name,
    required this.url,
  });

  String name;
  String url;

  factory StatClass.fromJson(Map<String, dynamic> json) => StatClass(
      name: json["name"],
      url: json["url"],
  );
}

class Sprites {
  Sprites({
      required this.backDefault,
      required this.backFemale,
      required this.backShiny,
      required this.backShinyFemale,
      required this.frontDefault,
      required this.frontFemale,
      required this.frontShiny,
      required this.frontShinyFemale,
  });

  String backDefault;
  String backFemale;
  String backShiny;
  String backShinyFemale;
  String frontDefault;
  String frontFemale;
  String frontShiny;
  String frontShinyFemale;

  factory Sprites.fromJson(Map<String, dynamic> json) => Sprites(
      backDefault: json["back_default"],
      backFemale: json["back_female"],
      backShiny: json["back_shiny"],
      backShinyFemale: json["back_shiny_female"],
      frontDefault: json["front_default"],
      frontFemale: json["front_female"],
      frontShiny: json["front_shiny"],
      frontShinyFemale: json["front_shiny_female"],
  );

  Map<String, dynamic> toJson() => {
      "back_default": backDefault,
      "back_female": backFemale,
      "back_shiny": backShiny,
      "back_shiny_female": backShinyFemale,
      "front_default": frontDefault,
      "front_female": frontFemale,
      "front_shiny": frontShiny,
      "front_shiny_female": frontShinyFemale,
  };
}

class Stat {
  Stat({
    required this.baseStat,
    required this.effort,
    required this.stat,
  });

  int baseStat;
  int effort;
  StatClass stat;

  factory Stat.fromJson(Map<String, dynamic> json) => Stat(
      baseStat: json["base_stat"],
      effort: json["effort"],
      stat: StatClass.fromJson(json["stat"]),
  );

}

class Type {
  Type({
    required this.slot,
    required this.type,
  });

  int slot;
  StatClass type;

  factory Type.fromJson(Map<String, dynamic> json) => Type(
      slot: json["slot"],
      type: StatClass.fromJson(json["type"]),
  );
}


