import 'package:check_internet/my_connectivity.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';



void main() {
  runApp(NetConnect());
}

class NetConnect extends StatelessWidget {
  const NetConnect({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeNetwork(),
    );
  }
}

class HomeNetwork extends StatefulWidget {
  const HomeNetwork({Key? key}) : super(key: key);

  @override
  State<HomeNetwork> createState() => _HomeNetworkState();
}

class _HomeNetworkState extends State<HomeNetwork> {
  Map _source = {ConnectivityResult.none : false};
  final MyConnectivity _connectivity = MyConnectivity.instance;

  @override
  void initState() {
    super.initState();

    _connectivity.initialise();
    _connectivity.myStream.listen((source) {
      setState(() => _source = source);
    });
  }

  @override
  void dispose() {
    super.dispose();

    _connectivity.disposeStream();
  }
  
  @override
  Widget build(BuildContext context) {
    String string;
    switch (_source.keys.toList()[0]) {
      case ConnectivityResult.mobile :
      string = 'Mobile Internet is using';
      break;
      case ConnectivityResult.wifi :
      string = 'WiFi is using';
      break;
      case ConnectivityResult.none :
      default :
      string = 'No internet connection';
    }
    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(string),
        centerTitle: true,
      ),
    );
  }
}