import 'dart:async';
import 'dart:io' show Platform;

import 'package:automotive_stats_invision/widgets/EngineStatusButton.dart';
import 'package:automotive_stats_invision/widgets/MainBoard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:location_permissions/location_permissions.dart';

import '../config/constants/ble_desgin_constants.g.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Some state management stuff
  bool _foundDeviceWaitingToConnect = false;
  bool _scanStarted = false;
  bool _connected = false;

// Bluetooth related variables
  late DiscoveredDevice _ubiqueDevice;
  late Future<List<DiscoveredService>> Function(String deviceId)
      bleDiscoverServices;
  late List<String> list = [];
  List<DiscoveredService> discoveredServices = [];
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<DiscoveredDevice> _scanStream;
  late QualifiedCharacteristic _rxCharacteristic;
  late DiscoveredService discoveredService;
  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();

// These are the UUIDs of your device
  final Uuid serviceUuid = Uuid.parse("0000180f-0000-1000-8000-00805f9b34fb");

  Future<List<DiscoveredService>> discoverServices(String deviceId) async {
    try {
      final result = await bleDiscoverServices(deviceId);
      return result;
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<void> _startScan() async {
// Platform permissions handling stuff
    bool permGranted = false;
    setState(() {
      _scanStarted = true;
    });
    PermissionStatus permission;
    if (Platform.isAndroid) {
      permission = await LocationPermissions().requestPermissions();
      if (permission == PermissionStatus.granted) permGranted = true;
    } else if (Platform.isIOS) {
      permGranted = true;
    }
// Main scanning logic happens here ⤵️
    if (permGranted) {
      _scanStream = flutterReactiveBle
          .scanForDevices(withServices: [serviceUuid]).listen((device) async {
        // Change this string to what you defined in Zephyr
        print(device);
        if (device.name == DEVICE_NAME) {
          setState(() {
            _ubiqueDevice = device;
            _foundDeviceWaitingToConnect = true;
          });
          await _scanStream.cancel();
        }
      });
    }
  }

  late StreamSubscription<ConnectionStateUpdate> _connection;

  Future<void> connect() async {
    _connection =
        flutterReactiveBle.connectToDevice(id: _ubiqueDevice.id).listen(
      (update) {
        _deviceConnectionController.add(update);
        switch (update.connectionState) {
          // We're connected and good to go!
          case DeviceConnectionState.connected:
            {
              setState(() {
                _connected = true;
              });
              break;
            }
          // Can add various state state updates on disconnect
          case DeviceConnectionState.disconnected:
            {
              break;
            }
          default:
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xff2c3036),
      body: Container(
        margin: EdgeInsets.symmetric(
            vertical: size.height * 0.05, horizontal: size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Vehicle Connected  ',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Icon(
                  Icons.circle,
                  size: 15,
                  color: Color(0xff34c759),
                )
              ],
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            GestureDetector(
              onTap: _scanStarted
                  ? _connected
                      ? null
                      : () async {
                          await connect();
                        }
                  : () async {
                      await _startScan();
                    },
              child: EngineStatusButton(
                color: _foundDeviceWaitingToConnect
                    ? _connected
                        ? Color(0xff25CB55)
                        : Colors.red
                    : Colors.black,
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            MainBoard(),
          ],
        ),
      ),
    );
  }
}
