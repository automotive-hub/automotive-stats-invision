import 'package:automotive_stats_invision/config/constants/ble_desgin_constants.g.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
import 'dart:async';

class CheckListService {

  Map<String, CheckList> checkListStore = {};

  void createCheckListStore() {
    checkListStore = {
      for (var key in deviceServices)
        '$key': CheckList(
          name: key,
        )
    };
  }

  void addCheckListData(String serviceUuid, dynamic checkListData) {
    checkListStore[serviceUuid]!.addDataToStore(checkListData);
  }


}

class CheckList {
  Uuid name;
  List<dynamic> store = [];
  CheckListStatus _status = CheckListStatus.failed;

  StreamController dataController = StreamController<dynamic>();
  Stream get dataStream => dataController.stream;

  CheckList({
    required this.name,
  });

  CheckListStatus get status => _status;

  setStatus(CheckListStatus checkListStatus) {
    _status = checkListStatus;
  }

  addDataToStore(dynamic data) {
    // store
    store.add(data);

    // sink
    dataController.sink.add(data);

    // calculate
    _processingData();
  }

  _processingData() {}
}

enum CheckListStatus { processing, failed, success }
