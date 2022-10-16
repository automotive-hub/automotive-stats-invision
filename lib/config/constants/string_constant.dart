import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

const String connectionStatusOFF = "Scan for device";
const String connectionStatusFounded = "Vehicle Disconnected";
const String connectionStatusCONNECT = "Vehicle Connected";
Uuid serviceUuid = Uuid.parse("0000180f-0000-1000-8000-00805f9b34fb");
Uuid BLE_CHARACTERISTIC_1 = Uuid.parse("b3bad50b-91e6-4ae2-8ed6-9e35ee5d258d");
Uuid BLE_CHARACTERISTIC_2 = Uuid.parse("821b25ca-37a9-4e20-940c-170496c9446d");
Uuid BLE_CHARACTERISTIC_3 = Uuid.parse("d7c50612-a2f4-4d35-b7fa-1b9f26968fd1");



List<Uuid> deviceServices = [BLE_CHARACTERISTIC_1,BLE_CHARACTERISTIC_2,BLE_CHARACTERISTIC_3,];