import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_task/Network/apiService.dart';
import 'package:flutter_task/Screens/profile_screen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var url='https://picsum.photos/seed/572/600';

  static const platform = MethodChannel('arivalagan/bluetoothChannel');
  Future<void> checkAndEnableBluetooth() async {

    bool? response;
    try {
      response = await platform.invokeMethod('checkBluetooth');
      debugPrint("Bluetooth enable response $response");
    } on PlatformException catch (e) {
      debugPrint("Exception $e");
    }
    // setState(() {
    //
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

          appBar: AppBar(
            title: const Text('Flutter Task'),

          ),
          body: Center(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),

                    child: Image.network(url),

                  ),
                  Container(
                    margin: const EdgeInsets.all(25),
                    child: ElevatedButton(
                      onPressed: () {
                        _getData();
                      },
                      child: const Text('Image'),
                    )
                  ),

                  Container(
                      margin: const EdgeInsets.all(25),
                      child: ElevatedButton(
                        onPressed: () {
                          checkAndEnableBluetooth();
                        },
                        child: const Text('Enable Bluetooth'),
                      )
                  ),

                  Container(
                      margin: const EdgeInsets.all(25),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context) =>const ProfileScreen()));
                        },
                        child: const Text('Profile'),
                      )
                  ),
                ]),
              ))),
    );
  }
  void _getData() async {
    var apiResponse = await ApiService().getDogImage();

    var jsonString = json.decode(apiResponse!);
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {
      url=jsonString["message"];
    }));
  }
  }

