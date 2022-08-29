import 'package:hive/hive.dart';

part 'shopping_item.g.dart';

@HiveType(typeId: 1)
class ShoppingItem extends HiveObject {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final int importance;
  @HiveField(2)
  final bool done;

  ShoppingItem({required this.text, required this.importance, required this.done});
}
