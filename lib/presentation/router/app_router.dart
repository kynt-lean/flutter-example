
import 'package:XLNT_APP/data/constans/constans.dart';
import 'package:XLNT_APP/data/models/categories/items/item.dart';
import 'package:XLNT_APP/presentation/screens/categories/item/item_detail_screen.dart';
import 'package:XLNT_APP/presentation/screens/categories/item/item_screen.dart';
import 'package:XLNT_APP/presentation/screens/default/default_screen.dart';
import 'package:XLNT_APP/presentation/screens/login_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:XLNT_APP/data/utilities/string_extension.dart';
class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/login':
        return MaterialPageRoute(
          builder: (_) => LoginScreen(),
        );
      case '/default':
        return MaterialPageRoute(
          builder: (_) => DefaultScreen(
            title:tr('main.title').toTitleCase(),
            color: colorMain,
          ),
        );
      case "/category/item":
        return MaterialPageRoute(
          builder: (_) => ItemScreen(
            title: tr('categories.item.title').toTitleCase(),
            color: colorMain,
          ),
        );
      case "/category/item/detail":
        final Item args = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => ItemDetailScreen(
            title: tr('categories.item.detail').toTitleCase(),
            color: colorMain,
            item: args,
          ),
        );
      default:
        return null;
    }
  }
}