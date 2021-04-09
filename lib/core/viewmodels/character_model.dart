import 'package:flutter/material.dart';
import 'package:star_wars_wiki/core/models/character.dart';
import 'package:star_wars_wiki/core/services/planets_service.dart';
import 'package:star_wars_wiki/core/services/species_service.dart';
import 'package:star_wars_wiki/core/utils/constants.dart';
import 'package:star_wars_wiki/ui/utils/utils.dart';

class CharacterModel extends ChangeNotifier {
  late final BuildContext context;
  late final Character character;

  CharacterModel(this.character) {
    this.getDetails();
  }

  String? _planetName;
  String? _specieName;

  String? get planetName => _planetName;
  String? get specieName => _specieName;

  setPlanetName(String value) {
    _planetName = value;
    notifyListeners();
  }

  setSpecieName(String value) {
    _specieName = value;
    notifyListeners();
  }

  Future<void> getDetails() async {
    try {
      String? homeworldUrl = character.homeworld;

      String? specieUrl =
          character.species.isNotEmpty ? character.species.first : null;

      List<Future> futures = [];

      if (homeworldUrl != null) {
        String planetId = homeworldUrl.split("/").lastWhere((e) => e != '');
        futures.add(PlanetsService().getPlanetById(planetId));
      }

      if (specieUrl != null) {
        String specieId = specieUrl.split("/").lastWhere((e) => e != '');
        futures.add(SpeciesService().getSpecieById(specieId));

        //can add 1 request for each specie
      }

      List<String> results = await Future.wait(List.from(futures));

      setPlanetName(results.first);
      setSpecieName(results.last);
    } catch (e) {
      Utils.showBottomMessage(context, Constants.errorMessage);
    }
  }
}
