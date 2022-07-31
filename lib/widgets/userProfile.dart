// ignore_for_file: file_names, prefer_const_constructors_in_immutables
import 'package:flutter/material.dart';

import 'update_admin.dart';

class UserProfile extends StatelessWidget {
  final String adminId;
  final String userName;
  final String dateOfBirth;
  final String phoneNumber;
  final String address;
  final String imageUrl;

  UserProfile(this.adminId, this.userName, this.dateOfBirth, this.phoneNumber,
      this.address, this.imageUrl,
      {super.key});

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.width * 0.03;
    var v = MediaQuery.of(context).size.width * 0.02;
    return SingleChildScrollView(
      child: Column(
        children: [
          Column(
            children: [
              ClipPath(
                child: Column(
                  children: [
                    Center(
                      child: Container(
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
                      style: const TextStyle(
                          fontSize: 50.0, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      "Admin Of RentNow",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              "Date Of Birth:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: h),
                            ),
                            Text(
                              dateOfBirth,
                              style: TextStyle(fontSize: v),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              "Phone No:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: h),
                            ),
                            Text(
                              phoneNumber,
                              style: TextStyle(fontSize: v),
                            )
                          ],
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              "Address:",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: h),
                            ),
                            Text(
                              address,
                              style: TextStyle(fontSize: v),
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
        ],
      ),
    );
  }
}
