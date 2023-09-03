import 'dart:async';

import 'package:check_internet/utils.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';


class InternetCheck extends StatelessWidget {
  static final String title = 'Has Internet?';

  const InternetCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: ThemeData(primarySwatch: Colors.teal),
        home: CheckNetwork(),
      ),
    );
  }
}

class CheckNetwork extends StatefulWidget {
  const CheckNetwork({Key? key}) : super(key: key);

  @override
  State<CheckNetwork> createState() => _CheckNetworkState();
}

class _CheckNetworkState extends State<CheckNetwork> {
  late StreamSubscription subscription;

  // Without button click for automatically connection.
  @override
  void initState() {
    super.initState();

    subscription = Connectivity().onConnectivityChanged.listen(showConnectivitySnackBar);
  }

  @override
  void dispose() {
    super.dispose();

    subscription.cancel();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(InternetCheck.title),
    ),
    body: Center(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(12)
        ),
         child: Text('Check Connection', style: TextStyle(fontSize: 20)),
        onPressed: () async {
          final result = await Connectivity().checkConnectivity();
          showConnectivitySnackBar(result);
        },
      ),
    ),
  );

  void showConnectivitySnackBar(ConnectivityResult result) {
    final hasInternet = result != ConnectivityResult.none;
    final message = hasInternet
      ? 'You have again ${result.toString()}'
      : 'You have no internet';
    final color = hasInternet ? Colors.green : Colors.red;

    Utils.showTopSnackBar(context, message, color);
  }
}