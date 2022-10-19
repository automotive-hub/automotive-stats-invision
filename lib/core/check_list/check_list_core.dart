import 'dart:async';

import '../../config/constants/ble_desgin_constants.g.dart';
import 'check_list_model.dart';

class CheckListCore {
  // https://www.vanchevrolet.com/blog/2017/june/19/a-guide-to-your-cars-temperature-gauge-whats-normal-and-whats-not.htm#:~:text=So%20what's%20a%20normal%20temperature,the%20middle%20of%20your%20gauge.
  int normalTemp = 220;
  int distanceTarget = 5;
  Map<BleOBDCheckList, DataRaw> dataRawStream = {};
  Map<CheckListName, StreamController<Check>> checkList = {};

  // ----- control function ----
  void createCheckListStore() {
    dataRawStream = {
      for (var value in BleOBDCheckList.values)
        value: DataRaw(
          characteristicName: value.name,
        )
    };
    checkList = {
      for (var checkListName in CheckListName.values)
        checkListName: StreamController<Check>.broadcast()
    };
  }

  void start() {
    processingData();
  }

  void closeAllStream() {
    dataRawStream.forEach((key, value) {
      value.closeStream();
    });
  }

  // ----- help function ----
  void addCheckListData(BleOBDCheckList characteristic, dynamic checkListData) {
    dataRawStream[characteristic]!.addDataToStore(checkListData);
  }

  void processingData() {
    listenDistance();
    listenTempOverHeat();
  }

  // ---- check list implementation ----

  void listenDistance() {
    DataRaw dataRaw = dataRawStream[BleOBDCheckList
        .vehicleDistanceTraveledSinceCodesClearedCharacteristic]!;

    dataRaw.dataController.stream.listen((distanceNew) {
      if (dataRaw.store.length >= 2) {
        var distanceInit = dataRaw.store.first;
        var distanceTraveled = distanceNew - distanceInit;
        if (distanceTraveled >= distanceTarget) {
          checkList[CheckListName.distance]!.sink.add(Check(
              name: CheckListName.distance.name,
              status: CheckListStatus.success,
              value: distanceTraveled));

          analyze5km();
        } else {
          checkList[CheckListName.distance]!.sink.add(Check(
              name: CheckListName.distance.name,
              status: CheckListStatus.processing,
              value: distanceTraveled));
        }
      }
    });
  }

  void listenTempOverHeat() async {
    dataRawStream[BleOBDCheckList.engineCoolantTemperatureCharacteristic]!
        .dataController
        .stream
        .listen((newTemp) {
      CheckListStatus status;
      if (newTemp > normalTemp) {
        status = CheckListStatus.failed;
      } else {
        status = CheckListStatus.processing;
      }
      checkList[CheckListName.overHeat]!.sink.add(Check(
          name: CheckListName.overHeat.name, status: status, value: newTemp));
    });
  }

  // --- static function ---
  void analyze5km() {
    bool isOverHeat = checkTempOverHeat();
    if (isOverHeat) {
      checkList[CheckListName.overHeat]!.sink.add(Check(
          name: CheckListName.overHeat.name,
          status: CheckListStatus.failed,
          value: dataRawStream[
                  BleOBDCheckList.engineCoolantTemperatureCharacteristic]!
              .store
              .last));
    } else {
      checkList[CheckListName.overHeat]!.sink.add(Check(
          name: CheckListName.overHeat.name,
          status: CheckListStatus.success,
          value: dataRawStream[
                  BleOBDCheckList.engineCoolantTemperatureCharacteristic]!
              .store
              .last));
    }
  }

  bool checkTempOverHeat() {
    return dataRawStream[
            BleOBDCheckList.engineCoolantTemperatureCharacteristic]!
        .store
        .any((temp) => temp > normalTemp);
  }
}
