import 'package:flutter/material.dart';

import '/provider/reporItem.dart';
import '../widgets/user_reports.dart';
import 'package:provider/provider.dart';

class UserReportsScreen extends StatefulWidget {
  static const routeName = "/User-Reports";
  const UserReportsScreen({super.key});

  @override
  State<UserReportsScreen> createState() => _UserReportsScreenState();
}

class _UserReportsScreenState extends State<UserReportsScreen> {
  var _isInit = true;
  var _isLoading = false;
  // ignore: unused_field
  var _showEmptyMessage = false;

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Alert!"),
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

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      try {
        await Provider.of<ReportItems>(context).fetchAndSetReport().then((_) {
          setState(() {
            _isLoading = false;
          });
        });
      } catch (error) {
        var errorMessage = "No Report Item Found";
        setState(() {
          _isLoading = false;
        });
        _showErrorDialog(errorMessage);
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final reportData = Provider.of<ReportItems>(context);
    final reports = reportData.reportItems;
    if (reports.isEmpty) {
      _showEmptyMessage = true;
    }

    final width = MediaQuery.of(context).size.width;

    double aspectHeight = 3 / 2;
    int noElement = 3;
    if (width >= 1300) {
      noElement = 3;
    } else if (width <= 1287 && width > 900) {
      noElement = 2;
    } else if (width <= 900 && width > 785) {
      noElement = 2;
      aspectHeight = 3 / 3;
    } else if (width <= 785 && width >= 669) {
      noElement = 2;
      aspectHeight = 3 / 3;
    } else if (width < 669 && width >= 570) {
      noElement = 2;
      aspectHeight = 2 / 3;
    } else if (width < 570) {
      noElement = 1;
      aspectHeight = 3 / 2;
    }

    return Scaffold(
      appBar: AppBar(title: const Center(child: Text("User Reports"))),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: const EdgeInsets.only(left: 100, right: 10, top: 20),
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 600,
                      padding: const EdgeInsets.only(
                          top: 40.0, left: 20, right: 20, bottom: 20),
                      child: GridView.builder(
                        padding: const EdgeInsets.all(10.0),
                        itemCount: reports.length,
                        itemBuilder: (ctx, int i) {
                          return UserReports(
                            reportId: reports[i].reportId,
                            imageUrl: reports[i].imageUrl,
                            reportData: reports[i].reportMessage,
                            itemId: reports[i].itemId,
                            itemOwnerEmail: reports[i].itemOwnerEmail,
                          );
                        },
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: noElement,
                            childAspectRatio: aspectHeight,
                            crossAxisSpacing: 30,
                            mainAxisSpacing: 30),
                      ),
                    ),
                  )),
                ],
              ),
            ),
    );
  }
}
