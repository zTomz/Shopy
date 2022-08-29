import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:shopy/data.dart';
import 'package:shopy/model/shopping_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController itemController = TextEditingController();
  int importance = 0;
  /*
  Normal, Important, Absolute
  */

  Box<ShoppingItem> shoppingListBox = Boxes.getShoppingListBox();

  @override
  void dispose() {
    itemController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: "Add",
        onPressed: () {
          if (itemController.text == "") {
            return;
          }

          shoppingListBox.add(
            ShoppingItem(
              text: itemController.text,
              importance: importance,
              done: false,
            ),
          );

          setState(() {
            itemController.text = "";
            importance = 0;
          });
        },
        child: const Icon(Icons.add_rounded),
      ),
      body: ValueListenableBuilder(
          valueListenable: shoppingListBox.listenable(),
          builder: (context, Box<ShoppingItem> _shoppingList, _) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 45),
                  TextField(
                    controller: itemController,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      label: const Text("New item"),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            importance += 1;
                            if (importance == 3) {
                              importance = 0;
                            }
                          });
                        },
                        splashRadius: 10,
                        icon: const Icon(Icons.category),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12.5, vertical: 7.5),
                        decoration: BoxDecoration(
                            color: getImportanceColor(importance),
                            borderRadius: BorderRadius.circular(15)),
                        child: Text(
                          getImportance(importance),
                          style: const TextStyle(
                            color: Color(0xFFEDF2F4),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _shoppingList.values.length,
                      itemBuilder: (context, index) => Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 5),
                        child: DottedBorder(
                          color: const Color(0xFF2b2d42),
                          strokeCap: StrokeCap.round,
                          dashPattern: const [20, 15],
                          strokeWidth: 5,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 5),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _shoppingList.getAt(index)!.text,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                                Container(
                                  margin: const EdgeInsets.all(10),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.5, vertical: 7.5),
                                  decoration: BoxDecoration(
                                    color: getImportanceColor(
                                        _shoppingList.getAt(index)!.importance),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Text(
                                    getImportance(
                                        _shoppingList.getAt(index)!.importance),
                                    style: const TextStyle(
                                      color: Color(0xFFEDF2F4),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  Color getImportanceColor(int _importance) {
    if (_importance == 0) {
      return const Color(0xFFa7c957);
    }
    if (_importance == 1) {
      return const Color(0xFFeb5e28);
    }
    return const Color(0xFFd62828);
  }

  String getImportance(int _importance) {
    if (_importance == 0) {
      return "Normal";
    }
    if (_importance == 1) {
      return "Important";
    }
    return "Absolute";
  }
}
