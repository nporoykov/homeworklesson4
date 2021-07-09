import 'package:flutter/material.dart';

import 'cocktail_detail_page.dart';
import 'models/src/repository/sync_cocktail_repository.dart';

void main() {
  final cocktail = SyncCocktailRepository().getHomeworkCocktail();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      appBarTheme: AppBarTheme(
        brightness: Brightness.dark,
      ),
      fontFamily: 'SfProText',

    ),
    home: Material(child: CocktailDetailPage(cocktail)),
  ));
}
