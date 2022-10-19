import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'package:location_permissions/location_permissions.dart';
import 'package:rxdart/subjects.dart';

import '../config/constants/ble_desgin_constants.g.dart';

Map<Uuid, List<Uuid>> bleMap = {
  BLE_SERVICE_ENGINE_UUID: deviceCharacteristic.sublist(0, 6),
  BLE_SERVICE_VEHICLE_UUID: deviceCharacteristic.sublist(6),
};

class OBDChecklist {
  final List<int> data;
  final BleOBDCheckList type;

  OBDChecklist({required this.data, required this.type});
}

class BleRepository {
  BleRepository({
    required this.ble,
  });
  final FlutterReactiveBle ble;
  BehaviorSubject<DeviceConnectionState> deviceConnectionState =
      BehaviorSubject();
  late StreamSubscription<ConnectionStateUpdate> _deviceConnectionSub;
  late StreamSubscription<DiscoveredDevice> _deviceScanSub;
  BehaviorSubject<OBDChecklist> obd2ReaderState = BehaviorSubject();
  final List<StreamSubscription> _listObdCharacteristicStream = [];

  Future<void> connectToOBD() async {
    _deviceScanSub =
        ble.scanForDevices(withServices: []).listen((device) async {
      if (device.name == DEVICE_NAME) {
        print(device.name);
        await _deviceScanSub.cancel();
        _deviceConnectionSub =
            ble.connectToDevice(id: device.id).listen((event) {
          deviceConnectionState.add(event.connectionState);
          print(event.connectionState);
          if (event.connectionState == DeviceConnectionState.connected) {
            _listObdCharacteristicStream.clear();
            List<Stream<OBDChecklist>> listOBDStream = getListStream(device.id);
            listOBDStream.forEach((obdStream) {
              _listObdCharacteristicStream.add(obdStream.listen((event) {
                obd2ReaderState.add(event);

                ///
                /// OBDChecklist Class
                // CALL TO CHECKLIST SERVICE
                print(event.type.toString() +
                    "\t" +
                    String.fromCharCodes(event.data));
              }));
            });
          }
        });
      }
    });
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
            .add(ble.subscribeToCharacteristic(characteristic).map((event) {
          return OBDChecklist(data: event, type: checkListType);
        }));
      });
    });
    return listBleStream;
  }
}
