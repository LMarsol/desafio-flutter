import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:star_wars_wiki/core/models/character.dart';

class SwRequest {
  final int? count;
  final String? next;
  final String? previous;
  final List<Character> characters;

  SwRequest({
    this.count,
    this.next,
    this.previous,
    required this.characters,
  });

  SwRequest copyWith({
    int? count,
    String? next,
    String? previous,
    List<Character>? characters,
  }) {
    return SwRequest(
      count: count ?? this.count,
      next: next ?? this.next,
      previous: previous ?? this.previous,
      characters: characters ?? this.characters,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'next': next,
      'previous': previous,
      'characters': characters.map((x) => x.toMap()).toList(),
    };
  }

  factory SwRequest.fromMap(Map<String, dynamic> map) {
    return SwRequest(
      count: map['count'],
      next: map['next'],
      previous: map['previous'],
      characters: (map['results'] as List)
          .map((char) => Character.fromMap(char))
          .toList(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SwRequest.fromJson(String source) =>
      SwRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SwRequest(count: $count, next: $next, previous: $previous, characters: $characters)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SwRequest &&
        other.count == count &&
        other.next == next &&
        other.previous == previous &&
        listEquals(other.characters, characters);
  }

  @override
  int get hashCode {
    return count.hashCode ^
        next.hashCode ^
        previous.hashCode ^
        characters.hashCode;
  }
}
