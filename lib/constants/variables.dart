import 'package:flutter/material.dart';
import '../data/models/characters.dart';

List<Character> allCharacters = [];
List<Character> searchedForCharacter = [];
bool isSearching = false;
bool searchType = false;
final searchTextController = TextEditingController();

