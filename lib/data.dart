import 'package:hive/hive.dart';
import 'package:shopy/model/shopping_item.dart';

class Boxes {
  static Box<ShoppingItem> getShoppingListBox() => Hive.box<ShoppingItem>("shoppingList");
}

List<ShoppingItem> shoppingList = [];
