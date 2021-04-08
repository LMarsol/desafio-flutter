import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:star_wars_wiki/core/models/character.dart';
import 'package:star_wars_wiki/ui/utils/ui_constants.dart';
import 'package:star_wars_wiki/core/viewmodels/home_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final HomeModel _homeModel = HomeModel();

  @override
  void initState() {
    _homeModel.context = context;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _homeModel,
      child: Consumer<HomeModel>(
        builder: (context, model, child) => Scaffold(
          appBar: AppBar(
            title: Text(UIConstants.appTitle),
            centerTitle: true,
          ),
          body: Container(
            child: model.isLoading && model.getCharacters().isEmpty
                ? _buildLoading()
                : _buildBody(
                    context,
                    model,
                  ),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  UIConstants.homeBg,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: model.onFavoriteModeChanged,
            backgroundColor: model.favoriteMode ? Colors.black : Colors.yellow,
            child: Icon(
              model.favoriteMode ? Icons.star : Icons.star_outline_outlined,
              color: model.favoriteMode ? Colors.yellow : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, HomeModel model) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: model.getCharacters().length,
      itemBuilder: (context, index) {
        if (index == model.getCharacters().length - 3) {
          model.getPerson();
        }

        if (index == model.getCharacters().length - 1 && model.hasMore) {
          return _buildLoading();
        }

        Character character = model.getCharacters()[index];
        bool favorite = model.favorites.indexOf(character.name) != -1;

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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [],
                  ),
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
                        onTap: () => model.onItemFavorite(character, favorite),
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
      },
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

  Widget _buildLoading() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
