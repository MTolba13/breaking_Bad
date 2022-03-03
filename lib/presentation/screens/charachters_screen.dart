import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../businees_logic/cubit/characters_cubit.dart';
import '../../constansts/my_colors.dart';
import '../../data/models/charachters.dart';
import '../widgets/character_item.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCharacters;
  late List<Character> searchedForCharacters;
  bool isSearching = false;
  final serachTextController = TextEditingController();

  Widget buildSearchField() {
    return TextField(
      controller: serachTextController,
      cursorColor: MyColors.myGrey,
      decoration: const InputDecoration(
        hintText: 'Find a Character...',
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGrey,
          fontSize: 18,
        ),
      ),
      style: const TextStyle(
        color: MyColors.myGrey,
        fontSize: 18,
      ),
      onChanged: (searchedCharacters) {
        addSearchedForItemsToSearchedList(searchedCharacters);
      },
    );
  }

  void addSearchedForItemsToSearchedList(String searchedCharacters) {
    searchedForCharacters = allCharacters
        .where((character) =>
            character.name.toLowerCase().startsWith(searchedCharacters))
        .toList();

    setState(() {});
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearch,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void startSearch() {
    ModalRoute.of(context)!.addLocalHistoryEntry(
      LocalHistoryEntry(onRemove: stopSearcing),
    );
    setState(() {
      isSearching = true;
    });
  }

  void stopSearcing() {
    clearSearch();
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      serachTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();

    BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCharacters = (state).characters;
          return buildLoadedListWidgets();
        } else {
          return showLoadingIndicator();
        }
      },
    );
  }

  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      itemCount: serachTextController.text.isEmpty
          ? allCharacters.length
          : searchedForCharacters.length,
      itemBuilder: (ctx, index) {
        return CharacterItem(
            character: serachTextController.text.isEmpty
                ? allCharacters[index]
                : searchedForCharacters[index]);
      },
    );
  }

  Widget buildAppBarTitle() {
    return const Text(
      'Characters',
      style: TextStyle(
        color: MyColors.myGrey,
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Center(
      child: Container(
          color: MyColors.myWhite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Check Yor Internet Connection',
                style: TextStyle(
                  color: MyColors.myGrey,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/images/undraw_Page_not_found_re_e9o6.png',
                fit: BoxFit.cover,
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: isSearching
            ? const BackButton(
                color: MyColors.myGrey,
              )
            : Container(),
        backgroundColor: MyColors.myYellow,
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      body: OfflineBuilder(
        connectivityBuilder: (
          BuildContext context,
          ConnectivityResult connectivity,
          Widget child,
        ) {
          final bool connected = connectivity != ConnectivityResult.none;

          if (connected) {
            return buildBlocWidget();
          } else {
            return buildNoInternetWidget();
          }
        },
        child: showLoadingIndicator(),
      ),
      //  buildBlocWidget(),
    );
  }
}
