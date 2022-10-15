import 'dart:async';
import 'dart:io';

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

class BleDeviceConnector {
  BleDeviceConnector({
    required FlutterReactiveBle ble,
  })  : _ble = ble;

  final FlutterReactiveBle _ble;

  @override
  Stream<ConnectionStateUpdate> get state => _deviceConnectionController.stream;

  final _deviceConnectionController = StreamController<ConnectionStateUpdate>();

  // ignore: cancel_subscriptions
  late StreamSubscription<ConnectionStateUpdate> _connection;

  Future<bool> connect(String deviceId) async {
    bool result = false;
    _connection = _ble.connectToDevice(id: deviceId).listen(
      (update) {
        _deviceConnectionController.add(update);
        result=true;
      },
    );
    return result;
  }

  Future<void> disconnect(String deviceId) async {
    try {
      await _connection.cancel();
    } on Exception catch (e, _) {
    } finally {
      // Since [_connection] subscription is terminated, the "disconnected" state cannot be received and propagated
      _deviceConnectionController.add(
        ConnectionStateUpdate(
          deviceId: deviceId,
          connectionState: DeviceConnectionState.disconnected,
          failure: null,
        ),
      );
    }
  }

  Future<void> dispose() async {
    await _deviceConnectionController.close();
  }
}
