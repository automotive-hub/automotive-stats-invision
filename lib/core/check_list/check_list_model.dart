import 'dart:async';

class DataRaw {
  String characteristicName;
  List<dynamic> store = [];
  late StreamController dataController = StreamController<dynamic>.broadcast();
  Stream get dataStream => dataController.stream;
  DataRaw({
    required this.characteristicName,
  });
  addDataToStore(dynamic data) {
    // store
    store.add(data);
    // sink
    dataController.sink.add(data);
  }
  closeStream() {
    dataController.close();
  }
}

class Check {
  final String name;
  final CheckListStatus status;
  final dynamic value;
  Check({
    required this.name,
    this.status = CheckListStatus.failed,
    this.value,
  });
}

enum CheckListStatus { processing, failed, success }

enum CheckListName{
  distance,
  overHeat,
  analyze_5km,
}