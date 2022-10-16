import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

const String connectionStatusOFF = "Scan for device";
const String connectionStatusFounded = "Vehicle Disconnected";
const String connectionStatusCONNECT = "Vehicle Connected";
Uuid serviceUuid = Uuid.parse("0000180f-0000-1000-8000-00805f9b34fb");