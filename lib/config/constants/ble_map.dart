import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:location_permissions/location_permissions.dart';

import 'ble_desgin_constants.g.dart';

Map<Uuid, List<Uuid>> bleMap = {
  BLE_SERVICE_ENGINE_UUID: deviceCharacteristic.sublist(0, 6),
  BLE_SERVICE_VEHICLE_UUID: deviceCharacteristic.sublist(6),
};

class OBDChecklist {
  final List<int> data;
  final BleOBDCheckList type;

  OBDChecklist({required this.data, required this.type});
}

class BleStreams {
  BleStreams({
    required FlutterReactiveBle ble,
  }) : _ble = ble;
  final FlutterReactiveBle _ble;
  StreamController<ConnectionStateUpdate> deviceConnectionState =
      StreamController();
  late StreamSubscription<ConnectionStateUpdate> deviceConnectionSub;
  late StreamSubscription<DiscoveredDevice> deviceScanSub;
  void connectToOBD() async {
    deviceScanSub = _ble.scanForDevices(
        withServices: [], scanMode: ScanMode.lowLatency).listen((device) async {
      if (device.name == DEVICE_NAME) {
        await deviceScanSub.cancel();
        deviceConnectionSub =
            _ble.connectToDevice(id: device.id).listen((event) {
          deviceConnectionState.add(event);
        });
      }
    }, onError: () {});
  }

  BleOBDCheckList getOBDEnmum(Uuid characteristicId) {
    if (characteristicId == BLE_ENGINE_RPM_CHARACTERISTIC) {
      return BleOBDCheckList.engineRpmCharacteristic;
    }
    return BleOBDCheckList.engineAirIntakeTempCharacteristic;
  }

  List<Stream<OBDChecklist>> getListStream(String deviceId) {
    List<Stream<OBDChecklist>> listBleStream = [];
    bleMap.forEach((service, characteristicUuids) {
      characteristicUuids.forEach((characteristicUuid) {
        final characteristic = QualifiedCharacteristic(
            serviceId: service,
            characteristicId: characteristicUuid,
            deviceId: deviceId);
        final checkListType = getOBDEnmum(characteristicUuid);
        listBleStream
            .add(_ble.subscribeToCharacteristic(characteristic).map((event) {
          return OBDChecklist(data: event, type: checkListType);
        }));
      });
    });
    return listBleStream;
  }
}
