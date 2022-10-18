import '../screens/main_screen.dart';

class CheckListItem {
  ItemCheckListStatus status;
  String title;
  String logs;

  CheckListItem(
      {required this.logs, required this.status, required this.title});
}
