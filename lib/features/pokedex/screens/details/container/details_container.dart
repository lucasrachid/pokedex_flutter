import 'package:flutter/material.dart';
import 'package:pokedex_flutter/common/exceptions/custom_exception.dart';
import 'package:pokedex_flutter/common/models/pokemon.dart';
import 'package:pokedex_flutter/common/repository/pokemon_repository.dart';
import 'package:pokedex_flutter/common/widgets/po_error.dart';
import 'package:pokedex_flutter/common/widgets/po_loading.dart';
import 'package:pokedex_flutter/features/pokedex/screens/details/pages/details_page.dart';

class DetailArguments {
  DetailArguments({required this.pokemon});
  final Pokemon pokemon;
}

class DetailsContainer extends StatelessWidget {
  const DetailsContainer(
      {Key? key, required this.pokemonRepository, required this.arguments})
      : super(key: key);
  final IPokemonRepository pokemonRepository;
  final DetailArguments arguments;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Pokemon>>(
        future: pokemonRepository.findAllPokemons(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return PoLoading();
          }

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return DetailsPage(
              pokemon: arguments.pokemon,
              list: snapshot.data!,
            );
          }

          if (snapshot.hasError) {
            return PoError(
              error: (snapshot.error as CustomException).message!,
            );
          }

          return Container();
        });
  }
}
