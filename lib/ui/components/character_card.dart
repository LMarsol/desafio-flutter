import 'package:flutter/material.dart';
import 'package:star_wars_wiki/core/models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;
  final bool favorite;
  final Function() onItemFavorited;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.favorite,
    required this.onItemFavorited,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        'character',
        arguments: {'character': character},
      ),
      child: Card(
        color: Color(0xFF272727),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${character.name}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.yellowAccent,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  GestureDetector(
                    onTap: onItemFavorited,
                    child: favorite
                        ? Icon(
                            Icons.star,
                            color: Colors.yellow,
                          )
                        : Icon(
                            Icons.star_outline,
                            color: Colors.white,
                          ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              _buildCharFeature('Height: ${character.height}'),
              _buildCharFeature('Gender: ${character.gender}'),
              _buildCharFeature('Mass: ${character.mass}'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCharFeature(String feature) {
    return Text(
      feature,
      style: TextStyle(
        fontSize: 16,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
