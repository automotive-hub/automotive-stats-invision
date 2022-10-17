void _startScan() async {
Platform permissions handling stuff
Some state management stuff
  bool _foundDeviceWaitingToConnect = false;
  bool _scanStarted = false;
  bool _connected = false;

// Bluetooth related variables
  late DiscoveredDevice _ubiqueDevice;
  late Future<List<DiscoveredService>> Function(String deviceId)
      bleDiscoverServices;
   List<String> list = ["0","0","0"];
  List<DiscoveredService> discoveredServices = [];
  final flutterReactiveBle = FlutterReactiveBle();
  late StreamSubscription<DiscoveredDevice> _scanStream;
  late QualifiedCharacteristic _rxCharacteristic;
  late DiscoveredService discoveredService;
  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();

// These are the UUIDs of your device

  Future<List<DiscoveredService>> discoverServices(String deviceId) async {
    try {
      final result = await bleDiscoverServices(deviceId);
      return result;
    } on Exception catch (e) {
      rethrow;
    }
  }
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
        if (device.name == 'ESP32-OBD2-BLE') {
          // print(device);
          discoveredServices =
              await flutterReactiveBle.discoverServices(device.id);
          setState(() {
            _ubiqueDevice = device;
            _foundDeviceWaitingToConnect = true;
          });
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
    print(discoveredServices);
    List<QualifiedCharacteristic> list1 = [];
    for (int g = 0; g < 3; g++) {
      final characteristic = QualifiedCharacteristic(
          serviceId: Uuid.parse("8a40e28c-e92a-4406-874e-4f71a21f69db"),
          characteristicId: deviceServices[g],
          deviceId: _ubiqueDevice.id);
      list1.add(characteristic);
      flutterReactiveBle.subscribeToCharacteristic(list1[g]).listen((event) {
        setState(() {
         list[g] = String.fromCharCodes(event);
        });
        print(list);
      });
    }
  }

  Future<void> disconnect() async {
    try {
      await _connection.cancel();
    } on Exception catch (e, _) {
    } finally {
      // Since [_connection] subscription is terminated, the "disconnected" state cannot be received and propagated
      _deviceConnectionController.add(
        ConnectionStateUpdate(
          deviceId: _ubiqueDevice.id,
          connectionState: DeviceConnectionState.disconnected,
          failure: null,
        ),
      );
      setState(() {
        _connected = false;
      });
    }
  }