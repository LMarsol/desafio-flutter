import 'package:flutter/material.dart';
import 'package:star_wars_wiki/core/models/character.dart';
import 'package:star_wars_wiki/ui/components/background.dart';
import 'package:star_wars_wiki/ui/utils/ui_constants.dart';

class CharacterView extends StatelessWidget {
  final Character character;

  const CharacterView({Key? key, required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text('More about ${character.name}'),
        centerTitle: true,
      ),
      body: Background(
        url: UIConstants.detailsBg,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              Expanded(
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(14),
                    ),
                  ),
                  color: Color(0xFF272727),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${character.name}',
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: ListTile.divideTiles(
                              color: Colors.white,
                              context: context,
                              tiles: [
                                _buildFeature(
                                  'Height',
                                  '${character.height}',
                                ),
                                _buildFeature(
                                  'Mass',
                                  '${character.mass}',
                                ),
                                _buildFeature(
                                  'Hair Color',
                                  '${character.hairColor}',
                                ),
                                _buildFeature(
                                  'Skin Color',
                                  '${character.skinColor}',
                                ),
                                _buildFeature(
                                  'Eye Color',
                                  '${character.eyeColor}',
                                ),
                                _buildFeature(
                                  'Birth Year',
                                  '${character.birthYear}',
                                ),
                                _buildFeature(
                                  'Gender',
                                  '${character.gender}',
                                ),
                              ],
                            ).toList(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListTile _buildFeature(String feature, String value) {
    return ListTile(
      leading: Text(
        '$feature',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      title: Text(
        '$value',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.yellow,
        ),
      ),
      dense: true,
    );
  }
}
