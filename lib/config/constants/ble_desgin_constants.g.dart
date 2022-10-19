//THIS IS GENERATED IN ble_uuid_conf.yml
//Generate in git submodule (ble_devices) -> ble_uuid+generator.py
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

// ignore_for_file: non_constant_identifier_names
Uuid BLE_SERVICE_ENGINE_UUID =
    Uuid.parse("8A40E28C-E92A-4406-874E-4F71A21F69DB");

Uuid BLE_ENGINE_RPM_CHARACTERISTIC =
    Uuid.parse("821B25CA-37A9-4E20-940C-170496C9446D");

Uuid BLE_ENGINE_SPEED_METER_CHARACTERISTIC =
    Uuid.parse("B3BAD50B-91E6-4AE2-8ED6-9E35EE5D258D");

Uuid BLE_ENGINE_AIR_INTAKE_TEMP_CHARACTERISTIC =
    Uuid.parse("AD667745-DD87-470D-A76A-976F68500C5B");

Uuid BLE_ENGINE_LOAD_CHARACTERISTIC =
    Uuid.parse("D7C50612-A2F4-4D35-B7FA-1B9F26968FD1");

Uuid BLE_ENGINE_COOLANT_TEMPERATURE_CHARACTERISTIC =
    Uuid.parse("A78BDDC4-4D02-11ED-BDC3-0242AC120002");

Uuid BLE_ENGINE_OIL_TEMPERATURE_CHARACTERISTIC =
    Uuid.parse("A78BE094-4D02-11ED-BDC3-0242AC120002");

Uuid BLE_SERVICE_VEHICLE_UUID =
    Uuid.parse("A78BE2BA-4D02-11ED-BDC3-0242AC120002");

Uuid BLE_VEHICLE_SPEED_CHARACTERISTIC =
    Uuid.parse("A78BE42C-4D02-11ED-BDC3-0242AC120002");

Uuid BLE_VEHICLE_TIME_RUN_WITH_MIL_ON_CHARACTERISTIC =
    Uuid.parse("A78BE8E6-4D02-11ED-BDC3-0242AC120002");

Uuid BLE_VEHICLE_TIME_SINCE_CODES_CLEARED_CHARACTERISTIC =
    Uuid.parse("A78BEA42-4D02-11ED-BDC3-0242AC120002");

Uuid BLE_VEHICLE_DISTANCE_TRAVELED_WITH_MIL_ON_CHARACTERISTIC =
    Uuid.parse("A78BEB84-4D02-11ED-BDC3-0242AC120002");

Uuid BLE_VEHICLE_DISTANCE_TRAVELED_SINCE_CODES_CLEARED_CHARACTERISTIC =
    Uuid.parse("A78BEA44-4D02-11ED-BDC3-0242AC120002");

List<Uuid> deviceServices = [
  BLE_SERVICE_ENGINE_UUID,
  BLE_SERVICE_VEHICLE_UUID,
];
const String DEVICE_NAME = "ESP32-OBD2-BLE";

enum BleOBDCheckList {
  engineRpmCharacteristic,
  engineSpeedMeterCharacteristic,
  engineAirIntakeTempCharacteristic,
  engineLoadCharacteristic,
  engineCoolantTemperatureCharacteristic,
  engineOilTemperatureCharacteristic,
  vehicleSpeedCharacteristic,
  vehicleTimeRunWithMilOnCharacteristic,
  vehicleTimeSinceCodesClearedCharacteristic,
  vehicleDistanceTraveledWithMilOnCharacteristic,
  vehicleDistanceTraveledSinceCodesClearedCharacteristic
}

List<Uuid> deviceCharacteristic = [
  BLE_ENGINE_RPM_CHARACTERISTIC,
  BLE_ENGINE_SPEED_METER_CHARACTERISTIC,
  BLE_ENGINE_AIR_INTAKE_TEMP_CHARACTERISTIC,
  BLE_ENGINE_LOAD_CHARACTERISTIC,
  BLE_ENGINE_COOLANT_TEMPERATURE_CHARACTERISTIC,
  BLE_ENGINE_OIL_TEMPERATURE_CHARACTERISTIC,
  BLE_VEHICLE_SPEED_CHARACTERISTIC,
  BLE_VEHICLE_TIME_RUN_WITH_MIL_ON_CHARACTERISTIC,
  BLE_VEHICLE_TIME_SINCE_CODES_CLEARED_CHARACTERISTIC,
  BLE_VEHICLE_DISTANCE_TRAVELED_WITH_MIL_ON_CHARACTERISTIC,
  BLE_VEHICLE_DISTANCE_TRAVELED_SINCE_CODES_CLEARED_CHARACTERISTIC,
];
BleOBDCheckList getOBDEnmum(Uuid characteristicId) {
  if (characteristicId == BLE_ENGINE_RPM_CHARACTERISTIC) {
    return BleOBDCheckList.engineRpmCharacteristic;
  }

  if (characteristicId == BLE_ENGINE_SPEED_METER_CHARACTERISTIC) {
    return BleOBDCheckList.engineSpeedMeterCharacteristic;
  }

  if (characteristicId == BLE_ENGINE_AIR_INTAKE_TEMP_CHARACTERISTIC) {
    return BleOBDCheckList.engineAirIntakeTempCharacteristic;
  }

  if (characteristicId == BLE_ENGINE_LOAD_CHARACTERISTIC) {
    return BleOBDCheckList.engineLoadCharacteristic;
  }

  if (characteristicId == BLE_ENGINE_COOLANT_TEMPERATURE_CHARACTERISTIC) {
    return BleOBDCheckList.engineCoolantTemperatureCharacteristic;
  }

  if (characteristicId == BLE_ENGINE_OIL_TEMPERATURE_CHARACTERISTIC) {
    return BleOBDCheckList.engineOilTemperatureCharacteristic;
  }

  if (characteristicId == BLE_VEHICLE_SPEED_CHARACTERISTIC) {
    return BleOBDCheckList.vehicleSpeedCharacteristic;
  }

  if (characteristicId == BLE_VEHICLE_TIME_RUN_WITH_MIL_ON_CHARACTERISTIC) {
    return BleOBDCheckList.vehicleTimeRunWithMilOnCharacteristic;
  }

  if (characteristicId == BLE_VEHICLE_TIME_SINCE_CODES_CLEARED_CHARACTERISTIC) {
    return BleOBDCheckList.vehicleTimeSinceCodesClearedCharacteristic;
  }

  if (characteristicId ==
      BLE_VEHICLE_DISTANCE_TRAVELED_WITH_MIL_ON_CHARACTERISTIC) {
    return BleOBDCheckList.vehicleDistanceTraveledWithMilOnCharacteristic;
  }

  if (characteristicId ==
      BLE_VEHICLE_DISTANCE_TRAVELED_SINCE_CODES_CLEARED_CHARACTERISTIC) {
    return BleOBDCheckList
        .vehicleDistanceTraveledSinceCodesClearedCharacteristic;
  }

  return BleOBDCheckList.engineAirIntakeTempCharacteristic;
}
