// ignore_for_file: use_build_context_synchronously

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/http_exception.dart';
import '../provider/accounts.dart';
import '../screens/all_item.dart';

class UpdateAdmin extends StatefulWidget {
  static const routeName = "/update-renter";
  const UpdateAdmin({Key? key}) : super(key: key);

  @override
  State<UpdateAdmin> createState() => _UpdateAdminState();
}

class _UpdateAdminState extends State<UpdateAdmin> {
  File? file;
  UploadTask? task;
  bool imageSelected = false;

  final _formKey = GlobalKey<FormState>();

  var _updateAdmin = Account(
      id: "",
      userName: "",
      dateOfBirth: "",
      phoneNumber: "",
      address: "",
      imageUrl: "");

  var _initValues = {
    'userName': '',
    'dateOfBirth': '',
    'imageUrl': '',
    'phoneNumber': '',
    'address': '',
  };
  var _isInit = true;
  // ignore: unused_field
  final _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final renterId = ModalRoute.of(context)!.settings.arguments as String?;

      _updateAdmin =
          Provider.of<UserAccounts>(context, listen: false).findById(renterId!);

      _initValues = {
        'userName': _updateAdmin.userName,
        'dateOfBirth': _updateAdmin.dateOfBirth,
        'phoneNumber': _updateAdmin.phoneNumber,
        'imageUrl': _updateAdmin.imageUrl,
        'address': _updateAdmin.address,
      };
      // }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  InputDecoration _fieldDecoration(String fieldName, IconData iconName) {
    return InputDecoration(
      labelText: fieldName,
      prefixIcon: Icon(
        iconName,
        color: Colors.teal,
      ),
      filled: true,
      fillColor: const Color.fromRGBO(255, 255, 255, 100),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState!.save();
    try {
      await Provider.of<UserAccounts>(context, listen: false)
          .updateAdmin(_updateAdmin.id, _updateAdmin);
    } on HttpException catch (error) {
      await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text("some error"),
                content: Text(error.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text("Ok"))
                ],
              ));
    } catch (error) {
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Error occurs"),
          content: const Text("Please check your internet connection"),
          actions: [
            TextButton(
              child: const Text("Ok"),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            )
          ],
        ),
      );
    }
    Navigator.of(context).pushNamed(AllItem.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Admin")),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 55.0, 0, 10.0),
                  child: Text(
                    "Update Admin",
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      Builder(
                        builder: (context) => Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: CircleAvatar(
                                radius: 60,
                                child: ClipOval(
                                  child: SizedBox(
                                      width: 180,
                                      height: 180.0,
                                      child: file != null
                                          ? Image.file(
                                              file!,
                                              fit: BoxFit.contain,
                                            )
                                          : Image.network(
                                              _updateAdmin.imageUrl,
                                              fit: BoxFit.cover,
                                            )),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 500,
                        child: TextFormField(
                          initialValue: _initValues["userName"],
                          decoration:
                              _fieldDecoration("User Name", Icons.person),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            _updateAdmin = Account(
                              id: _updateAdmin.id,
                              userName: value!,
                              dateOfBirth: _updateAdmin.dateOfBirth,
                              phoneNumber: _updateAdmin.phoneNumber,
                              imageUrl: _updateAdmin.imageUrl,
                              address: _updateAdmin.address,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 500,
                        child: TextFormField(
                          initialValue: _initValues["dateOfBirth"],
                          decoration: _fieldDecoration(
                              "Date Of Birth", Icons.calendar_today_rounded),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            _updateAdmin = Account(
                              id: _updateAdmin.id,
                              userName: _updateAdmin.userName,
                              dateOfBirth: value!,
                              phoneNumber: _updateAdmin.phoneNumber,
                              imageUrl: _updateAdmin.imageUrl,
                              address: _updateAdmin.address,
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        width: 500,
                        child: TextFormField(
                          initialValue: _initValues["phoneNumber"],
                          decoration:
                              _fieldDecoration("Phone Number", Icons.phone),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            _updateAdmin = Account(
                              id: _updateAdmin.id,
                              userName: _updateAdmin.userName,
                              dateOfBirth: _updateAdmin.dateOfBirth,
                              phoneNumber: value!,
                              imageUrl: _updateAdmin.imageUrl,
                              address: _updateAdmin.address,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: 500,
                        child: TextFormField(
                          initialValue: _initValues["address"],
                          decoration: _fieldDecoration("Address", Icons.house),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            _updateAdmin = Account(
                              id: _updateAdmin.id,
                              userName: _updateAdmin.userName,
                              dateOfBirth: _updateAdmin.dateOfBirth,
                              phoneNumber: _updateAdmin.phoneNumber,
                              imageUrl: _updateAdmin.imageUrl,
                              address: value!,
                            );
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 55,
                      ),
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width,
                        height: 60.0,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            padding: MaterialStateProperty.all<EdgeInsets>(
                              const EdgeInsets.only(
                                  left: 130.0,
                                  right: 130.0,
                                  top: 20,
                                  bottom: 20),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),
                          ),
                          child: const Text(
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () {
                            _submit();
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  basename(String pat) {
    String actualPath = pat.split("/").last;
    return Text(
      actualPath,
      style: const TextStyle(color: Colors.black),
    );
  }
}
