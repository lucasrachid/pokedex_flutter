import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/common/repository/pokemon_repository.dart';
import 'package:pokedex_flutter/common/routes/route.dart';
import 'package:pokedex_flutter/features/pokedex/screens/home/container/home_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex 2k23',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: PokedexRoute(
        pokemonRepository: PokemonRepository(
          dio: Dio(),
        ),
      ),
    );
  }
}
