import 'package:flutter/material.dart';

import '../widgets/item_detail.dart';

class AllItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final String description;
  final String address;
  final String price;
  final String phoneNumber;
  const AllItemWidget(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl,
      required this.description,
      required this.address,
      required this.price,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(ItemDetail.routeName, arguments: id);
          },
          child: Column(
            children: [
              Card(
                color: const Color.fromARGB(255, 185, 189, 192),
                elevation: 4,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          child: Image.network(
                            imageUrl,
                            // height: 250,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(fontSize: 25),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  ItemDetail.routeName,
                                  arguments: id);
                            },
                            child: const Text(
                              "View More",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
