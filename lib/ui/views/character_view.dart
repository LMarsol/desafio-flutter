import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_wiki/core/models/character.dart';
import 'package:star_wars_wiki/core/viewmodels/character_model.dart';
import 'package:star_wars_wiki/ui/components/background.dart';
import 'package:star_wars_wiki/ui/utils/ui_constants.dart';

class CharacterView extends StatefulWidget {
  final Character character;

  const CharacterView({Key? key, required this.character}) : super(key: key);

  @override
  _CharacterViewState createState() => _CharacterViewState();
}

class _CharacterViewState extends State<CharacterView> {
  late final CharacterModel _characterModel;

  @override
  void initState() {
    _characterModel = CharacterModel(widget.character);
    _characterModel.context = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _characterModel,
      child: Consumer<CharacterModel>(
        builder: (context, model, child) => Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text('More about ${widget.character.name}'),
            centerTitle: true,
          ),
          body: _buildBody(model),
        ),
      ),
    );
  }

  Widget _buildBody(CharacterModel model) {
    return Background(
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
                            '${widget.character.name}',
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
                                widget.character.height,
                              ),
                              _buildFeature(
                                'Mass',
                                widget.character.mass,
                              ),
                              _buildFeature(
                                'Hair Color',
                                widget.character.hairColor,
                              ),
                              _buildFeature(
                                'Skin Color',
                                widget.character.skinColor,
                              ),
                              _buildFeature(
                                'Eye Color',
                                widget.character.eyeColor,
                              ),
                              _buildFeature(
                                'Birth Year',
                                widget.character.birthYear,
                              ),
                              _buildFeature(
                                'Gender',
                                widget.character.gender,
                              ),
                              _buildFeature(
                                'Planet Name',
                                model.planetName,
                              ),
                              _buildFeature(
                                'Specie Name',
                                model.specieName,
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
    );
  }

  Widget _buildFeature(String feature, String? value) {
    return ListTile(
      leading: Text(
        '$feature',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      title: value != null
          ? Text(
              '$value',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
      dense: true,
    );
  }
}
