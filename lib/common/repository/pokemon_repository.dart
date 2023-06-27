import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:pokedex_flutter/common/consts/api_consts.dart';
import 'package:pokedex_flutter/common/exceptions/custom_exception.dart';
import 'package:pokedex_flutter/common/models/pokemon.dart';

abstract class IPokemonRepository {
  Future<List<Pokemon>> findAllPokemons();
}

class PokemonRepository implements IPokemonRepository {
  final Dio dio;

  PokemonRepository({required this.dio});

  @override
  Future<List<Pokemon>> findAllPokemons() async {
    try {
      final response = await dio.get(ApiConsts.allPokemonsUrl);
      final json = jsonDecode(response.data) as Map<String, dynamic>;
      final list = json['pokemon'] as List<dynamic>;
      return list.map((element) => Pokemon.fromMap(element)).toList();
    } catch (e) {
      throw CustomException(message: 'Erro ao buscar Pokemons!');
    }
  }
}
