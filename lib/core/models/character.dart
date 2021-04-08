import 'dart:convert';

import 'package:flutter/foundation.dart';

class Character {
  final String name;
  final String height;
  final String gender;
  final String mass;
  final String? hairColor;
  final String? skinColor;
  final String? eyeColor;
  final String? birthYear;
  final String? homeworld;
  final List<String>? species;

  Character({
    required this.name,
    required this.height,
    required this.gender,
    required this.mass,
    this.hairColor,
    this.skinColor,
    this.eyeColor,
    this.birthYear,
    this.homeworld,
    this.species,
  });

  Character copyWith({
    String? name,
    String? height,
    String? gender,
    String? mass,
    String? hairColor,
    String? skinColor,
    String? eyeColor,
    String? birthYear,
    String? homeworld,
    List<String>? species,
  }) {
    return Character(
      name: name ?? this.name,
      height: height ?? this.height,
      gender: gender ?? this.gender,
      mass: mass ?? this.mass,
      hairColor: hairColor ?? this.hairColor,
      skinColor: skinColor ?? this.skinColor,
      eyeColor: eyeColor ?? this.eyeColor,
      birthYear: birthYear ?? this.birthYear,
      homeworld: homeworld ?? this.homeworld,
      species: species ?? this.species,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'height': height,
      'gender': gender,
      'mass': mass,
      'hair_color': hairColor,
      'skin_color': skinColor,
      'eye_color': eyeColor,
      'birth_year': birthYear,
      'homeworld': homeworld,
      'species': species,
    };
  }

  factory Character.fromMap(Map<String, dynamic> map) {
    return Character(
      name: map['name'],
      height: map['height'],
      gender: map['gender'],
      mass: map['mass'],
      hairColor: map['hair_color'],
      skinColor: map['skin_color'],
      eyeColor: map['eye_color'],
      birthYear: map['birth_year'],
      homeworld: map['homeworld'],
      species: List<String>.from(map['species']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Character.fromJson(String source) =>
      Character.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Character(name: $name, height: $height, gender: $gender, mass: $mass, hairColor: $hairColor, skinColor: $skinColor, eyeColor: $eyeColor, birthYear: $birthYear, homeworld: $homeworld, species: $species)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Character &&
        other.name == name &&
        other.height == height &&
        other.gender == gender &&
        other.mass == mass &&
        other.hairColor == hairColor &&
        other.skinColor == skinColor &&
        other.eyeColor == eyeColor &&
        other.birthYear == birthYear &&
        other.homeworld == homeworld &&
        listEquals(other.species, species);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        height.hashCode ^
        gender.hashCode ^
        mass.hashCode ^
        hairColor.hashCode ^
        skinColor.hashCode ^
        eyeColor.hashCode ^
        birthYear.hashCode ^
        homeworld.hashCode ^
        species.hashCode;
  }
}
