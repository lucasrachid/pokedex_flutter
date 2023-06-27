import 'package:flutter/material.dart';
import 'package:pokedex_flutter/common/models/pokemon.dart';
import 'package:pokedex_flutter/common/exceptions/custom_exception.dart';
import 'package:pokedex_flutter/common/repository/pokemon_repository.dart';
import 'package:pokedex_flutter/common/widgets/po_error.dart';
import 'package:pokedex_flutter/common/widgets/po_loading.dart';
import 'package:pokedex_flutter/features/pokedex/screens/details/container/details_container.dart';
import 'package:pokedex_flutter/features/pokedex/screens/home/pages/home_page.dart';

class HomeContainer extends StatelessWidget {
  const HomeContainer({
    Key? key,
    required this.pokemonRepository,
    required this.onItemTap,
  }) : super(key: key);
  final IPokemonRepository pokemonRepository;
  final Function(String, DetailArguments) onItemTap;

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
            return HomePage(list: snapshot.data!, onItemTap: onItemTap);
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
