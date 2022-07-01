import 'package:flutter/material.dart';

// import 'package:flutter/src/widgets/container.dart';
// import 'package:flutter/src/widgets/framework.dart';

import './account_detail.dart';

class AllAccountsWidget extends StatelessWidget {
  // const AllAccountsWidget({super.key});
  final String id;
  final String userName;
  final String dateOfBirth;
  final String imageUrl;
  final String address;
  final String contactNumber;
  const AllAccountsWidget(
      {super.key,
      required this.id,
      required this.userName,
      required this.dateOfBirth,
      required this.imageUrl,
      required this.address,
      required this.contactNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {},
          child: Column(
            children: [
              Card(
                color: const Color.fromARGB(255, 185, 189, 192),
                // shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(15)),
                elevation: 4,
                // margin: const EdgeInsets.only(bottom: 15),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          // borderRadius: const BorderRadius.only(
                          //   topLeft: Radius.circular(15),
                          //   topRight: Radius.circular(15),
                          // ),
                          child: Image.network(
                            imageUrl,
                            // height: 250,
                            height: 150,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        // Positioned(
                        //   top: 0,
                        //   right: 0,
                        //   child: Container(
                        //     width: 100,
                        //     height: 40,
                        //     decoration: const BoxDecoration(
                        //         color: Colors.green,
                        //         borderRadius: BorderRadius.only(
                        //             topRight: Radius.circular(15.0))),
                        //     padding: const EdgeInsets.symmetric(
                        //         vertical: 8, horizontal: 10),
                        //     child: const Text(
                        //       "Available",
                        //       style:
                        //           TextStyle(fontSize: 20, color: Colors.white),
                        //       softWrap: true,
                        //       overflow: TextOverflow.fade,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            userName,
                            style: const TextStyle(fontSize: 25),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                  AccountDetail.routeName,
                                  arguments: id);
                            },
                            child: const Text(
                              "View More",
                              style: TextStyle(color: Colors.blue),
                            ),
                          ),
                          // Text(
                          //   "RS " + "$price",
                          //   style: TextStyle(
                          //     fontSize: 20,
                          //   ),
                          // )
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
