import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_breaking/business_logic/cubit/characters_cubit.dart';
import 'package:flutter_breaking/constants/my_colors.dart';
import 'package:flutter_breaking/constants/strings.dart';
import 'package:flutter_breaking/presentation/screens/settings_screen.dart';
import 'package:flutter_breaking/presentation/widgets/search_bar.dart';
import 'package:flutter_offline/flutter_offline.dart';
import '../../constants/variables.dart';
import '../../data/models/characters.dart';
import '../widgets/character_item.dart';
import '../widgets/circular_progress_indicator.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({Key? key}) : super(key: key);

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<CharactersCubit>(context)
        .getAllCharacters()
        .cast<Character>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: isSearching ? buildSearchField() : buildAppBarTitle(),
        actions: buildAppBarActions(),
      ),
      drawer: Drawer(
        backgroundColor: MyColors.myWhite,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 25, 15, 15),
            child: Column(
              children: [
                InkWell(
                  child: Row(
                    children: [
                      Icon(
                        Icons.settings,
                        size: 26.0,
                        color: MyColors.myGrey,
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Settings',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: MyColors.myGrey,
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, settingsScreen);
                  },
                ),
              ],
            ),
          ),
        ),
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
        child: myCircularProgressIndicator(
          isCenter: true,
          color: MyColors.myYellow,
        ),
      ),
    );
  }

  Widget buildNoInternetWidget() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/no_internet.png'),
            SizedBox(
              height: 20.0,
            ),
            Column(
              children: [
                Text(
                  'Oops!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  'Check your internet connection!',
                  style: TextStyle(
                    fontSize: 18.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void addSearchedItemsToSearchedCharactersList(String searchedCharacter) {
    setState(() {
      if (searchType == true) {
        searchedForCharacter = allCharacters
            .where((character) => character.name
                .toLowerCase()
                .contains(searchedCharacter.toLowerCase()))
            .toList();
      } else {
        searchedForCharacter = allCharacters
            .where((character) => character.name
                .toLowerCase()
                .startsWith(searchedCharacter.toLowerCase()))
            .toList();
      }
    });
  }

  Widget buildSearchField() {
    return mySearchTextFormField(
      controller: searchTextController,
      borderType: InputBorder.none,
      onChanged: (searchedCharacter) {
        addSearchedItemsToSearchedCharactersList(searchedCharacter);
      },
      hintText: 'Find a character...',
      hintTextStyle: TextStyle(
        color: MyColors.myGrey,
        fontSize: 18.0,
      ),
      style: TextStyle(
        color: MyColors.myGrey,
        fontSize: 18.0,
      ),
    );
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
      if (state is CharactersLoaded) {
        allCharacters = (state).characters.cast<Character>();
        return buildLoadedListWidgets();
      } else {
        return myCircularProgressIndicator(
            isCenter: true, color: MyColors.myGrey);
      }
    });
  }

  Widget buildLoadedListWidgets() {
    return SingleChildScrollView(
        child: Container(
      color: MyColors.myGrey,
      child: Column(children: [
        buildCharactersList(),
      ]),
    ));
  }

  Widget buildCharactersList() {
    final charactersToDisplay =
        isSearching ? searchedForCharacter : allCharacters;
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: charactersToDisplay.length,
      itemBuilder: (context, index) {
        return CharacterItem(
          character: charactersToDisplay[index],
        );
      },
    );
  }

  Widget buildAppBarTitle() {
    return Text(
      'Characters',
      style: TextStyle(color: MyColors.myGrey),
    );
  }

  List<Widget> buildAppBarActions() {
    if (isSearching) {
      return [
        IconButton(
          onPressed: () {
            clearSearch();
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.clear,
            color: MyColors.myGrey,
          ),
        ),
      ];
    } else {
      return [
        IconButton(
          onPressed: startSearching,
          icon: const Icon(
            Icons.search,
            color: MyColors.myGrey,
          ),
        ),
      ];
    }
  }

  void startSearching() {
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: stopSearching));

    setState(() {
      isSearching = true;
    });
  }

  void stopSearching() {
    clearSearch();

    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchTextController.clear();
    });
  }
}
