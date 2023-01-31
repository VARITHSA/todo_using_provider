import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_using_provider/providers.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

late TextEditingController _controller;

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: "Enter the Text",
              ),
            ),
            const ElevatedButtons(),
            const ItemList()
          ],
        ),
      ),
    );
  }
}

class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemData>(
      builder: ((context, value, child) {
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: value.size,
          itemBuilder: ((context, index) {
            final item = value.items[index];
            return GestureDetector(
              onLongPress: () => value.removeItem(item),
              child: Container(
                // padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey,
                    child: Text(item.item[0]),
                  ),
                  title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.item,
                          style: TextStyle(
                              decoration: item.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                        Checkbox(
                            value: item.completed,
                            onChanged: ((_) => value.toggleItem(item)))
                      ]),
                ),
              ),
            );
          }),
        );
      }),
    );
  }
}

class ElevatedButtons extends StatelessWidget {
  const ElevatedButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ItemData>(
      builder: (context, value, child) => ElevatedButton(
          onPressed: () {
            value.addItem(Item(item: _controller.text));
            print(_controller.text);
          },
          child: const Text('add')),
    );
  }
}
