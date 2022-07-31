// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/items.dart';

class ItemDetail extends StatelessWidget {
  static const routeName = "/item-detail";

  const ItemDetail({super.key});

  Widget textRepresntaion(IconData iconName, String fieldValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black),
          ),
        ),
        width: 300,
        child: Row(
          children: [
            Icon(
              iconName,
              size: 40,
            ),
            const SizedBox(
              width: 25,
            ),
            Text(
              fieldValue,
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget LargeTextRepresntaion(IconData iconName, String fieldValue) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.black),
          ),
        ),
        width: 300,
        child: Row(
          children: [
            Icon(
              iconName,
              size: 40,
            ),
            const SizedBox(
              width: 25,
            ),
            Expanded(
              child: Text(
                fieldValue,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.justify,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedItem =
        Provider.of<Items>(context, listen: false).findById(itemId);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Item Request page"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                top: 30,
                left: MediaQuery.of(context).size.width * 0.2,
                right: 20,
                bottom: 10),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 550,
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: 550,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: Image.network(
                              loadedItem.imageUrl,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 550,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Color.fromARGB(255, 193, 203, 211)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60.0, left: 10),
                            child: Column(
                              children: [
                                textRepresntaion(Icons.title, loadedItem.title),
                                const SizedBox(
                                  height: 15,
                                ),
                                textRepresntaion(Icons.money, loadedItem.price),
                                const SizedBox(
                                  height: 15,
                                ),
                                textRepresntaion(
                                    Icons.phone, loadedItem.phoneNumber),
                                const SizedBox(
                                  height: 15,
                                ),
                                LargeTextRepresntaion(
                                    Icons.home, loadedItem.address),
                                const SizedBox(
                                  height: 15,
                                ),
                                LargeTextRepresntaion(
                                    Icons.details, loadedItem.description),
                                const SizedBox(
                                  height: 45,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      left: 70, right: 70),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        width: 100,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24)),
                                            color: Color.fromARGB(
                                                255, 10, 240, 60)),
                                        child: TextButton(
                                            onPressed: () {
                                              Provider.of<Items>(context,
                                                      listen: false)
                                                  .acceptItem(itemId);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "Accept",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                      Container(
                                        width: 100,
                                        height: 50,
                                        decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24)),
                                            color: Color.fromARGB(
                                                255, 247, 54, 5)),
                                        child: TextButton(
                                            onPressed: () {
                                              Provider.of<Items>(context,
                                                      listen: false)
                                                  .deleteItem(itemId);
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              "Delete",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            )),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
