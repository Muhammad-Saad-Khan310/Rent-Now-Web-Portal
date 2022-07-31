import 'package:adminportal/widgets/emailForm.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../provider/reporItem.dart';

class UserReports extends StatelessWidget {
  // const UserReports({super.key});

  final String reportId;
  final String imageUrl;
  final String reportData;
  final String itemId;
  final String itemOwnerEmail;

  const UserReports(
      {super.key,
      required this.reportId,
      required this.imageUrl,
      required this.reportData,
      required this.itemId,
      required this.itemOwnerEmail});

  void _showImage(ctx, String imageUrl) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        content: Image(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        ),
      ),
    );
  }

  void _showAlertMessage(ctx, String itemId) {
    showDialog(
      context: ctx,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert!"),
        content: const Text("Are sure you want to delete this Item"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: const Text("No")),
          TextButton(
            child: const Text("Yes"),
            onPressed: () {
              Provider.of<ReportItems>(ctx, listen: false)
                  .deleteReportItem(itemId, reportId);

              Navigator.of(ctx).pushNamed(EmailForm.routeName, arguments: {
                "image": imageUrl,
                "itemOwnerEmail": itemOwnerEmail
              });
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 2000,
        margin: const EdgeInsets.only(left: 0, right: 0, top: 0),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3))
        ]),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  _showImage(context, imageUrl);
                },
                child: Image(
                  image: NetworkImage(imageUrl),
                  height: 125,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Report",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        onPressed: () {
                          _showAlertMessage(context, itemId);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
                child: Text(reportData),
              )
            ],
          ),
        ));
  }
}
