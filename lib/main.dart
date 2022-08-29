// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';
import 'package:shopy/data.dart';
import 'package:shopy/home.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopy/model/shopping_item.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(ShoppingItemAdapter());
  await Hive.openBox<ShoppingItem>("shoppingList");

  Box<ShoppingItem> shoppingListBox = Boxes.getShoppingListBox();

  int i = 0;
  while (shoppingListBox.get(i) != null) {
    // print(shoppingListBox.get(i));
    shoppingList.add(shoppingListBox.get(i)!);
    i += 1;
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (ColorScheme? lightDynamic, ColorScheme? dark) {
        ColorScheme lightColorScheme;
        ColorScheme darkColorScheme;

        if (lightDynamic != null && dark != null) {
          lightColorScheme = lightDynamic.harmonized()..copyWith();
          darkColorScheme = dark.harmonized();
        } else {
          lightColorScheme = ColorScheme.fromSeed(
            seedColor: const Color(0xFFEF233C),
          );
          darkColorScheme = ColorScheme.fromSeed(
            seedColor: const Color(0xFFEF233C),
            brightness: Brightness.dark,
          );
        }

        return MaterialApp(
          title: 'Shopy',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
          darkTheme:
              ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
          home: const Home(),
        );
      },
    );
  }
}
