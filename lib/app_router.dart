import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'businees_logic/cubit/characters_cubit.dart';
import 'constansts/strings.dart';
import 'data/models/charachters.dart';
import 'data/repositeries/characters_repository.dart';
import 'data/web_services/charachters_api.dart';
import 'presentation/screens/charachters_details.dart';
import 'presentation/screens/charachters_screen.dart';

class AppRouter {
  late CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;

  AppRouter() {
    charactersRepository =
        CharactersRepository(characterswebServices: CharactersWebServices());

    charactersCubit = CharactersCubit(charactersRepository);
  }

  Route? generatRoute(RouteSettings settings) {
    switch (settings.name) {
      case charchtersScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => charactersCubit,
            child: const CharactersScreen(),
          ),
        );

      case charachtersDetailsScreen:
        final character = settings.arguments as Character;

        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CharactersCubit(charactersRepository),
            child: CharachtersDetailsScreen(character: character),
          ),
        );
    }
  }
}
