import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:provider/provider.dart';
import '../provider/accounts.dart';

class AccountDetail extends StatelessWidget {
  static const routeName = "/account-detail";
  const AccountDetail({super.key});

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
            // Text(
            //   fieldName + ":  ",
            //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            // ),
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

  @override
  Widget build(BuildContext context) {
    final accountId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedAccount =
        Provider.of<UserAccounts>(context, listen: false).findById(accountId);
    return Scaffold(
        appBar: AppBar(
          title: const Text("User Account Detail"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.only(
                top: 30, left: 100, right: 20, bottom: 10),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 550,
                  child: Center(
                    child: Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2,
                          height: 550,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20)),
                            child: Image.network(
                                fit: BoxFit.fill, loadedAccount.imageUrl),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 3,
                          height: 550,
                          // padding: EdgeInsets.only(left: 20),
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  bottomRight: Radius.circular(20)),
                              color: Color.fromARGB(255, 193, 203, 211)),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 60.0, left: 10),
                            child: Column(
                              children: [
                                textRepresntaion(
                                    Icons.title, loadedAccount.userName),
                                const SizedBox(
                                  height: 15,
                                ),
                                textRepresntaion(Icons.date_range,
                                    loadedAccount.dateOfBirth),
                                const SizedBox(
                                  height: 15,
                                ),
                                textRepresntaion(
                                    Icons.phone, loadedAccount.phoneNumber),
                                const SizedBox(
                                  height: 15,
                                ),
                                textRepresntaion(
                                    Icons.home, loadedAccount.address),
                                const SizedBox(
                                  height: 15,
                                ),
                                const SizedBox(
                                  height: 45,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 70, right: 70),
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
                                            onPressed: () {},
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
                                              Provider.of<UserAccounts>(context,
                                                      listen: false)
                                                  .deleteItem(accountId);
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
                // const SizedBox(
                //   height: 60,
                // ),
                // Container(
                //   padding: const EdgeInsets.only(left: 100, right: 100),
                //   width: MediaQuery.of(context).size.width / 2,

                //   // width: 1300,
                //   height: 400,
                //   decoration: BoxDecoration(
                //     color: const Color.fromARGB(255, 193, 203, 211),
                //     borderRadius: BorderRadius.circular(25),
                //   ),
                //   child: Container(
                //       padding: const EdgeInsets.only(top: 50),
                //       child: Column(
                //         children: [
                //           const Text(
                //             "Item Request",
                //             style: TextStyle(
                //                 fontSize: 20, fontWeight: FontWeight.bold),
                //           ),
                //           const SizedBox(
                //             height: 40,
                //           ),
                //           Row(
                //             children: [
                //               Container(
                //                 width: 100,
                //                 height: 50,
                //                 decoration: const BoxDecoration(
                //                     borderRadius:
                //                         BorderRadius.all(Radius.circular(24)),
                //                     color: Color.fromARGB(255, 10, 240, 60)),
                //                 child: TextButton(
                //                     onPressed: () {},
                //                     child: Text(
                //                       "Accept",
                //                       style: TextStyle(color: Colors.white),
                //                     )),
                //               )
                //             ],
                //           )
                //         ],
                //       )),
                // )
              ],
            ),
          ),
        ));
  }
}
