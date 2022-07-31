// ignore_for_file: file_names, non_constant_identifier_names, use_build_context_synchronously

import 'package:adminportal/screens/all_item.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

import "../provider/reporItem.dart";

class EmailForm extends StatefulWidget {
  static const routeName = "/email-form";

  const EmailForm({super.key});

  @override
  State<EmailForm> createState() => _EmailFormState();
}

class _EmailFormState extends State<EmailForm> {
  final _form = GlobalKey<FormState>();
  var _isLoading = false;
  var itemOwnerEmail = "";
  var reportMessage = "";
  var subject = "";
  var image = "";
  var message = "";

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("An error occured!"),
        content: Text(message),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Ok"))
        ],
      ),
    );
  }

  InputDecoration Decoration(String fieldName, IconData iconName) {
    return InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(
          iconName,
          color: Colors.teal,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }

  InputDecoration MessageDecoration(String fieldName, IconData iconName) {
    return InputDecoration(
        labelText: fieldName,
        prefixIcon: Icon(
          iconName,
          color: Colors.teal,
        ),
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10.0)));
  }

  Future<void> _submit() async {
    final isValid = _form.currentState!.validate();
    if (!isValid) {
      return;
    }
    _form.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    final reportData = (ModalRoute.of(context)!.settings.arguments ??
        <String, dynamic>{}) as Map;
    itemOwnerEmail = reportData["itemOwnerEmail"];
    image = reportData["image"];
    try {
      await Provider.of<ReportItems>(context, listen: false).sendEmail(
        image,
        itemOwnerEmail,
        message,
        subject,
      );
      Navigator.of(context).pushReplacementNamed(AllItem.routeName);
    } catch (error) {
      var errorMessage =
          "Item is deleted but email could not send. Please try again later.";
      _showErrorDialog(errorMessage);
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    double Lposition = MediaQuery.of(context).size.width * 0.5;
    double cardHeight = MediaQuery.of(context).size.width * 0.32;
    if (w <= 690) {
      Lposition = 30;
      cardHeight = MediaQuery.of(context).size.width * 0.6;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Send Email")),
      ),
      body: Stack(
        children: [
          Positioned(
              top: MediaQuery.of(context).size.height * 0.15,
              left: MediaQuery.of(context).size.width * 0.0,
              child: Image(
                image: const NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/rentnow-f12ca.appspot.com/o/files%2Fundraw_Newsletter_re_wrob%20(1).png?alt=media&token=0ea684d9-82dc-4ff8-88fd-0ad195c69e6d"),
                width: MediaQuery.of(context).size.height * 0.9,
                height: h * 0.5,
              )),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.05,
            left: Lposition,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                      left: w * 0.02, top: h * 0.03, right: w * 0.02),
                  width: cardHeight,
                  height: MediaQuery.of(context).size.height * 0.69,
                  decoration: BoxDecoration(color: Colors.white, boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3))
                  ]),
                  child: Form(
                    key: _form,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Subject",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextFormField(
                          decoration: Decoration("Subject", Icons.subject),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            subject = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Subject";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.05,
                        ),
                        const Text("Message",
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        TextFormField(
                          decoration:
                              MessageDecoration("Message", Icons.message),
                          maxLines: 3,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.name,
                          onSaved: (value) {
                            message = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Please enter Subject";
                            }
                            return null;
                          },
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Send Email",
                              style: TextStyle(
                                  fontSize: w * 0.02,
                                  fontWeight: FontWeight.bold),
                            ),
                            _isLoading
                                ? const Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : CircleAvatar(
                                    radius: w * 0.02,
                                    child: IconButton(
                                      onPressed: () {
                                        _submit();
                                      },
                                      icon: const Icon(
                                          Icons.arrow_forward_rounded),
                                      iconSize: w * 0.02,
                                    ),
                                  ),
                          ],
                        )
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
  }
}
