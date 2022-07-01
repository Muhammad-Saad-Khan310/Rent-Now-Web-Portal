import 'package:flutter/material.dart';

import 'update_admin.dart';
// import './update_renter.dart';

class UserProfile extends StatelessWidget {
  final String adminId;
  final String userName;
  final String dateOfBirth;
  final String phoneNumber;
  final String address;
  final String imageUrl;
  // const UserProfile({Key? key}) : super(key: key);
  UserProfile(this.adminId, this.userName, this.dateOfBirth, this.phoneNumber,
      this.address, this.imageUrl);

  // Widget userField(String fieldName, IconData iconName) {
  //   return Container(
  //     margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
  //     width: 500,
  //     child: Row(
  //       children: [
  //         Icon(iconName),
  //         const SizedBox(
  //           width: 10,
  //         ),
  //         Text(
  //           fieldName,
  //           style: const TextStyle(fontSize: 20),
  //         ),
  //       ],
  //     ),
  //     decoration: const BoxDecoration(
  //       border: Border(
  //         bottom: BorderSide(color: Colors.black),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              ClipPath(
                // clipper: CustomClipPath(),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        // decoration: BoxDecoration(color: Colors.red),
                        margin: const EdgeInsets.only(
                          top: 40.4,
                        ),
                        width: double.infinity,
                        height: 200,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.teal,
                          child: CircleAvatar(
                            radius: 90,
                            backgroundImage: NetworkImage(imageUrl),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      userName,
                      style: TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Admin Of RentNow",
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            const Text(
                              "Date Of Birth:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 45.0),
                            ),
                            Text(
                              dateOfBirth,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            const Text(
                              "Phone No:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 45.0),
                            ),
                            Text(
                              phoneNumber,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            const Text(
                              "Address:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 45.0),
                            ),
                            Text(
                              address,
                              style: TextStyle(fontSize: 20),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          // Container(
          //   color: Color.fromARGB(255, 165, 218, 212),
          //   child: Column(
          //     children: [
          //       // userField("userName", Icons.person),
          //       // userField("dateOfBirth", Icons.date_range),
          //       // userField("phoneNumber", Icons.phone),
          //       // userField("address", Icons.home),
          //       SizedBox(
          //         height: 50,
          //       )
          //     ],
          //   ),
          // ),

          const SizedBox(
            height: 25,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ButtonTheme(
              minWidth: MediaQuery.of(context).size.width,
              height: 60.0,
              child: ElevatedButton(
                style: ButtonStyle(
                  padding: MaterialStateProperty.all<EdgeInsets>(
                    const EdgeInsets.only(
                        left: 130.0, right: 130.0, top: 20, bottom: 20),
                  ),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  "Update Profile",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(UpdateAdmin.routeName, arguments: adminId);
                },
              ),
            ),
          ),

          // GestureDetector(
          //   onTap: (() {
          //     Navigator.of(context)
          //         .pushNamed(UpdateRenter.routeName, arguments: renterId);
          //   }),
          //   child: const Align(
          //     alignment: Alignment.bottomCenter,
          //     child: Text("Update"),
          //   ),
          // )
        ],
      ),
    );
    //   ),
    // );
  }
}

// class CustomClipPath extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     // double w = size.width;
//     // double h = size.height;
//     final path = Path();
//     path.lineTo(0, size.height);
//     path.quadraticBezierTo(
//         size.width / 2, size.height - 100, size.width, size.height);
//     path.lineTo(size.width, 0);
//     // path.lineTo(0, h);
//     // path.quadraticBezierTo(w, h, 0, 0);
//     // path.lineTo(w, h);
//     // path.lineTo(w, 0);
//     // // from 1 to 5 line is created by close button
//     // path.close();
//     return path;
//     // TODO: implement getClip
//     throw UnimplementedError();
//   }

//   @override
//   bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
//     return false;
//     // TODO: implement shouldReclip
//     throw UnimplementedError();
//   }
// }
